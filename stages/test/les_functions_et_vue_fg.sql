-- creer les fonctions et la view fg 


DROP VIEW IF EXISTS test_fg_rubafix;
DROP FUNCTION IF EXISTS test_fred(fab character varying, jour integer, mois integer, annee integer);

CREATE FUNCTION test_fred(fab character varying, jour integer, mois integer, annee integer) 
RETURNS character varying
LANGUAGE plpgsql
AS 
$$
DECLARE
 d3 text;
BEGIN
 d3 := to_char(fab::timestamp + interval '1 year' * annee + interval '1 month' * mois + interval '1 day' * jour,'YYYY-MM-DD'); 
 RETURN to_char(d3::timestamp,'DDMMYY');
END;
$$;

CREATE VIEW test_fg_rubafix AS
 SELECT t2.datejour, 
    madate(ddm(t2.datejour::character varying, 6, 0, 0)) AS "DLC 5 JOURS", 
    madate(ddm(t2.datejour::character varying, 0, 0, 1)) AS "DLUO 12 MOIS", 
    madate(ddm(t2.datejour::character varying, 0, 6, 1)) AS "DLUO 18 MOIS", 
    madate(test_fred(t2.datejour::character varying, 6, 0, 0)) AS "DLC 5 JOURS v2", 
    madate(test_fred(t2.datejour::character varying, 0, 0, 1)) AS "DLUO 12 MOIS v2", 
    madate(test_fred(t2.datejour::character varying, 0, 6, 1)) AS "DLUO 18 MOIS v2"
   FROM ( SELECT t1.num, 
            to_char('now'::text::date + '1 day'::interval * t1.num::double precision, 'dd/mm/yy'::text) AS datejour
           FROM ( SELECT generate_series(0, 420) AS num) t1) t2;
		   
--
-- Name: freinte(integer, integer); Type: FUNCTION; Schema: public; Owner: root
--
DROP FUNCTION IF EXISTS freinte(pds_reel integer, pds_theo integer) ;
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
DROP FUNCTION IF EXISTS kilo(poids integer, arrondi integer) ;
CREATE FUNCTION kilo(poids integer, arrondi integer) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
BEGIN
 RETURN concat(round(1.00*poids/1000, arrondi),' kg');
END;
$$;


ALTER FUNCTION public.kilo(poids integer, arrondi integer) OWNER TO root;