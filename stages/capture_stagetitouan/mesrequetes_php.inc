        <!-- include mesrequetes_php -->
<?php //<BR><li><H1>Conversion du fichier <B>./mesrequetes_postgres.sql</B> vers le fichier <B>/tmp/mesrequetes_php.inc</B></h1></li>//<H3><li> LE FICHER EST GENERE</li></H3><BR><?php
// Listing des requetes SQL utillsée
// 
// Copier ce fichier mesrequetes_sql.sql du repertoire BDD du site dans c:/tmp de votre disque dur
// Appeler la page /BDD/convertir.php
// Le fichier mesrequetes_php.inc est creer dans le repertoire c:/tmp
// Copier le fichier creer dans le repertoire BDD du site 

// 	reqles pour les requetes
// 	-- * "pour indiquer le nom de la requete"
// 	-- / "pour termniner la requete"
// 	--	 "pour un commentaire"
// 	SET defini les parametres passé en argument ILS DOIVENT ETRE SUIVI D'UN ESPACE


// ############################ BASE DE DONNEE	##########################################
// ############################		POSTGRES	##########################################




// requete	req_famille_en_production
$req_famille_en_production="select * ";
$req_famille_en_production=$req_famille_en_production."from(select distinct prod.libprod as monindex ";
$req_famille_en_production=$req_famille_en_production.", prod.libprod as nom ";
$req_famille_en_production=$req_famille_en_production."from statprod stat ";
$req_famille_en_production=$req_famille_en_production."left join article art on art.codart=stat.codart ";
$req_famille_en_production=$req_famille_en_production."left join produit prod on prod.idprod = art.idcodprod ";
$req_famille_en_production=$req_famille_en_production."where prod.bmanuel = false ) tmp ";
$req_famille_en_production=$req_famille_en_production."order by monindex; ";
// Fin de la requete

// requete	req_article_en_production
$req_article_en_production="select statprod.codart as monindex ";
$req_article_en_production=$req_article_en_production.", statprod.codart as nom ";
$req_article_en_production=$req_article_en_production."from statprod ";
$req_article_en_production=$req_article_en_production."left join article on article.codart=statprod.codart ";
$req_article_en_production=$req_article_en_production."left join produit on produit.idprod = article.idcodprod ";
$req_article_en_production=$req_article_en_production."where produit.bmanuel = false ";
$req_article_en_production=$req_article_en_production."order by statprod.codart; ";
// Fin de la requete

$req_article_en_production=$req_article_en_production." ";
// requete	req_production_par_famille

$req_production_par_famille="select * ";
$req_production_par_famille=$req_production_par_famille."from ( ";
$req_production_par_famille=$req_production_par_famille."(select concat(to_char(cal.valcal,'FM0999'),'0') as tri ";
$req_production_par_famille=$req_production_par_famille.", prod.libprod as code ";
$req_production_par_famille=$req_production_par_famille.", prod.codprod as cab ";
$req_production_par_famille=$req_production_par_famille.", to_char(cal.valcal,'FM0999') as cal ";
$req_production_par_famille=$req_production_par_famille.", stat.codart as \"code article\" ";
$req_production_par_famille=$req_production_par_famille.", stat.nbbons as \"nb bon\" ";
$req_production_par_famille=$req_production_par_famille.", stat.pdsbons as \"pds reel\" ";
$req_production_par_famille=$req_production_par_famille.", to_char(stat.pdsmax,'FM09999') as \"pds max\" ";
$req_production_par_famille=$req_production_par_famille.", to_char(stat.pdsmin,'FM09999') as \"pds min\" ";
$req_production_par_famille=$req_production_par_famille.", art.pdstheo  as \"pds theo\" ";
$req_production_par_famille=$req_production_par_famille.", to_char(case when stat.pdsbons>0 then 1.00*(stat.pdsbons -(art.pdstheo * stat.nbbons)) * 100 / stat.pdsbons else 0 end,'FM99.99') as freinte ";
$req_production_par_famille=$req_production_par_famille."from statprod stat ";
$req_production_par_famille=$req_production_par_famille."left join article art  on art.codart = stat.codart ";
$req_production_par_famille=$req_production_par_famille."left join produit prod on prod.idprod  = art.idcodprod and prod.libprod = '".$critere."' ";
$req_production_par_famille=$req_production_par_famille."left join calibre cal  on cal.codcal = art.codcal where prod.bmanuel = false ";
$req_production_par_famille=$req_production_par_famille."order by prod.codprod) ";

