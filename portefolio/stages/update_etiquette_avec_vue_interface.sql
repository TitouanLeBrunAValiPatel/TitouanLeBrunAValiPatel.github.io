--
-- Auteur : Titouan LE BRUN
-- Societe : France Poultry
--
-- Version :
-- 		A - 01/06/2022 - INITIALLY
--
-- update de la table etiquette avec la vue interface

INSERT INTO etiquette(codart,codcal,libelle) select art.codart
 ,art.codcal  
 , '---' as libelle
 from article art 
 where art.codart not in (select codart from etiquette);

UPDATE message2 t1 SET
	fab = (select DISTINCT t2.fab from interface t2 ),
	dluo = (select ddm(to_char(to_date(t1.fab,'DDMMYY'), 'YYYY-MM-DD'), t2.jour::integer , t2.mois::integer , t2.annee::integer) from caldate t2 where t2.numdate = t1.caldate_id),
	lot = (select DISTINCT t2.lot from interface t2);

UPDATE etiquette SET selection = 0;

UPDATE etiquette t1 SET
	produit_id = (SELECT t2.produit_id FROM interface t2 WHERE t1.codart = t2.codart),
	selection = (SELECT t2.selection FROM interface t2 WHERE t1.codart = t2.codart),
	suffixe_lot = (SELECT t2.suffixe_lot FROM interface t2 WHERE t1.codart = t2.codart),
	resbloc = (select DISTINCT replace(replace(replace(msg.libmess, '#FAB1', msg.lot), '#DLUO1', msg.dluo), '#LOT1', msg.lot) from message2 msg
					left join interface t2 on t2.message_id = msg.idmessage
					where t2.codart = t1.codart);	