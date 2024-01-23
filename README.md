# BOUHMIDI_lab3 : Take a bite into newton's apple

## Sketch de l'architecture

L'architecture de notre système est conçue pour obtenir et traiter les données de retour provenant du gyroscope intégré à la carte. Pour établir la communication avec le gyroscope, l'IP opencore I2C est intégrée à notre système. De plus, deux PIO sont utilisés pour fournir les données à afficher sur les afficheurs 7 segments implémentés en VHDL. Un timer est également inclus dans notre architecture, générant des interruptions régulières pour mettre à jour les données du gyroscope. Pour permettre une interaction utilisateur, un PIO d'entrée est configuré avec un bouton-poussoir (BP) qui permet de changer entre les valeurs X, Y et Z du gyroscope, ces valeurs étant ensuite affichées sur l'écran LCD.

![image](https://github.com/ESN2024/BOUHMIDI_lab3/assets/144927751/a5b6f5a4-bd8f-420a-8f50-bffb2910b8cc)



## Architecture sur QSYS

Concernant l'architecture, elle est un peu similaire à celle du LAB2 du point de vu de l'affichage de données sur le 7 segments, à savoir deux PIO, chacun comprenant trois digits, générant ainsi deux sorties logicielle de 12 bits, à savoir 4 bits par digit. Au niveau matériel, un composant VHDL, "bin_to_7seg.vhd", a été développé comme décodeur pour les afficheurs 7 segments. La sortie de notre architecture globale comprend donc 2 fois 21 bits pour correspondre aux entrées des décodeurs 7 segments de chaque afficheur.
En plus du Opencore I2C permettant la communication avec le gyroscope :

![image](https://github.com/ESN2024/BOUHMIDI_lab3/assets/144927751/c3f783c9-6827-444d-9444-b6808dd82b09)
![image](https://github.com/ESN2024/BOUHMIDI_lab3/assets/144927751/f013be6e-298a-4293-9599-b467486bfaf5)