$req_production_par_famille=$req_production_par_famille."union ";

$req_production_par_famille=$req_production_par_famille."(select concat(to_char(cal.valcal,'FM0999'),'1') as tri ";
$req_production_par_famille=$req_production_par_famille.", '' as code ";
$req_production_par_famille=$req_production_par_famille.", 'Total' as cab ";
$req_production_par_famille=$req_production_par_famille.", '' as cal ";
$req_production_par_famille=$req_production_par_famille.", 'Pds tot' as \"code article\" ";
$req_production_par_famille=$req_production_par_famille.", sum(stat.nbbons) as \"nb bon\" ";
$req_production_par_famille=$req_production_par_famille.", sum(stat.pdsbons) as \"pds reel\" ";
$req_production_par_famille=$req_production_par_famille.", '' as \"pds max\" ";
$req_production_par_famille=$req_production_par_famille.", '' as \"pds min\" ";
$req_production_par_famille=$req_production_par_famille.", sum(art.pdstheo)  as \"pds theo\" ";
$req_production_par_famille=$req_production_par_famille.", '' as freinte ";
$req_production_par_famille=$req_production_par_famille."from statprod stat left join article art  on art.codart = stat.codart ";
$req_production_par_famille=$req_production_par_famille."left join produit prod on prod.idprod  = art.idcodprod and prod.libprod = '".$critere."' ";
$req_production_par_famille=$req_production_par_famille."left join calibre cal  on cal.codcal = art.codcal where prod.bmanuel = false ";
$req_production_par_famille=$req_production_par_famille."group by prod.libprod, cal.valcal)) test ";
$req_production_par_famille=$req_production_par_famille."order by tri ";
// Fin de la requete

// requete	req_count_production_par_famille
//	VARIABLE :	 @critere='ESC6'
$req_count_production_par_famille="select count(stat.codart) as nb ";
$req_count_production_par_famille=$req_count_production_par_famille."from statprod stat ";
$req_count_production_par_famille=$req_count_production_par_famille."left join article art  on art.codart = stat.codart ";
$req_count_production_par_famille=$req_count_production_par_famille."left join produit prod on prod.idprod  = art.idcodprod ";
$req_count_production_par_famille=$req_count_production_par_famille."where prod.libprod = '".$critere."' ";
// Fin de la requete


// requete	req_production_par_famille_pied
//	VARIABLE :	 @critere='ESC6';
$req_production_par_famille_pied="select concat('Total = ' , carton ,  'Cartons ' , piece , ' pieces ===> Poids: ' , ROUND(poids,2) , ' kg  Poids theo: ' , round (theo,2) , ' kg  Ecart: ' , round (ecart,2) , ' kg F: ' , round(case when poids>0 then 1.00*(poids -theo) * 100 / poids else 0 end, 2) ) as texte from ( select sum(stat.nbbons) as carton , sum(stat.nbbons * art.nbpiece) as piece , sum(1.00*stat.pdsbons/1000) as poids , sum(1.00*stat.nbbons*art.pdstheo/1000) as theo , sum(((1.00*stat.pdsbons)-stat.nbbons*art.pdstheo)/1000)  as ecart from statprod stat left join article art  on art.codart = stat.codart left join produit prod on prod.idprod  = art.idcodprod where prod.libprod = '04243228' ) tmp ";
// Fin de la requete

