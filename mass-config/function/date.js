    const dateActuelle = new Date();

    const annee = dateActuelle.getFullYear();
    const mois = dateActuelle.getMonth() + 1; // Month start at 0, so add 1
    const jour = dateActuelle.getDate();
    const heures = dateActuelle.getHours();
    const minutes = dateActuelle.getMinutes();
    const secondes = dateActuelle.getSeconds();
    
    // Create a date format : "AAAA-MM-JJ HH:MM:SS"
    const dateHeure = `${annee}-${mois.toString().padStart(2, '0')}-${jour.toString().padStart(2, '0')} ${heures.toString().padStart(2, '0')}:${minutes.toString().padStart(2, '0')}:${secondes.toString().padStart(2, '0')}`;

    document.getElementById('lastModification').textContent = dateHeure;