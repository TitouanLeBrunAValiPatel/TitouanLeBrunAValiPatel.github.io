<?php

if [ -e /tmp/Peso.dump ]
then
    echo "Mon fichier existe"
	dropdb pesee
	createdb -T postgres pesee
	pg_restore -d pesee /tmp/Peso.dump
	mv /tmp/Peso.dump /tmp/Peso_old.dump
	
else
    echo "Mon fichier n'existe pas"
fi

?>