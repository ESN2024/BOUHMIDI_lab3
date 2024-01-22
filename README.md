# BOUHMIDI_lab3 : Take a bite into newton's apple

## Sketch de l'architecture

L'architecture de notre système est conçue pour obtenir et traiter les données de retour provenant du gyroscope intégré à la carte. Pour établir la communication avec le gyroscope, l'IP opencore I2C est intégrée à notre système. De plus, deux PIO sont utilisés pour fournir les données à afficher sur les afficheurs 7 segments implémentés en VHDL. Un timer est également inclus dans notre architecture, générant des interruptions régulières pour mettre à jour les données du gyroscope. Pour permettre une interaction utilisateur, un PIO d'entrée est configuré avec un bouton-poussoir (BP) qui permet de changer entre les valeurs X, Y et Z du gyroscope, ces valeurs étant ensuite affichées sur l'écran LCD.

![image](https://github.com/ESN2024/BOUHMIDI_lab3/assets/144927751/a5b6f5a4-bd8f-420a-8f50-bffb2910b8cc)



## Architecture sur QSYS

![image](https://github.com/ESN2024/BOUHMIDI_lab3/assets/144927751/7aed2c48-2c61-4f62-825b-0511d76dddd4)
![image](https://github.com/ESN2024/BOUHMIDI_lab3/assets/144927751/21ffef58-6d63-4a73-a9a1-1539b2d860a0)
