const mode = document.querySelector('.mode');
const check = document.querySelector('.check');
const bool = document.querySelector('.bool');

// console.log(localStorage.getItem("mode"));
localStorage.getItem("mode") == "false" ?
    (
        document.body.classList.add('dark-theme'),
        bool.classList.add('bool-translate')
    )
    :
    (
        document.body.classList.remove('dark-theme'),
        bool.classList.remove('bool-translate')

    );
check.addEventListener('click', () => {
    bool.classList.toggle('bool-translate');
    localStorage.getItem("mode") == "false" ? (localStorage.setItem("mode", "true"), document.body.classList.remove('dark-theme'))
        : (localStorage.setItem("mode", "false"), document.body.classList.add('dark-theme'));
    // console.log(localStorage.getItem("mode"));

});