select freinte(stat.pdsbons , (prod.pdstheo * stat.nbbons)) , eti.codart , concat(prod.pdstheo , ' kg') as "pds theo peso marq et stage prod" , kilo(prod.pdstheo * stat.nbbons ,0) as "pds theo peso prod stage marq"
from produit2 prod 
left join etiquette eti on eti.produit_id = prod.id
left join statprod stat on stat.codart = eti.codart

where eti.codart = '03093628';
kilo(prod.pdstheo * stat.nbbons ,0)