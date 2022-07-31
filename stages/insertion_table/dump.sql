--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- Name: ddm(character varying, integer, integer, integer); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION ddm(fab character varying, jour integer, mois integer, annee integer) RETURNS character varying
    LANGUAGE plpgsql
    AS $$DECLARE
 d1 text;
 d2 text;
 test integer;
BEGIN
 d1 := concat (to_char(fab::timestamp ,'YYYY'),'-01-01');
 d2 := to_char(d1::timestamp + interval '1 year' * annee,'YYYY-MM-DD');
 
 d2 := to_char(d2::timestamp + interval '1 month' * mois,'YYYY-MM-DD');
 d2 := to_char(d2::timestamp + interval '1 month' * to_char(fab::timestamp,'mm')::integer,'YYYY-MM-DD');
 d2 := to_char(d2::timestamp - interval '1 month' ,'YYYY-MM-DD');

 d2 := to_char(d2::timestamp + interval '1 day' * jour,'YYYY-MM-DD');
 d2 := to_char(d2::timestamp + interval '1 day' * to_char(fab::timestamp,'dd')::integer,'YYYY-MM-DD');
 d2 := to_char(d2::timestamp - interval '1 day' ,'YYYY-MM-DD');

 test := case when jour!=0 or to_char(fab::timestamp, 'dd') = to_char(d2::timestamp, 'dd') then to_char(d2::timestamp, 'dd')::integer else 1 END;

 RETURN concat(to_char(test,'FM09'),to_char(d2::timestamp,'MMYY'));
END;
$$;


ALTER FUNCTION public.ddm(fab character varying, jour integer, mois integer, annee integer) OWNER TO root;

--
-- Name: freinte(integer, integer); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION freinte(pds_reel integer, pds_theo integer) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
BEGIN
 RETURN case when pds_theo > 0 then concat(round(1.00*(pds_reel-pds_theo)/pds_theo*100, 2),' %') else ' ' END;
END;
$$;


ALTER FUNCTION public.freinte(pds_reel integer, pds_theo integer) OWNER TO root;

--
-- Name: kilo(integer, integer); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION kilo(poids integer, arrondi integer) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
BEGIN
 RETURN concat(round(1.00*poids/1000, arrondi),' kg');
END;
$$;


ALTER FUNCTION public.kilo(poids integer, arrondi integer) OWNER TO root;

