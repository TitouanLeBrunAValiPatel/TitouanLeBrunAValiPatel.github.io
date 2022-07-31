--
-- Auteur : Titouan LE BRUN
-- Societe : France Poultry
--
-- Version :
-- 		A - 30/05/2022 - INITIALLY
--
-- Insertion des valeurs dans la table chargement

INSERT INTO chargement(codart,pdsmin,pdsmax,msgtete1,idmsgtete2,resbloc1,libmess_2,resbloc3,lot,police,tareglo,tunnel,metal)
SELECT stat.codart
	, stat.pdsmin
	, stat.pdsmax
	, marq.msgtete1
	, marq.message_id AS idmsgtete2
	, eti.resbloc AS resbloc1
	, mess.libmess_2
	, mess.resbloc3
	, pg_catalog.concat(mess.lot, eti.suffixe_lot) AS lot
	, mess.police
	, stat.tareglo
	, art.tunnel
	, art.metal
   FROM statprod stat
   LEFT JOIN etiquette eti ON eti.codart = stat.codart
   LEFT JOIN produit2 prod ON prod.id = eti.produit_id
   LEFT JOIN marque marq ON marq.id = prod.marque_id
   LEFT JOIN message2 mess ON mess.idmessage = marq.message_id
   LEFT JOIN article art ON art.codart = stat.codart

   WHERE stat.stop = 0
  ORDER BY stat.numstat;