// requete	req_listing_production_par_article
$req_listing_production_par_article="select marq.libprod as art_skt ";
$req_listing_production_par_article=$req_listing_production_par_article.", eti.libelle as cab ";
$req_listing_production_par_article=$req_listing_production_par_article.", cal.valcal as cal ";
$req_listing_production_par_article=$req_listing_production_par_article.", stat.codart as \"code article\" ";
$req_listing_production_par_article=$req_listing_production_par_article.", eti.resbloc as messagetete";
$req_listing_production_par_article=$req_listing_production_par_article.", stat.nbbons as \"nb bon\" ";
$req_listing_production_par_article=$req_listing_production_par_article.",concat  (ROUND(1.00*stat.pdsbons/1000 ,0), ' kg') as \"pds reel\" ";
$req_listing_production_par_article=$req_listing_production_par_article.", concat (ROUND(case when stat.pdsbons>0  then 1.00*(stat.pdsbons -(prod.pdstheo * stat.nbbons)) * 100/stat.pdsbons   else 0 end ,2), '%') as freinte ";
$req_listing_production_par_article=$req_listing_production_par_article.", kilo(prod.pdstheo * stat.nbbons, 0) as \"pds theo\" ,'---' as \"href_vide\" ,stat.nbtmp as \"nencours\" ,concat(stat.pdstmp/1000, ' kg') as pdsencours ";
$req_listing_production_par_article=$req_listing_production_par_article.", concat ( ROUND (case when stat.pdstmp>0  then 1.00*(stat.pdstmp -(prod.pdstheo * stat.nbtmp)) * 100/stat.pdstmp   else 0 end,2), '%') as fenc ";
$req_listing_production_par_article=$req_listing_production_par_article.",concat(stat.pdstmp /1000,' kg ') as pdstheoenc , case when stat.stop =1 then 'ARRET' else  ' ' end as \"M/A\" ";
$req_listing_production_par_article=$req_listing_production_par_article."from statprod stat ";
$req_listing_production_par_article=$req_listing_production_par_article."left join etiquette eti   on eti.codart = stat.codart ";
$req_listing_production_par_article=$req_listing_production_par_article."left join produit2 prod on prod.id  = eti.produit_id ";
$req_listing_production_par_article=$req_listing_production_par_article."left join calibre cal  on cal.codcal = eti.codcal ";
$req_listing_production_par_article=$req_listing_production_par_article."left join marque marq on marq.id = prod.marque_id ";
//$req_listing_production_par_article=$req_listing_production_par_article."where marq.bmanuel = false ";
$req_listing_production_par_article=$req_listing_production_par_article."order by stat.codart ";
// Fin de la requete
$req_listing_production_par_article=$req_listing_production_par_article." ";
// requete	req_par_delai
$req_par_delai="select eti.codart as codearticle ";
$req_par_delai=$req_par_delai.", eti.libelle as Famille ";
$req_par_delai=$req_par_delai.", cal.valcal as calibre ";
$req_par_delai=$req_par_delai.", prod.pdstheo as pdstheo ";
$req_par_delai=$req_par_delai.", dj.pdsnet as pdsnet ";
$req_par_delai=$req_par_delai.", case when dj.pdsnet-prod.pdstheo < 0 then  dj.pdsnet-prod.pdstheo end as ecartmoins ";
$req_par_delai=$req_par_delai.", case when dj.pdsnet-prod.pdstheo > 0 then dj.pdsnet-prod.pdstheo end as ecartplus ";
$req_par_delai=$req_par_delai.", dj.hhmmsscc ";
$req_par_delai=$req_par_delai.", rej.libelle ";
$req_par_delai=$req_par_delai."from datajour dj ";
$req_par_delai=$req_par_delai."left join  etiquette eti on eti.codart=dj.codart ";
$req_par_delai=$req_par_delai."left join produit2 prod on prod.id= eti.produit_id ";
$req_par_delai=$req_par_delai."left join marque marq on marq.id=prod.marque_id ";
$req_par_delai=$req_par_delai."left join message2 mess on mess.idmessage=marq.message_id ";
$req_par_delai=$req_par_delai."left join calibre cal on cal.codcal=eti.codcal ";
$req_par_delai=$req_par_delai."left join rejet rej on rej.id=dj.rejet ";
$req_par_delai=$req_par_delai."order by dj.num DESC LIMIT 1000 ";
// Fin de la requete


