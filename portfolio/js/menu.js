let header2 = document.body;

let htmlMenu = ` 
<header>
    <div id="main-item-menu">

        <a class="back-history-link" onclick="history.back()">
            <div class="arrow">
                <div class="left-arrow"></div>
                <div class="line-arrow"></div>
            </div>
        </a>
        <h1><a class="title-home" href="./index.html">Titouan Le Brun</a></h1>
        <div id="h">

            <div id="hamburger"><span class="line-menu-burger"></span></div>
        </div>
    </div>
    <nav class="navigation-menu">
        <a href="./index.html" class="link">Accueil</a>
        <a href="./projets.html" class="link">Projets</a>
        <a href="./certifications.html" class="link">Certifications</a>
        <a href="./veille.html" class="link">Veille</a>
        <a href="./stages.html" class="link">Stages</a>
        <a href="./tableau.html" class="link">Tableau de synthèse</a>

        
    </nav>

    <div class="center-mode">
        <label class="mode" for="darkmode">
            <div class="bool"></div>
        </label>
        <input class="check" type="checkbox" name="darkmode" id="darkmode">
    </div>
</header>

`;

header2.insertAdjacentHTML('afterbegin', htmlMenu);



const hamburger = document.getElementById('hamburger')
const lines = document.querySelector('.line-menu-burger')
const navBar = document.querySelector('.navigation-menu');
hamburger.addEventListener('click', () => {
    lines.classList.toggle('active')
    navBar.classList.toggle('active')

})



let lastScrollTop = 0;
let nav = document.getElementsByTagName("header");
window.addEventListener("scroll", function() { 
    let scrollTop = this.window.scrollY
    console.log(this.screen.height);
    if(!navBar.classList.contains('active') )
    {
        if (lastScrollTop >= scrollTop){
            nav[0].style.position = "fixed";
            nav[0].style.top = "0";
            nav[0].style.left = "0";
            nav[0].style.right = "0";
            nav[0].style.transition = `300ms ease-in-out`;

            nav[0].style.transform = `translateY(0px)`;
            
        }else {
            nav[0].style.transform = "translateY(-80px)";
            nav[0].style.position = "relative";
            nav[0].style.transition = `300ms ease-in-out`;

    
        }
        if(this.window.scrollY < 200){
            nav[0].style.transform = "translateY(0px)";
            nav[0].style.position = "relative";
            nav[0].style.transition = `300ms ease-in-out`;

        }
        lastScrollTop = scrollTop;
    }


})/* do this action when the user scroll */