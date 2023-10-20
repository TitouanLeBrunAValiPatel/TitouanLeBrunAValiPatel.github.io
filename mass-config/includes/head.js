const head = `
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title></title>
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="apple-touch-icon" sizes="180x180" href="http://scoop-test.yogoko.fr/images/apple-touch-icon.png">
<link rel="icon" type="image/png" href="http://scoop-test.yogoko.fr/images/favicon-32x32.png" sizes="32x32">
<link rel="icon" type="image/png" href="http://scoop-test.yogoko.fr/images/favicon-16x16.png" sizes="16x16">
<link rel="mask-icon" href="http://scoop-test.yogoko.fr/images/safari-pinned-tab.svg" color="#5bbad5">
<link rel="shortcut icon" href="http://scoop-test.yogoko.fr/images/favicon.ico">

<link rel="manifest" href="http://scoop-test.yogoko.fr/images/manifest.json">
<meta name="csrf-token" content="WaSIyj331IbqZUCaMkZEN2uK420BohQ9mBSwrylX">
<meta name="msapplication-config" content="http://scoop-test.yogoko.fr/images/browserconfig.xml">
<meta name="theme-color" content="#ffffff">

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>


<link href="http://scoop-test.yogoko.fr/css/bootstrap.min.css" rel="stylesheet" type="text/css">
<link href="http://scoop-test.yogoko.fr/css/bootstrap-datetimepicker.min.css" rel="stylesheet" type="text/css">
<link href="http://scoop-test.yogoko.fr/css/bootstrap-switch.min.css" rel="stylesheet" type="text/css">
<link href="http://scoop-test.yogoko.fr/css/toastr.min.css" rel="stylesheet" type="text/css">
<link href="http://scoop-test.yogoko.fr/css/jquery-ui.min.css" rel="stylesheet" type="text/css">
<link href="http://scoop-test.yogoko.fr/css/jquery.bootgrid.min.css" rel="stylesheet" type="text/css">
<link href="http://scoop-test.yogoko.fr/css/tagmanager.css" rel="stylesheet" type="text/css">
<link href="http://scoop-test.yogoko.fr/css/mktree.css" rel="stylesheet" type="text/css">
<link href="http://scoop-test.yogoko.fr/css/vis.min.css" rel="stylesheet" type="text/css">
<link href="http://scoop-test.yogoko.fr/css/font-awesome.min.css" rel="stylesheet" type="text/css">
<link href="http://scoop-test.yogoko.fr/css/jquery.gridster.min.css" rel="stylesheet" type="text/css">
<link href="http://scoop-test.yogoko.fr/css/leaflet.css" rel="stylesheet" type="text/css">
<link href="http://scoop-test.yogoko.fr/css/MarkerCluster.css" rel="stylesheet" type="text/css">
<link href="http://scoop-test.yogoko.fr/css/MarkerCluster.Default.css" rel="stylesheet" type="text/css">
<link href="http://scoop-test.yogoko.fr/css/L.Control.Locate.min.css" rel="stylesheet" type="text/css">
<link href="http://scoop-test.yogoko.fr/css/leaflet.awesome-markers.css" rel="stylesheet" type="text/css">
<link href="http://scoop-test.yogoko.fr/css/select2.min.css" rel="stylesheet" type="text/css">
<link href="http://scoop-test.yogoko.fr/css/select2-bootstrap.min.css" rel="stylesheet" type="text/css">
<link href="http://scoop-test.yogoko.fr/css/query-builder.default.min.css" rel="stylesheet" type="text/css">
<link href="http://scoop-test.yogoko.fr/css/styles.css?ver=20191124" rel="stylesheet" type="text/css">
<link href="http://scoop-test.yogoko.fr/css/light.css?ver=632417642" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="css/templates.css">



<script src="http://scoop-test.yogoko.fr/js/polyfill.min.js"></script>
<script src="http://scoop-test.yogoko.fr/js/jquery.min.js"></script>
<script src="http://scoop-test.yogoko.fr/js/bootstrap.min.js"></script>
<script src="http://scoop-test.yogoko.fr/js/bootstrap-hover-dropdown.min.js"></script>
<script src="http://scoop-test.yogoko.fr/js/bootstrap-switch.min.js"></script>
<script src="http://scoop-test.yogoko.fr/js/hogan-2.0.0.js"></script>
<script src="http://scoop-test.yogoko.fr/js/jquery.cycle2.min.js"></script>
<script src="http://scoop-test.yogoko.fr/js/moment.min.js"></script>
<script src="http://scoop-test.yogoko.fr/js/bootstrap-datetimepicker.min.js"></script>
<script src="http://scoop-test.yogoko.fr/js/typeahead.bundle.min.js"></script>
<script src="http://scoop-test.yogoko.fr/js/jquery-ui.min.js"></script>
<script src="http://scoop-test.yogoko.fr/js/tagmanager.js"></script>
<script src="http://scoop-test.yogoko.fr/js/mktree.js"></script>
<script src="http://scoop-test.yogoko.fr/js/jquery.bootgrid.min.js"></script>
<script src="http://scoop-test.yogoko.fr/js/handlebars.min.js"></script>
<script src="http://scoop-test.yogoko.fr/js/pace.min.js"></script>
<script src="http://scoop-test.yogoko.fr/js/qrcode.min.js"></script>
<script src="http://scoop-test.yogoko.fr/js/jquery.lazyload.min.js"></script>
<script src="http://scoop-test.yogoko.fr/js/lazyload.js"></script>
<script src="http://scoop-test.yogoko.fr/js/select2.min.js"></script>
<script>
    $.ajaxSetup({
        headers: {
            'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
        }
    });
    var ajax_url = "http://scoop-test.yogoko.fr/ajax";
</script>
<script src="http://scoop-test.yogoko.fr/js/librenms.js?ver=20191025"></script>
<script type="text/javascript">
    function popUp(URL)
    {
        day = new Date();
        id = day.getTime();
        eval("page" + id + " = window.open(URL, '" + id + "', 'toolbar=0,scrollbars=1,location=0,statusbar=0,menubar=0,resizable=1,width=550,height=600');");
    }
    // End 
</script>
<script type="text/javascript" src="http://scoop-test.yogoko.fr/js/overlib_mini.js"></script>
<script type="text/javascript" src="http://scoop-test.yogoko.fr/js/toastr.min.js"></script>
<script type="text/javascript" src="http://scoop-test.yogoko.fr/js/boot.js"></script>
<script src="./refresh-config-version.js" defer></script>
<script src="./includes/nav.js" defer></script>
<style id="gridster-stylesheet" type="text/css">
    th{
        font-size: 13px;
    }
    td{
        font-size: 14px;
    }
    [data-col="1"] {
        left: 5px;
    }

    [data-col="2"] {
        left: 95.5px;
    }

    [data-col="3"] {
        left: 186px;
    }

    [data-col="4"] {
        left: 276.5px;
    }

    [data-col="5"] {
        left: 367px;
    }

    [data-col="6"] {
        left: 457.5px;
    }

    [data-col="7"] {
        left: 548px;
    }

    [data-col="8"] {
        left: 638.5px;
    }

    [data-col="9"] {
        left: 729px;
    }

    [data-col="10"] {
        left: 819.5px;
    }

    [data-col="11"] {
        left: 910px;
    }

    [data-col="12"] {
        left: 1000.5px;
    }

    [data-col="13"] {
        left: 1091px;
    }

    [data-col="14"] {
        left: 1181.5px;
    }

    [data-col="15"] {
        left: 1272px;
    }

    [data-col="16"] {
        left: 1362.5px;
    }

    [data-col="17"] {
        left: 1453px;
    }

    [data-col="18"] {
        left: 1543.5px;
    }

    [data-col="19"] {
        left: 1634px;
    }

    [data-col="20"] {
        left: 1724.5px;
    }

    [data-col="21"] {
        left: 1815px;
    }

    [data-row="1"] {
        top: 5px;
    }

    [data-row="2"] {
        top: 110px;
    }

    [data-row="3"] {
        top: 215px;
    }

    [data-row="4"] {
        top: 320px;
    }

    [data-row="5"] {
        top: 425px;
    }

    [data-row="6"] {
        top: 530px;
    }

    [data-row="7"] {
        top: 635px;
    }

    [data-row="8"] {
        top: 740px;
    }

    [data-row="9"] {
        top: 845px;
    }

    [data-row="10"] {
        top: 950px;
    }

    [data-row="11"] {
        top: 1055px;
    }

    [data-row="12"] {
        top: 1160px;
    }

    [data-row="13"] {
        top: 1265px;
    }

    [data-row="14"] {
        top: 1370px;
    }

    [data-row="15"] {
        top: 1475px;
    }

    [data-row="16"] {
        top: 1580px;
    }

    [data-sizey="1"] {
        height: 100px;
    }

    [data-sizey="2"] {
        height: 205px;
    }

    [data-sizey="3"] {
        height: 310px;
    }

    [data-sizey="4"] {
        height: 415px;
    }

    [data-sizey="5"] {
        height: 520px;
    }

    [data-sizey="6"] {
        height: 625px;
    }

    [data-sizey="7"] {
        height: 730px;
    }

    [data-sizey="8"] {
        height: 835px;
    }

    [data-sizey="9"] {
        height: 940px;
    }

    [data-sizey="10"] {
        height: 1045px;
    }

    [data-sizey="11"] {
        height: 1150px;
    }

    [data-sizey="12"] {
        height: 1255px;
    }

    [data-sizey="13"] {
        height: 1360px;
    }

    [data-sizey="14"] {
        height: 1465px;
    }

    [data-sizey="15"] {
        height: 1570px;
    }

    [data-sizex="1"] {
        width: 85.5px;
    }

    [data-sizex="2"] {
        width: 176px;
    }

    [data-sizex="3"] {
        width: 266.5px;
    }

    [data-sizex="4"] {
        width: 357px;
    }

    [data-sizex="5"] {
        width: 447.5px;
    }

    [data-sizex="6"] {
        width: 538px;
    }

    [data-sizex="7"] {
        width: 628.5px;
    }

    [data-sizex="8"] {
        width: 719px;
    }

    [data-sizex="9"] {
        width: 809.5px;
    }

    [data-sizex="10"] {
        width: 900px;
    }

    [data-sizex="11"] {
        width: 990.5px;
    }

    [data-sizex="12"] {
        width: 1081px;
    }

    [data-sizex="13"] {
        width: 1171.5px;
    }

    [data-sizex="14"] {
        width: 1262px;
    }

    [data-sizex="15"] {
        width: 1352.5px;
    }

    [data-sizex="16"] {
        width: 1443px;
    }

    [data-sizex="17"] {
        width: 1533.5px;
    }

    [data-sizex="18"] {
        width: 1624px;
    }

    [data-sizex="19"] {
        width: 1714.5px;
    }

    [data-sizex="20"] {
        width: 1805px;
    }
    
</style>
`;
const html = document.write(head);