// requete	req_listing_marquese
$req_listing_marquese="select marq.libprod as art_skt ";
$req_listing_marquese.=", eti.libelle as cab ";
$req_listing_marquese.=", cal.valcal as cal ";
$req_listing_marquese.=", stat.codart as \"code article\" ";
$req_listing_marquese.=", kilo (stat.pdsbons,0) as \"pds reel\" ";
$req_listing_marquese.=", freinte(prod.pdstheo * stat.nbbons, stat.pdsbons) as freinte ";
$req_listing_marquese.=", kilo(prod.pdstheo * stat.nbbons ,0) as \"pds theo\" ";
$req_listing_marquese.=",stat.nbtmp as \"nencours\" ";
$req_listing_marquese.=",eti.resbloc as messagetete ";
$req_listing_marquese.=",marq.libprod as Bloc ";
$req_listing_marquese.=",kilo (stat.pdstmp, 0) as pdsencours ";
$req_listing_marquese.=", freinte(prod.pdstheo * stat.nbbons, stat.pdsbons) as fenc ";
$req_listing_marquese.=",kilo(stat.nbtmp * prod.pdstheo,0) as pdstheoenc ";
$req_listing_marquese.=", case when stat.stop =1 then 'ARRET' else  ' ' end as \"M/A\" ";
$req_listing_marquese.="from statprod stat ";
$req_listing_marquese.="left join etiquette eti   on eti.codart = stat.codart ";
$req_listing_marquese.="left join produit2 prod on prod.id= eti.produit_id ";
$req_listing_marquese.="left join marque marq on marq.id=prod.marque_id ";
$req_listing_marquese.="left join calibre cal  on cal.codcal = eti.codcal ";
//$req_listing_marquese.="where marq.bmanuel = false ";
$req_listing_marquese.="order by eti.codart ";
// Fin de la requete

// requete	req_famille_selection
$req_famille_selection="select art.codart as \"code article\" ";
$req_famille_selection=$req_famille_selection.", prod.codprod as famille ";
$req_famille_selection=$req_famille_selection.", cal.valcal as calibre ";
$req_famille_selection=$req_famille_selection.", (art.pdstheo+art.fourch_plus+art.tareglo) as pdsmax ";
$req_famille_selection=$req_famille_selection.", (art.pdstheo-art.fourch_moins-art.tareglo) as pdsmin ";
$req_famille_selection=$req_famille_selection.",  art.pdstheo as pdstheo ";
$req_famille_selection=$req_famille_selection.", art.tunnel as tunnel ";
$req_famille_selection=$req_famille_selection.", art.idmsgtete2 as idmsg ";
$req_famille_selection=$req_famille_selection.", art.selection as selec ";
$req_famille_selection=$req_famille_selection.", concat(' edit?','vue=edition_article&critere=',art.id_article) as href_edition_article ";
$req_famille_selection=$req_famille_selection.",'---' as \"----\" ";
$req_famille_selection=$req_famille_selection.", concat(' delete?','vue=suppression_article&id=',art.id_article) as  href_suppression_article ";
$req_famille_selection=$req_famille_selection."from calibre cal ";
$req_famille_selection=$req_famille_selection."left join produit prod on prod.codprod = prod.codprod ";
$req_famille_selection=$req_famille_selection."left join message mess on mess.idmessage = mess.idmessage ";
$req_famille_selection=$req_famille_selection."left join article art on art.codart = art.codart ";
$req_famille_selection=$req_famille_selection."where art.codcal=cal.codcal and art.idcodprod = prod.idprod and art.idcodprod =27  and art.idmsgtete2 = mess.idmessage ";
$req_famille_selection=$req_famille_selection."order by art.codart ";
// Fin de la requete
$req_famille_selection=$req_famille_selection." ";
// requete	req_art_en_prod
$req_art_en_prod="SELECT  eti.libelle as familly ";
$req_art_en_prod=$req_art_en_prod.", marq.libprod as marque ";
$req_art_en_prod=$req_art_en_prod.", cal.valcal as calibre ";
$req_art_en_prod=$req_art_en_prod."FROM statprod stat ";
$req_art_en_prod=$req_art_en_prod."left join etiquette eti on eti.codart=stat.codart ";
$req_art_en_prod=$req_art_en_prod."left join produit2 prod on eti.produit_id = prod.id ";
$req_art_en_prod=$req_art_en_prod."left join marque marq on marq.id = prod.marque_id ";
$req_art_en_prod=$req_art_en_prod."left join calibre cal on  eti.codcal=cal.codcal ";
$req_art_en_prod=$req_art_en_prod."ORDER BY   marq.bmanuel, stat.codart ";
// Fin de la requete

