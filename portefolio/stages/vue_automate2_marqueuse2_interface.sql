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

	   
