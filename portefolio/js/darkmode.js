const mode = document.querySelector('.mode');
const check = document.querySelector('.check');
const bool = document.querySelector('.bool');

check.addEventListener('click', () =>{
    bool.classList.toggle('bool-translate');
    document.body.classList.toggle('dark-theme');

});