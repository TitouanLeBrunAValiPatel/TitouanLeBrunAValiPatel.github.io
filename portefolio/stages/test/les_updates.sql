-- crrer les update 

UPDATE message2 t1 SET
	fab = (select DISTINCT t2.fab from interface t2 ),
	dluo = (select ddm(to_char(to_date(t1.fab,'DDMMYY'), 'YYYY-MM-DD'), t2.jour::integer , t2.mois::integer , t2.annee::integer) from caldate t2 where t2.numdate = t1.caldate_id),
	lot = (select DISTINCT concat(left(t2.lot,5)) from interface t2);

UPDATE etiquette SET selection = 0;

UPDATE etiquette t1 SET
	produit_id = (SELECT t2.produit_id FROM interface t2 WHERE t1.codart = t2.codart),
	selection = (SELECT t2.selection FROM interface t2 WHERE t1.codart = t2.codart),
	suffixe_lot = (SELECT t2.suffixe_lot FROM interface t2 WHERE t1.codart = t2.codart),
	resbloc = (select DISTINCT replace(replace(replace(msg.libmess, '#FAB1', msg.fab), '#DLUO1', msg.dluo), '#LOT1', concat(msg.lot, t2.suffixe_lot)) from message2 msg
					left join interface t2 on t2.message_id = msg.idmessage
					where t2.codart = t1.codart);
	libelle = (select distinct concat(chr(left(t1.codart,2)::integer + 64) , chr(substring(t1.codart from 3 for 2)::integer + 64) ,  substring(t1.codart from 6 for 1)) from etiquette t2 
					where t1.libelle = '---' and not t1.codart like '00%');
				 


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