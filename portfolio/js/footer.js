let footer = document.body;
let htmlFooter = `  
<footer>
    <div class="footer">
        <address>4 rue des genets <br> 29190 PLeyben <br> France </address>
        <iframe class="google-maps"
            src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d2657.9790670758453!2d-3.9639359845750466!3d48.226277652958295!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x48113bb74bf66977%3A0x33b4bd08f638b756!2s4%20Rue%20des%20Gen%C3%AAts%2C%2029190%20Pleyben!5e0!3m2!1sfr!2sfr!4v1653734621481!5m2!1sfr!2sfr"
            width="600" height="100" style="border:0;" allowfullscreen="" loading="lazy"
            referrerpolicy="no-referrer-when-downgrade"></iframe>
        <p>© Titouan Le Brun | Tous droits Réservés</p>
        <p>
            <a class="link-contact" href="./contact.html">Contactez-moi</a> - 07 82 53 95 59 
            <p>
                <a class="link-contact" href="http://www.linkedin.com/in/titouan-le-brun-8ab329223">Linkedin</a>
            </p>
        </p>
    </div>
</footer>`;
footer.insertAdjacentHTML('beforeend', htmlFooter);