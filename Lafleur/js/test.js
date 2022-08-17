
let htmlMenu = '<header><div class="header"><div><a href="./menu.html" class="liens">Accueil</a><a href="./panier.html" class="liens">Panier</a><a href="" class="liens">Connexion</a><a href="" class="liens">Catalogues</a></div><h1>Site Lafleur</h1><img src="" alt="Logo Site Lafleur"></div>         </header>';

let header2 = document.body

console.log(header2);

header2.insertAdjacentHTML('beforebegin', htmlMenu);
