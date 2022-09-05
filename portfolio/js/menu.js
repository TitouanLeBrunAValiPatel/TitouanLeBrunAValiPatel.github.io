let header = document.body;
let htmlMenu = `<header>
<a class="lien_back_history" onclick="history.back()">
    <!-- retour en arriere --><span class="trait_retour"></span>
</a>
<h1><a class="h1_home" href="./index.html">Titouan Le Brun</a></h1>
<div class="menu_deroulant"> 
    <input class="checkbox_menu_deroulant" type="checkbox" name="checkbox_menu_deroulant" id="checkbox_menu_deroulant"> 
    <label class="btn_menu_deroulant" for="checkbox_menu_deroulant">     <!-- le for doit avoir le meme id que la checkbox très important --> 
        <span class="trait_menu_deroulant"></span>
    </label>
    <nav class="menu_navigation"> 
        <a href="./index.html" class="liens">Accueil</a> 
        <a href="./projets.html" class="liens">Projets</a> 
        <a href="./certifications.html" class="liens">Certifications</a> 
        <a href="./veille.html" class="liens">Veille</a> 
        <a href="./stages.html" class="liens">Stages</a>
        <div class="mode_center"> 
            <label class="mode" for="darkmode">
                <div class="bool"></div>
            </label> 
            <input class="check" type="checkbox" name="darkmode" id="darkmode"> 
        </div>
    </nav>
</div>
</header>`;
header.insertAdjacentHTML('afterbegin', htmlMenu);