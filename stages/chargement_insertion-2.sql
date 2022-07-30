--
-- Auteur : Titouan LE BRUN
-- Societe : France Poultry
--
-- Version :
-- 		A - 30/05/2022 - INITIALLY
--
-- Insertion des valeurs dans la table chargement pseo_1


--INSERT INTO chargement(codart,pdsmin,pdsmax,msgtete1,idmsgtete2,resbloc1,libmess_2,resbloc3,lot,police,tareglo,tunnel,metal)


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
	, stat.tareglo
	, art.tunnel
	, art.metal
   FROM statprod stat
   LEFT JOIN article art ON art.codart = stat.codart
   LEFT JOIN message mess ON mess.idmessage = art.idmsgtete2
   LEFT JOIN produit prod ON prod.idprod = art.idcodprod
 --  WHERE stat.stop = 0
   ORDER BY stat.numstat;	
	