// function afficherPopup(message, type) {
//     const popup = document.getElementById('popup');
//     const popupText = document.getElementById('popup-text');
  
//     popupText.textContent = message;
//     popup.classList.add(type);
//     popup.classList.add('fade-in'); // Ajoutez la classe pour l'animation
//     popup.style.display = 'block';
  
//     setTimeout(() => {
//       popup.classList.remove(type);
//     //   popup.classList.remove('fade-in'); // Retirez la classe après l'animation
//       popup.style.display = 'none';
//     }, 2000); // La pop-up disparaîtra après 3 secondes (3000 millisecondes)
//   }
//   window.onload = function() {
//     console.log(localStorage.getItem('showPopup'));

//     if (localStorage.getItem("showPopup") === "true") {
//         console.log(localStorage.getItem('showPopup'));

//       afficherPopup("Suppression du template Réussi !", "ff");
//       // Après avoir affiché la pop-up, réinitialisez la valeur dans le stockage local
//       localStorage.setItem("showPopup", "false");
//     }
//     console.log(localStorage.getItem('showPopup'));

//   };
  
  
  // Exemple d'utilisation :
  // Pour une pop-up verte :
  // afficherPopup("Opération réussie", "green");
  // Pour une pop-up rouge :
  // afficherPopup("Erreur lors de l'opération", "red");
  