--
-- Name: madate(character varying); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION madate(valeur character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
DECLARE
 d1 text;
BEGIN
 d1 := LPAD(valeur,6,'0');
 d1 := concat(substr(d1,1,2),'/',substr(d1,3,2),'/',substr(d1,5,2));
 RETURN d1;
END;
$$;


ALTER FUNCTION public.madate(valeur character varying) OWNER TO root;

--
-- Name: maj_tareglo(); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION maj_tareglo() RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
update article set tareglo = tareglo_etiquette(codart);
update statprod set tareglo = tareglo_etiquette(codart), pdsmin = pdsmin(codart), pdsmax = pdsmax(codart);
END;
$$;


ALTER FUNCTION public.maj_tareglo() OWNER TO root;

--
-- Name: maj_tbct(); Type: FUNCTION; Schema: public; Owner: doux
--

CREATE FUNCTION maj_tbct() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	IF NEW.etatmarq != OLD.etatmarq THEN		
		UPDATE TB_CTRL_PES
		set hhmmsscc = now() ;
	END IF;
	RETURN NEW;
 END;
$$;


ALTER FUNCTION public.maj_tbct() OWNER TO doux;

--
-- Name: pdsmax(character varying); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION pdsmax(process character varying) RETURNS smallint
    LANGUAGE plpgsql
    AS $$
BEGIN
RETURN case when tareglo_produit((select id_article from article where codart = process))=0 then 0 else tareglo_produit((select id_article from article where codart = process))+(select pdstheo+fourch_plus from article where codart = process)END;
END;
$$;


ALTER FUNCTION public.pdsmax(process character varying) OWNER TO root;

--
-- Name: pdsmin(character varying); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION pdsmin(process character varying) RETURNS smallint
    LANGUAGE plpgsql
    AS $$
BEGIN
RETURN case when tareglo_produit((select id_article from article where codart = process))=0 then 0 else tareglo_produit((select id_article from article where codart = process))+(select pdstheo-fourch_moins from article where codart = process)END;
END;
$$;


ALTER FUNCTION public.pdsmin(process character varying) OWNER TO root;

--
-- Name: tareglo_etiquette(character varying); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION tareglo_etiquette(process character varying) RETURNS smallint
    LANGUAGE plpgsql
    AS $$
BEGIN
RETURN tareglo_produit((select id_article from article where codart = process));
END;
$$;


ALTER FUNCTION public.tareglo_etiquette(process character varying) OWNER TO root;

--
-- Name: tareglo_produit(integer); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION tareglo_produit(id1 integer) RETURNS smallint
    LANGUAGE plpgsql
    AS $$
BEGIN
 RETURN cart.pdscart + cal.tare_dyn + art.nbpiece * art.tare_p
from article art
left join cartons cart on cart.idcart = art.idcart
left join calibre cal on cal.codcal=art.codcal
where id_article=id1;
END;
$$;


ALTER FUNCTION public.tareglo_produit(id1 integer) OWNER TO root;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: arch_stat; Type: TABLE; Schema: public; Owner: doux; Tablespace: 
--

CREATE TABLE arch_stat (
    numarch integer NOT NULL,
    codart character(8) NOT NULL,
    nbbons integer DEFAULT 0,
    pdsbons integer DEFAULT 0,
    nbrejet integer DEFAULT 0,
    pdsrejet integer DEFAULT 0,
    pdsmax smallint DEFAULT 30999,
    pdsmin smallint DEFAULT 0,
    tareglo smallint DEFAULT 0,
    codeprod character(4) DEFAULT '    '::bpchar NOT NULL,
    valcal smallint DEFAULT 0,
    message1 character varying(42) DEFAULT ' '::character varying,
    message2 character varying(42) DEFAULT ' '::character varying,
    hhmm_arch time without time zone DEFAULT now() NOT NULL,
    date_arch date DEFAULT ('now'::text)::date,
    lot character varying(10) DEFAULT ' '::character varying
);


ALTER TABLE public.arch_stat OWNER TO doux;

--
-- Name: arch_stat_numarch_seq; Type: SEQUENCE; Schema: public; Owner: doux
--

CREATE SEQUENCE arch_stat_numarch_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.arch_stat_numarch_seq OWNER TO doux;

--
-- Name: arch_stat_numarch_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: doux
--

ALTER SEQUENCE arch_stat_numarch_seq OWNED BY arch_stat.numarch;


--
-- Name: article; Type: TABLE; Schema: public; Owner: doux; Tablespace: 
--

CREATE TABLE article (
    id_article integer NOT NULL,
    codart character(8) NOT NULL,
    idcodprod smallint NOT NULL,
    codcal smallint NOT NULL,
    datart date DEFAULT '2016-08-02'::date,
    nbpiece smallint DEFAULT 1,
    pdstheo integer DEFAULT 0,
    fourch_plus smallint NOT NULL,
    fourch_moins smallint NOT NULL,
    msgtete1 character varying(18) DEFAULT ' '::character varying,
    idmsgtete2 smallint,
    tare_p smallint DEFAULT 1,
    idcart smallint DEFAULT 1,
    tareglo smallint DEFAULT 1,
    tunnel smallint DEFAULT 1,
    selection smallint DEFAULT 0,
    couvercle smallint DEFAULT 0,
    metal smallint DEFAULT 0
);


ALTER TABLE public.article OWNER TO doux;

--
-- Name: article_id_article_seq; Type: SEQUENCE; Schema: public; Owner: doux
--

CREATE SEQUENCE article_id_article_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.article_id_article_seq OWNER TO doux;

--
-- Name: article_id_article_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: doux
--

ALTER SEQUENCE article_id_article_seq OWNED BY article.id_article;


--
-- Name: statprod; Type: TABLE; Schema: public; Owner: apache; Tablespace: 
--

CREATE TABLE statprod (
    numstat integer NOT NULL,
    codart character(8) NOT NULL,
    nbbons integer DEFAULT 0,
    nbtmp integer DEFAULT 0,
    pdsbons integer DEFAULT 0,
    pdstmp integer DEFAULT 0,
    nbrejet integer DEFAULT 0,
    pdsrejet integer DEFAULT 0,
    pdsmax smallint DEFAULT 30999,
    pdsmin smallint DEFAULT 0,
    tareglo smallint DEFAULT 0,
    stop smallint DEFAULT 0,
    erp integer DEFAULT 0,
    hhmmss_maq time without time zone DEFAULT now() NOT NULL,
    hhmmss_api time without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.statprod OWNER TO apache;

--
-- Name: automate; Type: VIEW; Schema: public; Owner: doux
--

CREATE VIEW automate AS
    SELECT statprod.codart, statprod.pdsmax, statprod.pdsmin, statprod.tareglo, article.tunnel, article.metal FROM statprod, article WHERE ((statprod.codart = article.codart) AND (statprod.stop = 0)) ORDER BY statprod.numstat;


ALTER TABLE public.automate OWNER TO doux;

--
-- Name: chargement; Type: TABLE; Schema: public; Owner: root; Tablespace: 
--

CREATE TABLE chargement (
    codart character(8),
    pdsmin smallint,
    pdsmax smallint,
    msgtete1 character(25),
    idmsgtete2 integer,
    resbloc1 character(42),
    libmess_2 character(42),
    resbloc3 character(42),
    lot character(10),
    police smallint,
    tareglo smallint,
    tunnel smallint,
    metal smallint
);


ALTER TABLE public.chargement OWNER TO root;

--
-- Name: automate2; Type: VIEW; Schema: public; Owner: root
--

CREATE VIEW automate2 AS
    SELECT charg.codart, charg.pdsmax, charg.pdsmin, charg.tareglo, charg.tunnel, charg.metal FROM chargement charg;


ALTER TABLE public.automate2 OWNER TO root;

--
-- Name: caldate; Type: TABLE; Schema: public; Owner: doux; Tablespace: 
--

CREATE TABLE caldate (
    numdate integer NOT NULL,
    libdate character varying(30) DEFAULT ''::character varying,
    modcal smallint DEFAULT 0,
    modimp smallint DEFAULT 0,
    nb smallint DEFAULT 0,
    jour character(1) DEFAULT 0,
    mois character(1) DEFAULT 0,
    annee character(1) DEFAULT 0
);


ALTER TABLE public.caldate OWNER TO doux;

--
-- Name: caldate_numdate_seq; Type: SEQUENCE; Schema: public; Owner: doux
--

CREATE SEQUENCE caldate_numdate_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.caldate_numdate_seq OWNER TO doux;

--
-- Name: caldate_numdate_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: doux
--

ALTER SEQUENCE caldate_numdate_seq OWNED BY caldate.numdate;


--
-- Name: calibre; Type: TABLE; Schema: public; Owner: doux; Tablespace: 
--

CREATE TABLE calibre (
    idcalibre integer NOT NULL,
    codcal smallint NOT NULL,
    valcal smallint DEFAULT 0,
    code character(1),
    tare_dyn integer DEFAULT 0
);


ALTER TABLE public.calibre OWNER TO doux;

--
-- Name: COLUMN calibre.tare_dyn; Type: COMMENT; Schema: public; Owner: doux
--

COMMENT ON COLUMN calibre.tare_dyn IS 'difference entre balance dynamique et statique';


--
-- Name: calibre_idcalibre_seq; Type: SEQUENCE; Schema: public; Owner: doux
--

CREATE SEQUENCE calibre_idcalibre_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.calibre_idcalibre_seq OWNER TO doux;

--
-- Name: calibre_idcalibre_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: doux
--

ALTER SEQUENCE calibre_idcalibre_seq OWNED BY calibre.idcalibre;


--
-- Name: cartons; Type: TABLE; Schema: public; Owner: doux; Tablespace: 
--

CREATE TABLE cartons (
    idcart integer NOT NULL,
    libcart character(4) DEFAULT ' '::bpchar,
    pdscart integer DEFAULT 1
);


ALTER TABLE public.cartons OWNER TO doux;

--
-- Name: cartons_idcart_seq; Type: SEQUENCE; Schema: public; Owner: doux
--

CREATE SEQUENCE cartons_idcart_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cartons_idcart_seq OWNER TO doux;

--
-- Name: cartons_idcart_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: doux
--

ALTER SEQUENCE cartons_idcart_seq OWNED BY cartons.idcart;


--
-- Name: data00; Type: TABLE; Schema: public; Owner: doux; Tablespace: 
--

CREATE TABLE data00 (
    codart character(8) NOT NULL,
    num integer NOT NULL,
    hhmmsscc time without time zone DEFAULT now() NOT NULL,
    pdsnet smallint,
    rejet smallint,
    chaine smallint
);


ALTER TABLE public.data00 OWNER TO doux;

--
-- Name: data00_num_seq; Type: SEQUENCE; Schema: public; Owner: doux
--

CREATE SEQUENCE data00_num_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.data00_num_seq OWNER TO doux;

--
-- Name: data00_num_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: doux
--

ALTER SEQUENCE data00_num_seq OWNED BY data00.num;


--
-- Name: data01; Type: TABLE; Schema: public; Owner: apache; Tablespace: 
--

CREATE TABLE data01 (
    codart character(8) NOT NULL,
    num integer NOT NULL,
    hhmmsscc time without time zone DEFAULT now() NOT NULL,
    pdsnet smallint DEFAULT 0,
    rejet smallint NOT NULL,
    chaine smallint DEFAULT 1 NOT NULL
);


ALTER TABLE public.data01 OWNER TO apache;

--
-- Name: data01_num_seq; Type: SEQUENCE; Schema: public; Owner: apache
--

CREATE SEQUENCE data01_num_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.data01_num_seq OWNER TO apache;

--
-- Name: data01_num_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: apache
--

ALTER SEQUENCE data01_num_seq OWNED BY data01.num;


--
-- Name: data02; Type: TABLE; Schema: public; Owner: apache; Tablespace: 
--

CREATE TABLE data02 (
    codart character(8) NOT NULL,
    num integer NOT NULL,
    hhmmsscc time without time zone DEFAULT now() NOT NULL,
    pdsnet smallint DEFAULT 0,
    rejet smallint NOT NULL,
    chaine smallint DEFAULT 1 NOT NULL
);


ALTER TABLE public.data02 OWNER TO apache;

--
-- Name: data02_num_seq; Type: SEQUENCE; Schema: public; Owner: apache
--

CREATE SEQUENCE data02_num_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.data02_num_seq OWNER TO apache;

--
-- Name: data02_num_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: apache
--

ALTER SEQUENCE data02_num_seq OWNED BY data02.num;


--
-- Name: data03; Type: TABLE; Schema: public; Owner: apache; Tablespace: 
--

CREATE TABLE data03 (
    codart character(8) NOT NULL,
    num integer NOT NULL,
    hhmmsscc time without time zone DEFAULT now() NOT NULL,
    pdsnet smallint DEFAULT 0,
    rejet smallint NOT NULL,
    chaine smallint DEFAULT 1 NOT NULL
);


ALTER TABLE public.data03 OWNER TO apache;

--
-- Name: data03_num_seq; Type: SEQUENCE; Schema: public; Owner: apache
--

CREATE SEQUENCE data03_num_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.data03_num_seq OWNER TO apache;

--
-- Name: data03_num_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: apache
--

ALTER SEQUENCE data03_num_seq OWNED BY data03.num;


--
-- Name: data04; Type: TABLE; Schema: public; Owner: apache; Tablespace: 
--

CREATE TABLE data04 (
    codart character(8) NOT NULL,
    num integer NOT NULL,
    hhmmsscc time without time zone DEFAULT now() NOT NULL,
    pdsnet smallint DEFAULT 0,
    rejet smallint NOT NULL,
    chaine smallint DEFAULT 1 NOT NULL
);


ALTER TABLE public.data04 OWNER TO apache;

--
-- Name: data04_num_seq; Type: SEQUENCE; Schema: public; Owner: apache
--

CREATE SEQUENCE data04_num_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.data04_num_seq OWNER TO apache;

--
-- Name: data04_num_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: apache
--

ALTER SEQUENCE data04_num_seq OWNED BY data04.num;


--
-- Name: data05; Type: TABLE; Schema: public; Owner: apache; Tablespace: 
--

CREATE TABLE data05 (
    codart character(8) NOT NULL,
    num integer NOT NULL,
    hhmmsscc time without time zone DEFAULT now() NOT NULL,
    pdsnet smallint DEFAULT 0,
    rejet smallint NOT NULL,
    chaine smallint DEFAULT 1 NOT NULL
);


ALTER TABLE public.data05 OWNER TO apache;

--
-- Name: data05_num_seq; Type: SEQUENCE; Schema: public; Owner: apache
--

CREATE SEQUENCE data05_num_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.data05_num_seq OWNER TO apache;

--
-- Name: data05_num_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: apache
--

ALTER SEQUENCE data05_num_seq OWNED BY data05.num;


--
-- Name: data06; Type: TABLE; Schema: public; Owner: apache; Tablespace: 
--

CREATE TABLE data06 (
    codart character(8) NOT NULL,
    num integer NOT NULL,
    hhmmsscc time without time zone DEFAULT now() NOT NULL,
    pdsnet smallint DEFAULT 0,
    rejet smallint NOT NULL,
    chaine smallint DEFAULT 1 NOT NULL
);


ALTER TABLE public.data06 OWNER TO apache;

--
-- Name: data06_num_seq; Type: SEQUENCE; Schema: public; Owner: apache
--

CREATE SEQUENCE data06_num_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.data06_num_seq OWNER TO apache;

--
-- Name: data06_num_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: apache
--

ALTER SEQUENCE data06_num_seq OWNED BY data06.num;


--
-- Name: data07; Type: TABLE; Schema: public; Owner: doux; Tablespace: 
--

CREATE TABLE data07 (
    codart character(8) NOT NULL,
    num integer NOT NULL,
    hhmmsscc time without time zone DEFAULT now() NOT NULL,
    pdsnet smallint,
    rejet smallint,
    chaine smallint
);


ALTER TABLE public.data07 OWNER TO doux;

--
-- Name: data07_num_seq; Type: SEQUENCE; Schema: public; Owner: doux
--

CREATE SEQUENCE data07_num_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.data07_num_seq OWNER TO doux;

--
-- Name: data07_num_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: doux
--

ALTER SEQUENCE data07_num_seq OWNED BY data07.num;


--
-- Name: datajour; Type: TABLE; Schema: public; Owner: apache; Tablespace: 
--

CREATE TABLE datajour (
    codart character(8) NOT NULL,
    num integer NOT NULL,
    hhmmsscc time without time zone DEFAULT now() NOT NULL,
    pdsnet smallint DEFAULT 0,
    rejet smallint DEFAULT 0 NOT NULL,
    chaine smallint DEFAULT 1 NOT NULL
);


ALTER TABLE public.datajour OWNER TO apache;

--
-- Name: datajour_num_seq; Type: SEQUENCE; Schema: public; Owner: apache
--

CREATE SEQUENCE datajour_num_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.datajour_num_seq OWNER TO apache;

--
-- Name: datajour_num_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: apache
--

ALTER SEQUENCE datajour_num_seq OWNED BY datajour.num;


--
-- Name: message; Type: TABLE; Schema: public; Owner: doux; Tablespace: 
--

CREATE TABLE message (
    idmessage integer NOT NULL,
    libmess character varying(42) DEFAULT ' '::character varying,
    libmess_2 character varying(42) DEFAULT ' '::character varying,
    police smallint DEFAULT 0,
    libmess_3 character varying(42) DEFAULT ' '::character varying,
    fab character varying(6) DEFAULT ' '::character varying,
    dluo character varying(6) DEFAULT ' '::character varying,
    lot character varying(10) DEFAULT ' '::character varying,
    resbloc1 character varying(42) DEFAULT ' '::character varying,
    resbloc3 character varying(42) DEFAULT ' '::character varying
);


ALTER TABLE public.message OWNER TO doux;

--
-- Name: produit; Type: TABLE; Schema: public; Owner: doux; Tablespace: 
--

CREATE TABLE produit (
    idprod integer NOT NULL,
    codprod character(4) NOT NULL,
    libprod character varying(20) DEFAULT ' '::character varying,
    numdate smallint DEFAULT 1,
    bfrais boolean DEFAULT false,
    bmanuel boolean DEFAULT false,
    bfreinte boolean DEFAULT false,
    proposition integer DEFAULT 0
);


ALTER TABLE public.produit OWNER TO doux;

--
-- Name: montest; Type: VIEW; Schema: public; Owner: doux
--

CREATE VIEW montest AS
    SELECT ('now'::text)::date AS date, to_char(now(), 'HH24:MI:SS'::text) AS heure, st.numstat AS num, st.codart AS codprod, CASE WHEN (length((me.libmess_2)::text) = 0) THEN ("substring"((pr.libprod)::text, 1, 4))::character varying ELSE me.libmess_2 END AS artstk, ca.valcal AS calibre, st.nbbons, st.pdsbons, (st.nbbons * ar.pdstheo) AS "tot theo", CASE WHEN ((pr.bmanuel = true) OR (st.nbbons = 0)) THEN 0.00 ELSE round(((1.0 * (((st.pdsbons - (ar.pdstheo * st.nbbons)) * 100))::numeric) / (st.pdsbons)::numeric), 2) END AS freinte, st.nbtmp AS nbencours, st.pdstmp AS pdsencours, CASE WHEN ((pr.bmanuel = true) OR (st.nbtmp = 0)) THEN 0.00 ELSE round(((1.0 * (((st.pdstmp - (ar.pdstheo * st.nbtmp)) * 100))::numeric) / (st.pdstmp)::numeric), 2) END AS "F encours", me.resbloc1 AS "msg marq", me.lot, pg_catalog.concat("substring"((me.fab)::text, 1, 2), '/', "substring"((me.fab)::text, 3, 2), '/', "substring"((me.fab)::text, 5, 2)) AS fab, pg_catalog.concat("substring"((me.dluo)::text, 1, 2), '/', "substring"((me.dluo)::text, 3, 2), '/', "substring"((me.dluo)::text, 5, 2)) AS dluo, pg_catalog.concat(CASE WHEN (length((me.libmess_2)::text) = 0) THEN ("substring"((pr.libprod)::text, 1, 4))::character varying ELSE me.libmess_2 END, ca.code) AS "code int", round(((1.0 * (((ar.pdstheo * st.nbbons) - st.erp))::numeric) / (1000)::numeric), 2) AS pdsodoo, 'WH/TUNNEL' AS emplacement, pr.bmanuel, pr.bfrais FROM ((((statprod st LEFT JOIN article ar ON ((ar.codart = st.codart))) LEFT JOIN produit pr ON ((pr.idprod = ar.idcodprod))) LEFT JOIN calibre ca ON ((ca.codcal = ar.codcal))) LEFT JOIN message me ON ((me.idmessage = ar.idmsgtete2))) WHERE (st.nbbons > 0);


ALTER TABLE public.montest OWNER TO doux;

--
-- Name: equipe; Type: VIEW; Schema: public; Owner: doux
--

CREATE VIEW equipe AS
    SELECT t1.date, t1.heure, t1.num, t1.codprod, t1.artstk, t1.calibre, t1.nbbons, t1.pdsbons, t1."tot theo", t1.freinte, t1.nbencours, t1.pdsencours, t1."F encours", t1."msg marq", t1.lot, t1.fab, t1.dluo, t1."code int", t1.pdsodoo, t1.emplacement, t3."total lot", t1.bfrais, t1.bmanuel FROM (montest t1 LEFT JOIN (SELECT t2."code int", CASE WHEN (t2.bmanuel = true) THEN (0)::bigint ELSE sum(t2.nbbons) END AS "total lot" FROM montest t2 GROUP BY t2."code int", t2.bmanuel) t3 ON ((t1."code int" = t3."code int")));


ALTER TABLE public.equipe OWNER TO doux;

--
-- Name: etiquette; Type: TABLE; Schema: public; Owner: doux; Tablespace: 
--

CREATE TABLE etiquette (
    id integer NOT NULL,
    codart character(8) NOT NULL,
    produit_id smallint,
    libelle character(4) NOT NULL,
    codcal smallint,
    selection smallint DEFAULT 0,
    suffixe_lot character(2) DEFAULT '00'::bpchar,
    resbloc character varying(42)
);


ALTER TABLE public.etiquette OWNER TO doux;

--
-- Name: etiquette_id_seq; Type: SEQUENCE; Schema: public; Owner: doux
--

CREATE SEQUENCE etiquette_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.etiquette_id_seq OWNER TO doux;

--
-- Name: etiquette_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: doux
--

ALTER SEQUENCE etiquette_id_seq OWNED BY etiquette.id;


--
-- Name: etiquette_manuelle; Type: TABLE; Schema: public; Owner: apache; Tablespace: 
--

CREATE TABLE etiquette_manuelle (
    id integer NOT NULL,
    create_date date DEFAULT now() NOT NULL,
    print_date date,
    export_date date,
    printer character(15) NOT NULL,
    label character(50) NOT NULL,
    qty integer DEFAULT 0,
    marque character(10) NOT NULL,
    calibre character(5) NOT NULL,
    nb_piece character(2) NOT NULL,
    denomination character(150) NOT NULL,
    lot character(15) NOT NULL,
    nb_colis integer NOT NULL,
    poids double precision NOT NULL,
    ddm date NOT NULL,
    etiquette character(10),
    type_palette character(5) NOT NULL,
    ref_interne character(10) NOT NULL,
    uom_id integer NOT NULL,
    code_process character(8) NOT NULL,
    fab date
);


ALTER TABLE public.etiquette_manuelle OWNER TO apache;

--
-- Name: etiquette_manuelle_id_seq; Type: SEQUENCE; Schema: public; Owner: apache
--

CREATE SEQUENCE etiquette_manuelle_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.etiquette_manuelle_id_seq OWNER TO apache;

--
-- Name: etiquette_manuelle_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: apache
--

ALTER SEQUENCE etiquette_manuelle_id_seq OWNED BY etiquette_manuelle.id;


--
-- Name: lispdt; Type: TABLE; Schema: public; Owner: doux; Tablespace: 
--

CREATE TABLE lispdt (
    numliste smallint NOT NULL,
    codart character(8) NOT NULL
);


ALTER TABLE public.lispdt OWNER TO doux;

--
-- Name: lispdt_c; Type: TABLE; Schema: public; Owner: doux; Tablespace: 
--

CREATE TABLE lispdt_c (
    numliste smallint NOT NULL,
    codart character(8) NOT NULL
);


ALTER TABLE public.lispdt_c OWNER TO doux;

--
-- Name: liste; Type: TABLE; Schema: public; Owner: doux; Tablespace: 
--

CREATE TABLE liste (
    numliste integer NOT NULL,
    libliste character varying(30) DEFAULT ''::character varying
);


ALTER TABLE public.liste OWNER TO doux;

--
-- Name: liste_c; Type: TABLE; Schema: public; Owner: doux; Tablespace: 
--

CREATE TABLE liste_c (
    numliste integer NOT NULL,
    libliste character varying(30) DEFAULT ''::character varying
);


ALTER TABLE public.liste_c OWNER TO doux;

--
-- Name: liste_c_numliste_seq; Type: SEQUENCE; Schema: public; Owner: doux
--

CREATE SEQUENCE liste_c_numliste_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.liste_c_numliste_seq OWNER TO doux;

--
-- Name: liste_c_numliste_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: doux
--

ALTER SEQUENCE liste_c_numliste_seq OWNED BY liste_c.numliste;


--
-- Name: liste_numliste_seq; Type: SEQUENCE; Schema: public; Owner: doux
--

CREATE SEQUENCE liste_numliste_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.liste_numliste_seq OWNER TO doux;

--
-- Name: liste_numliste_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: doux
--

ALTER SEQUENCE liste_numliste_seq OWNED BY liste.numliste;


--
-- Name: listecouv; Type: TABLE; Schema: public; Owner: apache; Tablespace: 
--

CREATE TABLE listecouv (
    numcouv integer NOT NULL,
    codart character(8) NOT NULL,
    couvercle smallint DEFAULT 0,
    hhmmss_api time without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.listecouv OWNER TO apache;

--
-- Name: listecouv_numcouv_seq; Type: SEQUENCE; Schema: public; Owner: apache
--

CREATE SEQUENCE listecouv_numcouv_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.listecouv_numcouv_seq OWNER TO apache;

--
-- Name: listecouv_numcouv_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: apache
--

ALTER SEQUENCE listecouv_numcouv_seq OWNED BY listecouv.numcouv;


--
-- Name: marque; Type: TABLE; Schema: public; Owner: doux; Tablespace: 
--

CREATE TABLE marque (
    id integer NOT NULL,
    libprod character varying(15) NOT NULL,
    msgtete1 character varying(25),
    numdate smallint NOT NULL,
    bfrais boolean DEFAULT false,
    bmanuel boolean DEFAULT false,
    bfreinte boolean DEFAULT false,
    message_id integer NOT NULL
);


ALTER TABLE public.marque OWNER TO doux;

--
-- Name: marque_id_seq; Type: SEQUENCE; Schema: public; Owner: doux
--

CREATE SEQUENCE marque_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.marque_id_seq OWNER TO doux;

--
-- Name: marque_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: doux
--

ALTER SEQUENCE marque_id_seq OWNED BY marque.id;


--
-- Name: message_idmessage_seq; Type: SEQUENCE; Schema: public; Owner: doux
--

CREATE SEQUENCE message_idmessage_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.message_idmessage_seq OWNER TO doux;

--
-- Name: message_idmessage_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: doux
--

ALTER SEQUENCE message_idmessage_seq OWNED BY message.idmessage;


--
-- Name: message2; Type: TABLE; Schema: public; Owner: doux; Tablespace: 
--

CREATE TABLE message2 (
    idmessage integer DEFAULT nextval('message_idmessage_seq'::regclass) NOT NULL,
    libmess character varying(42) DEFAULT ' '::character varying,
    libmess_2 character varying(42) DEFAULT ' '::character varying,
    police smallint DEFAULT 0,
    libmess_3 character varying(42) DEFAULT ' '::character varying,
    fab character varying(6) DEFAULT ' '::character varying,
    dluo character varying(6) DEFAULT ' '::character varying,
    lot character varying(10) DEFAULT ' '::character varying,
    resbloc1 character varying(42) DEFAULT ' '::character varying,
    resbloc3 character varying(42) DEFAULT ' '::character varying,
    caldate_id integer NOT NULL
);


ALTER TABLE public.message2 OWNER TO doux;

--
-- Name: produit2; Type: TABLE; Schema: public; Owner: doux; Tablespace: 
--

CREATE TABLE produit2 (
    codcal smallint NOT NULL,
    nbpiece smallint,
    pdstheo integer,
    fourch_plus smallint NOT NULL,
    fourch_moins smallint NOT NULL,
    tare_p smallint,
    idcart smallint,
    tareglo smallint,
    couvercle smallint,
    metal smallint,
    id integer NOT NULL,
    marque_id smallint
);


ALTER TABLE public.produit2 OWNER TO doux;

--
-- Name: marqueuse; Type: VIEW; Schema: public; Owner: root
--

CREATE VIEW marqueuse AS
    SELECT stat.codart, stat.pdsmin, stat.pdsmax, marq.msgtete1, marq.message_id AS idmsgtete2, eti.resbloc AS resbloc1, mess.libmess_2, mess.resbloc3, pg_catalog.concat(mess.lot, eti.suffixe_lot) AS lot, mess.police FROM ((((statprod stat LEFT JOIN etiquette eti ON ((eti.codart = stat.codart))) LEFT JOIN produit2 prod ON ((prod.id = eti.produit_id))) LEFT JOIN marque marq ON ((marq.id = prod.marque_id))) LEFT JOIN message2 mess ON ((mess.idmessage = marq.message_id))) ORDER BY stat.numstat;


ALTER TABLE public.marqueuse OWNER TO root;

--
-- Name: marqueuse2; Type: VIEW; Schema: public; Owner: root
--

CREATE VIEW marqueuse2 AS
    SELECT charg.codart, charg.pdsmin, charg.pdsmax, charg.msgtete1, charg.idmsgtete2, charg.resbloc1, charg.libmess_2, charg.resbloc3, charg.lot, charg.police FROM chargement charg;


ALTER TABLE public.marqueuse2 OWNER TO root;

--
-- Name: produit2_id_seq; Type: SEQUENCE; Schema: public; Owner: doux
--

CREATE SEQUENCE produit2_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.produit2_id_seq OWNER TO doux;

--
-- Name: produit2_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: doux
--

ALTER SEQUENCE produit2_id_seq OWNED BY produit2.id;


--
-- Name: produit_idprod_seq; Type: SEQUENCE; Schema: public; Owner: doux
--

CREATE SEQUENCE produit_idprod_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.produit_idprod_seq OWNER TO doux;

--
-- Name: produit_idprod_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: doux
--

ALTER SEQUENCE produit_idprod_seq OWNED BY produit.idprod;


--
-- Name: rejet; Type: TABLE; Schema: public; Owner: doux; Tablespace: 
--

CREATE TABLE rejet (
    id integer,
    libelle character varying(15)
);


ALTER TABLE public.rejet OWNER TO doux;

--
-- Name: TABLE rejet; Type: COMMENT; Schema: public; Owner: doux
--

COMMENT ON TABLE rejet IS 'libelle des codes rejets';


--
-- Name: rubafix; Type: TABLE; Schema: public; Owner: doux; Tablespace: 
--

CREATE TABLE rubafix (
    datejour date NOT NULL,
    date12m date,
    date18m date
);


ALTER TABLE public.rubafix OWNER TO doux;

--
-- Name: savcouv; Type: TABLE; Schema: public; Owner: doux; Tablespace: 
--

CREATE TABLE savcouv (
    numcouv integer NOT NULL,
    codart character(8) NOT NULL,
    couvercle smallint DEFAULT 0,
    hhmmss_api time without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.savcouv OWNER TO doux;

--
-- Name: savcouv_numcouv_seq; Type: SEQUENCE; Schema: public; Owner: doux
--

CREATE SEQUENCE savcouv_numcouv_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.savcouv_numcouv_seq OWNER TO doux;

--
-- Name: savcouv_numcouv_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: doux
--

ALTER SEQUENCE savcouv_numcouv_seq OWNED BY savcouv.numcouv;


--
-- Name: statprod_numstat_seq; Type: SEQUENCE; Schema: public; Owner: apache
--

CREATE SEQUENCE statprod_numstat_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.statprod_numstat_seq OWNER TO apache;

--
-- Name: statprod_numstat_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: apache
--

ALTER SEQUENCE statprod_numstat_seq OWNED BY statprod.numstat;


--
-- Name: tb_ctrl_pes; Type: TABLE; Schema: public; Owner: doux; Tablespace: 
--

CREATE TABLE tb_ctrl_pes (
    etatapi smallint NOT NULL,
    etatmarq smallint NOT NULL,
    hhmmsscc time without time zone DEFAULT now() NOT NULL,
    etatsubst integer DEFAULT 0,
    etaterp integer DEFAULT 1,
    etatcomp integer DEFAULT 0
);


ALTER TABLE public.tb_ctrl_pes OWNER TO doux;

--
-- Name: tmpcouv; Type: TABLE; Schema: public; Owner: apache; Tablespace: 
--

CREATE TABLE tmpcouv (
    numcouv integer NOT NULL,
    codart character(8) NOT NULL,
    couvercle smallint DEFAULT 0,
    hhmmss_api time without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.tmpcouv OWNER TO apache;

--
-- Name: tmpcouv_numcouv_seq; Type: SEQUENCE; Schema: public; Owner: apache
--

CREATE SEQUENCE tmpcouv_numcouv_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tmpcouv_numcouv_seq OWNER TO apache;

--
-- Name: tmpcouv_numcouv_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: apache
--

ALTER SEQUENCE tmpcouv_numcouv_seq OWNED BY tmpcouv.numcouv;


--
-- Name: tunnel_odoo; Type: TABLE; Schema: public; Owner: root; Tablespace: 
--

CREATE TABLE tunnel_odoo (
    create_date date DEFAULT now() NOT NULL,
    time_date time without time zone DEFAULT now() NOT NULL,
    printer character(15) NOT NULL,
    label character(50) NOT NULL,
    qty integer DEFAULT 0,
    marque character(10) NOT NULL,
    calibre character(5) NOT NULL,
    nb_piece character(2) NOT NULL,
    denomination character(150) NOT NULL,
    lot character(15) NOT NULL,
    nb_colis integer NOT NULL,
    poids double precision NOT NULL,
    ddm date NOT NULL,
    type_palette character(5) NOT NULL,
    ref_interne character(10) NOT NULL,
    uom_id integer NOT NULL,
    code_process character(8) NOT NULL,
    fab date NOT NULL
);


ALTER TABLE public.tunnel_odoo OWNER TO root;

--
-- Name: usages; Type: TABLE; Schema: public; Owner: doux; Tablespace: 
--

CREATE TABLE usages (
    droit character varying,
    libelle character varying,
    users_id integer
);


ALTER TABLE public.usages OWNER TO doux;

--
-- Name: users; Type: TABLE; Schema: public; Owner: doux; Tablespace: 
--

CREATE TABLE users (
    id_user integer NOT NULL,
    firstname text NOT NULL,
    lastname text NOT NULL,
    login text,
    password text,
    is_admin boolean DEFAULT false,
    is_superuser boolean DEFAULT false,
    email text
);


ALTER TABLE public.users OWNER TO doux;

--
-- Name: users_id_user_seq; Type: SEQUENCE; Schema: public; Owner: doux
--

CREATE SEQUENCE users_id_user_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_user_seq OWNER TO doux;

--
-- Name: users_id_user_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: doux
--

ALTER SEQUENCE users_id_user_seq OWNED BY users.id_user;


--
-- Name: numarch; Type: DEFAULT; Schema: public; Owner: doux
--

ALTER TABLE ONLY arch_stat ALTER COLUMN numarch SET DEFAULT nextval('arch_stat_numarch_seq'::regclass);


--
-- Name: id_article; Type: DEFAULT; Schema: public; Owner: doux
--

ALTER TABLE ONLY article ALTER COLUMN id_article SET DEFAULT nextval('article_id_article_seq'::regclass);


--
-- Name: numdate; Type: DEFAULT; Schema: public; Owner: doux
--

ALTER TABLE ONLY caldate ALTER COLUMN numdate SET DEFAULT nextval('caldate_numdate_seq'::regclass);


--
-- Name: idcalibre; Type: DEFAULT; Schema: public; Owner: doux
--

ALTER TABLE ONLY calibre ALTER COLUMN idcalibre SET DEFAULT nextval('calibre_idcalibre_seq'::regclass);


--
-- Name: idcart; Type: DEFAULT; Schema: public; Owner: doux
--

ALTER TABLE ONLY cartons ALTER COLUMN idcart SET DEFAULT nextval('cartons_idcart_seq'::regclass);


--
-- Name: num; Type: DEFAULT; Schema: public; Owner: doux
--

ALTER TABLE ONLY data00 ALTER COLUMN num SET DEFAULT nextval('data00_num_seq'::regclass);


--
-- Name: num; Type: DEFAULT; Schema: public; Owner: apache
--

ALTER TABLE ONLY data01 ALTER COLUMN num SET DEFAULT nextval('data01_num_seq'::regclass);


--
-- Name: num; Type: DEFAULT; Schema: public; Owner: apache
--

ALTER TABLE ONLY data02 ALTER COLUMN num SET DEFAULT nextval('data02_num_seq'::regclass);


--
-- Name: num; Type: DEFAULT; Schema: public; Owner: apache
--

ALTER TABLE ONLY data03 ALTER COLUMN num SET DEFAULT nextval('data03_num_seq'::regclass);


--
-- Name: num; Type: DEFAULT; Schema: public; Owner: apache
--

ALTER TABLE ONLY data04 ALTER COLUMN num SET DEFAULT nextval('data04_num_seq'::regclass);


--
-- Name: num; Type: DEFAULT; Schema: public; Owner: apache
--

ALTER TABLE ONLY data05 ALTER COLUMN num SET DEFAULT nextval('data05_num_seq'::regclass);


--
-- Name: num; Type: DEFAULT; Schema: public; Owner: apache
--

ALTER TABLE ONLY data06 ALTER COLUMN num SET DEFAULT nextval('data06_num_seq'::regclass);


--
-- Name: num; Type: DEFAULT; Schema: public; Owner: doux
--

ALTER TABLE ONLY data07 ALTER COLUMN num SET DEFAULT nextval('data07_num_seq'::regclass);


--
-- Name: num; Type: DEFAULT; Schema: public; Owner: apache
--

ALTER TABLE ONLY datajour ALTER COLUMN num SET DEFAULT nextval('datajour_num_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: doux
--

ALTER TABLE ONLY etiquette ALTER COLUMN id SET DEFAULT nextval('etiquette_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: apache
--

ALTER TABLE ONLY etiquette_manuelle ALTER COLUMN id SET DEFAULT nextval('etiquette_manuelle_id_seq'::regclass);


--
-- Name: numliste; Type: DEFAULT; Schema: public; Owner: doux
--

ALTER TABLE ONLY liste ALTER COLUMN numliste SET DEFAULT nextval('liste_numliste_seq'::regclass);


--
-- Name: numliste; Type: DEFAULT; Schema: public; Owner: doux
--

ALTER TABLE ONLY liste_c ALTER COLUMN numliste SET DEFAULT nextval('liste_c_numliste_seq'::regclass);


--
-- Name: numcouv; Type: DEFAULT; Schema: public; Owner: apache
--

ALTER TABLE ONLY listecouv ALTER COLUMN numcouv SET DEFAULT nextval('listecouv_numcouv_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: doux
--

ALTER TABLE ONLY marque ALTER COLUMN id SET DEFAULT nextval('marque_id_seq'::regclass);


--
-- Name: idmessage; Type: DEFAULT; Schema: public; Owner: doux
--

ALTER TABLE ONLY message ALTER COLUMN idmessage SET DEFAULT nextval('message_idmessage_seq'::regclass);


--
-- Name: idprod; Type: DEFAULT; Schema: public; Owner: doux
--

ALTER TABLE ONLY produit ALTER COLUMN idprod SET DEFAULT nextval('produit_idprod_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: doux
--

ALTER TABLE ONLY produit2 ALTER COLUMN id SET DEFAULT nextval('produit2_id_seq'::regclass);


--
-- Name: numcouv; Type: DEFAULT; Schema: public; Owner: doux
--

ALTER TABLE ONLY savcouv ALTER COLUMN numcouv SET DEFAULT nextval('savcouv_numcouv_seq'::regclass);


--
-- Name: numstat; Type: DEFAULT; Schema: public; Owner: apache
--

ALTER TABLE ONLY statprod ALTER COLUMN numstat SET DEFAULT nextval('statprod_numstat_seq'::regclass);


--
-- Name: numcouv; Type: DEFAULT; Schema: public; Owner: apache
--

ALTER TABLE ONLY tmpcouv ALTER COLUMN numcouv SET DEFAULT nextval('tmpcouv_numcouv_seq'::regclass);


--
-- Name: id_user; Type: DEFAULT; Schema: public; Owner: doux
--

ALTER TABLE ONLY users ALTER COLUMN id_user SET DEFAULT nextval('users_id_user_seq'::regclass);


--
-- Name: arch_stat_pkey; Type: CONSTRAINT; Schema: public; Owner: doux; Tablespace: 
--

ALTER TABLE ONLY arch_stat
    ADD CONSTRAINT arch_stat_pkey PRIMARY KEY (numarch);


--
-- Name: caldate_pkey; Type: CONSTRAINT; Schema: public; Owner: doux; Tablespace: 
--

ALTER TABLE ONLY caldate
    ADD CONSTRAINT caldate_pkey PRIMARY KEY (numdate);


--
-- Name: calibre_pkey; Type: CONSTRAINT; Schema: public; Owner: doux; Tablespace: 
--

ALTER TABLE ONLY calibre
    ADD CONSTRAINT calibre_pkey PRIMARY KEY (idcalibre);


--
-- Name: cartons_pkey; Type: CONSTRAINT; Schema: public; Owner: doux; Tablespace: 
--

ALTER TABLE ONLY cartons
    ADD CONSTRAINT cartons_pkey PRIMARY KEY (idcart);


--
-- Name: data00_pkey; Type: CONSTRAINT; Schema: public; Owner: doux; Tablespace: 
--

ALTER TABLE ONLY data00
    ADD CONSTRAINT data00_pkey PRIMARY KEY (num);


--
-- Name: data01_pkey; Type: CONSTRAINT; Schema: public; Owner: apache; Tablespace: 
--

ALTER TABLE ONLY data01
    ADD CONSTRAINT data01_pkey PRIMARY KEY (num);


--
-- Name: data02_pkey; Type: CONSTRAINT; Schema: public; Owner: apache; Tablespace: 
--

ALTER TABLE ONLY data02
    ADD CONSTRAINT data02_pkey PRIMARY KEY (num);


--
-- Name: data03_pkey; Type: CONSTRAINT; Schema: public; Owner: apache; Tablespace: 
--

ALTER TABLE ONLY data03
    ADD CONSTRAINT data03_pkey PRIMARY KEY (num);


--
-- Name: data04_pkey; Type: CONSTRAINT; Schema: public; Owner: apache; Tablespace: 
--

ALTER TABLE ONLY data04
    ADD CONSTRAINT data04_pkey PRIMARY KEY (num);


--
-- Name: data05_pkey; Type: CONSTRAINT; Schema: public; Owner: apache; Tablespace: 
--

ALTER TABLE ONLY data05
    ADD CONSTRAINT data05_pkey PRIMARY KEY (num);


--
-- Name: data06_pkey; Type: CONSTRAINT; Schema: public; Owner: apache; Tablespace: 
--

ALTER TABLE ONLY data06
    ADD CONSTRAINT data06_pkey PRIMARY KEY (num);


--
-- Name: data07_pkey; Type: CONSTRAINT; Schema: public; Owner: doux; Tablespace: 
--

ALTER TABLE ONLY data07
    ADD CONSTRAINT data07_pkey PRIMARY KEY (num);


--
-- Name: datajour_pkey; Type: CONSTRAINT; Schema: public; Owner: apache; Tablespace: 
--

ALTER TABLE ONLY datajour
    ADD CONSTRAINT datajour_pkey PRIMARY KEY (num);


--
-- Name: etiquette_codart_key; Type: CONSTRAINT; Schema: public; Owner: doux; Tablespace: 
--

ALTER TABLE ONLY etiquette
    ADD CONSTRAINT etiquette_codart_key UNIQUE (codart);


--
-- Name: etiquette_pkey; Type: CONSTRAINT; Schema: public; Owner: doux; Tablespace: 
--

ALTER TABLE ONLY etiquette
    ADD CONSTRAINT etiquette_pkey PRIMARY KEY (id);


--
-- Name: liste_c_pkey; Type: CONSTRAINT; Schema: public; Owner: doux; Tablespace: 
--

ALTER TABLE ONLY liste_c
    ADD CONSTRAINT liste_c_pkey PRIMARY KEY (numliste);


--
-- Name: liste_pkey; Type: CONSTRAINT; Schema: public; Owner: doux; Tablespace: 
--

ALTER TABLE ONLY liste
    ADD CONSTRAINT liste_pkey PRIMARY KEY (numliste);


--
-- Name: listecouv_codart_key; Type: CONSTRAINT; Schema: public; Owner: apache; Tablespace: 
--

ALTER TABLE ONLY listecouv
    ADD CONSTRAINT listecouv_codart_key UNIQUE (codart);


--
-- Name: listecouv_pkey; Type: CONSTRAINT; Schema: public; Owner: apache; Tablespace: 
--

ALTER TABLE ONLY listecouv
    ADD CONSTRAINT listecouv_pkey PRIMARY KEY (numcouv);


--
-- Name: marque_pkey; Type: CONSTRAINT; Schema: public; Owner: doux; Tablespace: 
--

ALTER TABLE ONLY marque
    ADD CONSTRAINT marque_pkey PRIMARY KEY (id);


--
-- Name: produit_pkey; Type: CONSTRAINT; Schema: public; Owner: doux; Tablespace: 
--

ALTER TABLE ONLY produit
    ADD CONSTRAINT produit_pkey PRIMARY KEY (idprod);


--
-- Name: savcouv_codart_key; Type: CONSTRAINT; Schema: public; Owner: doux; Tablespace: 
--

ALTER TABLE ONLY savcouv
    ADD CONSTRAINT savcouv_codart_key UNIQUE (codart);


--
-- Name: savcouv_pkey; Type: CONSTRAINT; Schema: public; Owner: doux; Tablespace: 
--

ALTER TABLE ONLY savcouv
    ADD CONSTRAINT savcouv_pkey PRIMARY KEY (numcouv);


--
-- Name: statprod_codart_key; Type: CONSTRAINT; Schema: public; Owner: apache; Tablespace: 
--

ALTER TABLE ONLY statprod
    ADD CONSTRAINT statprod_codart_key UNIQUE (codart);


--
-- Name: tb_ctrl_pes_pkey; Type: CONSTRAINT; Schema: public; Owner: doux; Tablespace: 
--

ALTER TABLE ONLY tb_ctrl_pes
    ADD CONSTRAINT tb_ctrl_pes_pkey PRIMARY KEY (hhmmsscc);


--
-- Name: tmpcouv_codart_key; Type: CONSTRAINT; Schema: public; Owner: apache; Tablespace: 
--

ALTER TABLE ONLY tmpcouv
    ADD CONSTRAINT tmpcouv_codart_key UNIQUE (codart);


--
-- Name: tmpcouv_pkey; Type: CONSTRAINT; Schema: public; Owner: apache; Tablespace: 
--

ALTER TABLE ONLY tmpcouv
    ADD CONSTRAINT tmpcouv_pkey PRIMARY KEY (numcouv);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: doux; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id_user);


--
-- Name: trg_maj_tbct; Type: TRIGGER; Schema: public; Owner: doux
--

CREATE TRIGGER trg_maj_tbct AFTER UPDATE ON tb_ctrl_pes FOR EACH ROW EXECUTE PROCEDURE maj_tbct();


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

