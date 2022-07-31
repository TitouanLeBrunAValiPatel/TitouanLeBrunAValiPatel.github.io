--
-- Auteur : Titouan LE BRUN
-- Societe : France Poultry
--
-- Version :
-- 		A - 30/05/2022 - INITIALLY
--
-- Création de la vue pre_equipe avec where statprod.nbbons > 0


DROP VIEW pre_equipe IF EXISTS ;

CREATE VIEW pre_equipe AS 
	SELECT 'now'::text::date AS date, to_char(now(), 'HH24:MI:SS'::text) AS heure, 
		st.numstat AS num, st.codart AS codprod, 
			CASE
				WHEN length(me.libmess_2::text) = 0 THEN "substring"(pr.libprod::text, 1, 4)::character varying
				ELSE me.libmess_2
			END AS artstk, 
		ca.valcal AS calibre, st.nbbons, st.pdsbons, 
		st.nbbons * ar.pdstheo AS "tot theo", 
			CASE
				WHEN pr.bmanuel = true OR st.nbbons = 0 THEN 0.00
				ELSE round(1.0 * ((st.pdsbons - ar.pdstheo * st.nbbons) * 100)::numeric / st.pdsbons::numeric, 2)
			END AS freinte, 
		st.nbtmp AS nbencours, st.pdstmp AS pdsencours, 
			CASE
				WHEN pr.bmanuel = true OR st.nbtmp = 0 THEN 0.00
				ELSE round(1.0 * ((st.pdstmp - ar.pdstheo * st.nbtmp) * 100)::numeric / st.pdstmp::numeric, 2)
			END AS "F encours", 
		me.resbloc1 AS "msg marq", me.lot, 
		pg_catalog.concat("substring"(me.fab::text, 1, 2), '/', "substring"(me.fab::text, 3, 2), '/', "substring"(me.fab::text, 5, 2)) AS fab, 
		pg_catalog.concat("substring"(me.dluo::text, 1, 2), '/', "substring"(me.dluo::text, 3, 2), '/', "substring"(me.dluo::text, 5, 2)) AS dluo, 
		pg_catalog.concat(
			CASE
				WHEN length(me.libmess_2::text) = 0 THEN "substring"(pr.libprod::text, 1, 4)::character varying
				ELSE me.libmess_2
			END, ca.code) AS "code int", 
		round(1.0 * (ar.pdstheo * st.nbtmp - st.erp)::numeric / 1000::numeric, 2) AS pdsodoo, 
		'WH/TUNNEL' AS emplacement, pr.bmanuel, pr.bfrais
	   FROM statprod st
	   LEFT JOIN article ar ON ar.codart = st.codart
	   LEFT JOIN produit pr ON pr.idprod = ar.idcodprod
	   LEFT JOIN calibre ca ON ca.codcal = ar.codcal
	   LEFT JOIN message me ON me.idmessage = ar.idmsgtete2;
