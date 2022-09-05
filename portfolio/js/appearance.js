const animation = document.querySelectorAll('.animation');
const animation2 = document.querySelectorAll('.animation2');



function animationP(array, appearanceHeight, animationName) {
    array.forEach(element => {
        const {scrollTop, clientHeight} = document.documentElement;
        const topElementToTopViewport = element.getBoundingClientRect().top;
    
        if(scrollTop > scrollTop + topElementToTopViewport - clientHeight * appearanceHeight) {
                element.classList.add(animationName);
            }
    
        window.addEventListener('scroll', () =>{
            const {scrollTop, clientHeight} = document.documentElement;
            const topElementToTopViewport = element.getBoundingClientRect().top;
            if(scrollTop > scrollTop + topElementToTopViewport - clientHeight * appearanceHeight) {
                    element.classList.add(animationName);
                }
        })
        
    });
    
}

animationP(animation, 0.8, 'animation-left');
animationP(animation2, 0.5, 'animation-f');