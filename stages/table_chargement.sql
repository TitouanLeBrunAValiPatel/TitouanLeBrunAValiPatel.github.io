--
-- Auteur : Titouan LE BRUN
-- Societe : France Poultry
--
-- Version :
-- 		A - 30/05/2022 - INITIALLY
--
-- Création de la table chargement

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
	CREATE VIEW EXISTS automate AS
	SELECT stat.codart 
		, stat.pdsmax
		, stat.pdsmin
		, stat.tareglo
		, art.tunnel
		, art.metal
	FROM statprod stat
	LEFT JOIN article art ON art.codart = stat.codart
	WHERE statprod.stop = 0
	ORDER BY statprod.numstat;
   
	

   