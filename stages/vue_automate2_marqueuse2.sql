--
-- Auteur : Titouan LE BRUN
-- Societe : France Poultry
--
-- Version :
-- 		A - 30/05/2022 - INITIALLY
--
-- Création des vues avec la table chargement


-- marqueuse2

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
	-- LEFT JOIN article art ON art.codart = stat.codart
	-- LEFT JOIN message mess ON mess.idmessage = art.idmsgtete2
	-- LEFT JOIN produit prod ON prod.idprod = art.idcodprod
	-- WHERE stat.stop = 0
	-- ORDER BY stat.numstat;
	
-- automate2
	DROP VIEW IF EXISTS automate2;
	CREATE VIEW automate2 AS
	SELECT charg.codart 
		, charg.pdsmax
		, charg.pdsmin
		, charg.tareglo
		, charg.tunnel
		, charg.metal
	FROM chargement charg;
	-- LEFT JOIN article art ON art.codart = stat.codart
	-- WHERE stat.stop = 0
	-- ORDER BY stat.numstat;
	
	DROP VIEW IF EXISTS interface;
	CREATE VIEW interface AS
	-- tmp table non existante dans la bdd on selectionne tout les collonnes
	select tmp.*
	, marque.id as marq_id
	, produit2.id as prod_id
	-- parathèse car on veut rentrer dans le tableau des résultats
	from(
	select  statprod.codart as st_codart
	, article.codcal
	, message.libmess_2 as mes_libmess_2
	, right(message.lot,2) as mes_lot
	, statprod.pdsmax as st_pdsmax
	, statprod.pdsmin as st_pdsmin
	, produit.codprod as st_codprod 
	, produit.libprod as st_libprod 
	-- si (condition) alors (instruction) sinon (instruction) fin 
	, CASE WHEN LENGTH(message.libmess_2) = 0 THEN produit.libprod ELSE message.libmess_2 END as test 
	FROM statprod
	LEFT JOIN article ON article.codart = statprod.codart
	LEFT JOIN produit ON produit.idprod = article.idcodprod
	LEFT JOIN calibre ON article.codcal = calibre.codcal
	-- ferme les parathèses après la fin de la requete et rajouter le nom de la table
	LEFT JOIN message ON article.idmsgtete2 = message.idmessage) tmp
	LEFT JOIN marque ON marque.libprod = tmp.test
	LEFT JOIN produit2 ON produit2.marque_id = marque.id AND produit2.codcal = tmp.codcal;