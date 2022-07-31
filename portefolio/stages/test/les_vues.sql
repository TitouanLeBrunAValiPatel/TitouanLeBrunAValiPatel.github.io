-- creation des vues 

DROP VIEW IF EXISTS marqueuse;
	CREATE VIEW marqueuse AS 
	SELECT stat.codart
		, stat.pdsmin
		, stat.pdsmax
		, art.msgtete1
		, art.idmsgtete2
		, mess.resbloc1
		, mess.libmess_2
		, mess.resbloc3
		, mess.lot
		, mess.police
	FROM statprod stat
	LEFT JOIN article art ON art.codart = stat.codart
	LEFT JOIN message mess ON mess.idmessage = art.idmsgtete2
	LEFT JOIN produit prod ON prod.idprod = art.idcodprod
	WHERE stat.stop = 0
	ORDER BY stat.numstat;
  
	DROP VIEW IF EXISTS automate;
	CREATE VIEW automate AS
	SELECT stat.codart 
		, stat.pdsmax
		, stat.pdsmin
		, stat.tareglo
		, art.tunnel
		, art.metal
	FROM statprod stat
	LEFT JOIN article art ON art.codart = stat.codart
	WHERE stat.stop = 0
	ORDER BY stat.numstat;
	
	
DROP VIEW IF EXISTS pre_equipe ;

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


	DROP VIEW IF EXISTS interface;
	CREATE VIEW interface AS
	 SELECT tmp.codart, tmp.codcal, tmp.mes_libmess_2, tmp.suffixe_lot, 
		tmp.st_pdsmax, tmp.st_pdsmin, tmp.st_codprod, tmp.st_libprod, tmp.test, 
		tmp.selection, marque.id AS marq_id, produit2.id AS produit_id, tmp.lot, 
		tmp.fab, tmp.dluo,
		marque.message_id
	   FROM ( SELECT statprod.codart, article.codcal, 
				message.libmess_2 AS mes_libmess_2, 
				"right"(message.lot::text, 2) AS suffixe_lot, 
				statprod.pdsmax AS st_pdsmax, statprod.pdsmin AS st_pdsmin, 
				produit.codprod AS st_codprod, produit.libprod AS st_libprod, 
					CASE
						WHEN length(message.libmess_2::text) = 0 THEN produit.libprod
						ELSE message.libmess_2
					END AS test, 
				article.selection, message.lot, 
				pg_catalog.concat("substring"(message.fab::text, 1, 2), "substring"(message.fab::text, 3, 2), "substring"(message.fab::text, 5, 2)) AS fab, 
				pg_catalog.concat("substring"(message.dluo::text, 1, 2), "substring"(message.dluo::text, 3, 2), "substring"(message.dluo::text, 5, 2)) AS dluo 
			   FROM statprod
		  LEFT JOIN article ON article.codart = statprod.codart
	   LEFT JOIN produit ON produit.idprod = article.idcodprod
	   LEFT JOIN calibre ON article.codcal = calibre.codcal
	   LEFT JOIN message ON article.idmsgtete2 = message.idmessage) tmp
	   LEFT JOIN marque ON marque.libprod::text = tmp.test::text
	   LEFT JOIN produit2 ON produit2.marque_id = marque.id AND produit2.codcal = tmp.codcal;
	   
DROP VIEW IF EXISTS marqueuse2;
	CREATE VIEW marqueuse2 AS 
	SELECT charg.codart
		, charg.pdsmin
		, charg.pdsmax
		, charg.msgtete1
		, charg.idmsgtete2
		, charg.resbloc1
		, charg.libmess_2
		, charg.resbloc3
		, charg.lot
		, charg.police
	FROM chargement charg;



DROP VIEW IF EXISTS automate2;
	CREATE VIEW automate2 AS
	SELECT charg.codart 
		, charg.pdsmax
		, charg.pdsmin
		, charg.tareglo
		, charg.tunnel
		, charg.metal
	FROM chargement charg;