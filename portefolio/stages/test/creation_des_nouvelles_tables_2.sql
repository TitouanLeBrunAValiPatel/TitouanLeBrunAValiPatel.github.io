--
-- Auteur : Titouan LE BRUN
-- Societe : France Poultry
--
-- Version :
-- 		A - 31/05/2022 - INITIALLY
--
-- Script création des nouvelles tables
--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;


DROP TABLE IF EXISTS chargement;
	CREATE TABLE chargement(
	
	codart char(8),
	pdsmin smallint,
	pdsmax smallint,
	msgtete1 char(25),
	idmsgtete2 int,
	resbloc1 char(42),
	libmess_2 char(42),
	resbloc3 char(42),
	lot char(10), 
	police smallint,
	tareglo smallint,
	tunnel smallint,
	metal smallint);



-- ######################################################################
-- etiquette

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
-- Name: id; Type: DEFAULT; Schema: public; Owner: doux
--

ALTER TABLE ONLY etiquette ALTER COLUMN id SET DEFAULT nextval('etiquette_id_seq'::regclass);

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
	
-- ######################################################################
-- marque


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
-- Name: id; Type: DEFAULT; Schema: public; Owner: doux
--

ALTER TABLE ONLY marque ALTER COLUMN id SET DEFAULT nextval('marque_id_seq'::regclass);


--
-- Name: marque_pkey; Type: CONSTRAINT; Schema: public; Owner: doux; Tablespace: 
--

ALTER TABLE ONLY marque
    ADD CONSTRAINT marque_pkey PRIMARY KEY (id);


--
-- PostgreSQL database dump complete
--


-- ######################################################################
-- message2

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
-- PostgreSQL database dump complete
--

-- ######################################################################
-- produit2


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
-- Name: id; Type: DEFAULT; Schema: public; Owner: doux
--

ALTER TABLE ONLY produit2 ALTER COLUMN id SET DEFAULT nextval('produit2_id_seq'::regclass);


--
-- PostgreSQL database dump complete
--

-- ######################################################################
-- rejet


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
-- PostgreSQL database dump complete
--

-- ######################################################################
-- rubafix

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
-- PostgreSQL database dump complete
--