// 
// requete	req_article_en_attente
// 
$req_article_en_attente="SELECT eti.libelle as familly ";
$req_article_en_attente=$req_article_en_attente.",marq.libprod as marque ";
$req_article_en_attente=$req_article_en_attente.",cal.valcal as calibre ";
$req_article_en_attente=$req_article_en_attente."FROM etiquette eti ";
$req_article_en_attente=$req_article_en_attente."left join produit2 prod on eti.produit_id = prod.id ";
$req_article_en_attente=$req_article_en_attente."left join calibre cal on eti.codcal=cal.codcal ";
$req_article_en_attente=$req_article_en_attente."left join marque marq on marq.id=prod.marque_id ";
$req_article_en_attente=$req_article_en_attente."WHERE eti.selection = 1 and  eti.codart NOT IN (SELECT codart from statprod) ";
$req_article_en_attente=$req_article_en_attente."order by eti.codart ";
// Fin de la requete

// requete	req_message_selection
$req_message_selection="select mess.idmessage as \"code message\" ";
$req_message_selection=$req_message_selection.", mess.libmess as \"libelle 1\" ";
$req_message_selection=$req_message_selection.",mess.police as police ";
$req_message_selection=$req_message_selection.",mess.fab as \"datefab\" ";
$req_message_selection=$req_message_selection.",mess.dluo as \"date limite\" ";
$req_message_selection=$req_message_selection.",mess.lot as lot ";
$req_message_selection=$req_message_selection.",dat.libdate as DDM ";
$req_message_selection=$req_message_selection.", compt.nb  ";
$req_message_selection=$req_message_selection.",concat(' edit?','vue=edition_message&id=',mess.idmessage) as href_edition_message ";
$req_message_selection=$req_message_selection.",case when idmessage in (select distinct idmessage message2) then ' ' else concat('suppression?','vue=suppression_message&id=',mess.idmessage) END as href_supression_message ";
$req_message_selection=$req_message_selection.",case when compt.nb >0 then '  'else concat('suppression?','vue=suppression_message&id=',mess.idmessage) end as  href_supression_message ";
$req_message_selection=$req_message_selection."from message2 mess ";
$req_message_selection=$req_message_selection."left join caldate dat on dat.numdate = mess.caldate_id ";
$req_message_selection=$req_message_selection."left join (select message_id,count (libprod) as nb from marque group by message_id) compt on compt.message_id = mess.idmessage ";
// Fin de la requete


// requete	req_list_ajouter
$req_list_ajouter="select idcart as \"idcartons\" ";
$req_list_ajouter=$req_list_ajouter.",libcart as\"current cartons\" ";
$req_list_ajouter=$req_list_ajouter.",pdscart as \"pds cartons\" ";
$req_list_ajouter=$req_list_ajouter.", concat('edit?','vue=edition_carton&id=',idcart) as href_edition_carton ";
$req_list_ajouter=$req_list_ajouter.", case when idcart in (select distinct idcart from article)then '' else concat('delete?','vue=suppression_carton&id=',idcart) END as href_suppression_carton ";
$req_list_ajouter=$req_list_ajouter."from cartons ";
// Fin de la requete

// requete	req_liste_article
$req_liste_article="select marque as marque ";
$req_liste_article=$req_liste_article.", prod.codcal as \"code article\" ";
$req_liste_article=$req_liste_article.", nbpiece as \"nombre piece\" ";
$req_liste_article=$req_liste_article.", pdstheo as \"poids theo\" ";
$req_liste_article=$req_liste_article.", concat('edit?','vue=edition_article&critere=', id ) as href_edition_article ";
$req_liste_article=$req_liste_article."from produit2  prod ";
// Fin de la requete

// LISTING DES REQUETES
$Liste_requete["req_famille_en_production"]=$req_famille_en_production;
$Liste_requete["req_article_en_production"]=$req_article_en_production;
$Liste_requete["req_production_par_famille"]=$req_production_par_famille;
$Liste_requete["req_count_production_par_famille"]=$req_count_production_par_famille;
$Liste_requete["req_production_par_famille_pied"]=$req_production_par_famille_pied;
$Liste_requete["req_listing_production_par_article"]=$req_listing_production_par_article;
$Liste_requete["req_par_delai"]=$req_par_delai;
$Liste_requete["req_listing_marquese"]=$req_listing_marquese;
$Liste_requete["req_famille_selection"]=$req_famille_selection;
$Liste_requete["req_art_en_prod"]=$req_art_en_prod;
$Liste_requete["req_article_en_attente"]=$req_article_en_attente;
$Liste_requete["req_message_selection"]=$req_message_selection;
$Liste_requete["req_list_ajouter"]=$req_list_ajouter;
$Liste_requete["req_liste_article"]=$req_liste_article;
?>
