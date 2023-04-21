
/**
 * Enable the appearance on left or right
 * @param {*} array className of the element that you want the animation do
 * @param {*} appearanceHeight the height of the appearance on the screen (ex : 0.9 the element appearance in bottom the screen)
 */
function animationLRLeftRight(array, appearanceHeight) {

    for (let index = 0; index < array.length; index++) {
        const element = array[index];
        if (index % 2 === 0) {
            element.style.transform = `translateX(-${screen.width}px)`
        } else {
            element.style.transform = `translateX(${screen.width}px)`
        }
        if (element.offsetTop < (window.scrollY + document.documentElement.clientHeight * appearanceHeight)) {
            element.style.transition = "500ms all"
            element.style.transform = `translateX(0px)`

        }
    
    }
    
    window.addEventListener("scroll", () => {
        array.forEach(element => {    
            if (element.offsetTop < (window.scrollY + document.documentElement.clientHeight * appearanceHeight)) {
                element.style.transition = "500ms all"
                element.style.transform = `translateX(0px)`
            }
        });
    })
    
}
/**
 * Enable the appearance on fade
 * @param {*} array className of the element that you want the animation do
 * @param {*} appearanceHeight the height of the appearance on the screen (ex : 0.9 the element appearance in bottom the screen)
 */
function animationFade(array, appearanceHeight) {

    for (let index = 0; index < array.length; index++) {
        const element = array[index];
        element.style.opacity = 0;
        if (element.offsetTop < (window.scrollY + document.documentElement.clientHeight * appearanceHeight)) {
            element.style.transition = "1s all"
            element.style.opacity = 1

        }
    }
    
    window.addEventListener("scroll", () => {
        array.forEach(element => {    
            if (element.offsetTop < (window.scrollY + document.documentElement.clientHeight * appearanceHeight)) {
                element.style.transition = "1s all"
                element.style.opacity = 1
            }
        });
    })
    
}
const animationLR = document.querySelectorAll('.animationLR');
animationLRLeftRight(animationLR, 0.9);

const animationF = document.querySelectorAll('.animationF');
animationFade(animationF, 0.9);
