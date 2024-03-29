# BOUHMIDI_lab3 : Take a bite into newton's apple

## Sketch de l'architecture

L'architecture de notre système est conçue pour obtenir et traiter les données de retour provenant du gyroscope intégré à la carte. Pour établir la communication avec le gyroscope, l'IP opencore I2C est intégrée à notre système. De plus, deux PIO sont utilisés pour fournir les données à afficher sur les afficheurs 7 segments implémentés en VHDL. Un timer est également inclus dans notre architecture, générant des interruptions régulières pour mettre à jour les données du gyroscope. Pour permettre une interaction utilisateur, un PIO d'entrée est configuré avec un bouton-poussoir (BP) qui permet de changer entre les valeurs X, Y et Z du gyroscope, ces valeurs étant ensuite affichées sur l'écran LCD.

![image](https://github.com/ESN2024/BOUHMIDI_lab3/assets/144927751/a5b6f5a4-bd8f-420a-8f50-bffb2910b8cc)



## Architecture sur QSYS

Concernant l'architecture, elle est un peu similaire à celle du LAB2 du point de vu de l'affichage de données sur le 7 segments, à savoir deux PIO, chacun comprenant trois digits, générant ainsi deux sorties logicielle de 12 bits, à savoir 4 bits par digit. Au niveau matériel, un composant VHDL, "bin_to_7seg.vhd", a été développé comme décodeur pour les afficheurs 7 segments. La sortie de notre architecture globale comprend donc 2 fois 21 bits pour correspondre aux entrées des décodeurs 7 segments de chaque afficheur.
En plus du Opencore I2C permettant la communication avec le gyroscope :

![image](https://github.com/ESN2024/BOUHMIDI_lab3/assets/144927751/c3f783c9-6827-444d-9444-b6808dd82b09)
![image](https://github.com/ESN2024/BOUHMIDI_lab3/assets/144927751/f013be6e-298a-4293-9599-b467486bfaf5)

## Reécriture des fonction read et write 

En suivant les trames suivantes :

![image](https://github.com/ESN2024/BOUHMIDI_lab3/assets/144927751/b3f340be-e281-41cf-9686-1f3199d255de)


### Fonction read

![image](https://github.com/ESN2024/BOUHMIDI_lab3/assets/144927751/4b94711a-96d4-460b-9553-29c6a1acad88)

### Fonction write

![image](https://github.com/ESN2024/BOUHMIDI_lab3/assets/144927751/9202ffeb-b560-41c6-a0b5-90ab43ef16ef)


## Read les registres de données
On a d'après la doc les différents registres donnant accès aux données suivant les 3 axes :

![image](https://github.com/ESN2024/BOUHMIDI_lab3/assets/144927751/a1c57a3f-e181-4ca8-a220-64f2ee037e58)

On définit ces registre dans notre code :

![image](https://github.com/ESN2024/BOUHMIDI_lab3/assets/144927751/5e9ab7de-1a5b-414f-830f-891568b6e6e7)

On peut alors accèder aux données présentes dans les registres, et les lire grâce à la fonction I2C_read_gyro :

![image](https://github.com/ESN2024/BOUHMIDI_lab3/assets/144927751/9027bd21-88ad-45dd-ae82-b2af926ccd2b)


## Affichage des données sur le shell nios 
Affichage des données avec le timer cadencé à 1s

![image](https://github.com/ESN2024/BOUHMIDI_lab3/assets/144927751/7da6dbf7-6eda-432e-b2e4-629c9d0dbe12)


## Ajout interruption du BP pour changer d'axe
### Architecture QSYS
On permet au SELECT représentant le BP, de générer des interruption avec une priorité plus faible que celle du timer : 

![image](https://github.com/ESN2024/BOUHMIDI_lab3/assets/144927751/5d00a569-e319-4585-afed-54c68a3aa7d1)

### ISR du BP
L'ISR enclanchée par le BP incrémente une variable globale, entre 0 et 2, permettant de choisir l'axe à afficher, à savoir 0 pour X, 1 pour Y et 2 pour Z :

![image](https://github.com/ESN2024/BOUHMIDI_lab3/assets/144927751/b3a23163-6b95-4845-bbb0-c9af97df4df8)

La valeur SELECT est utilisée par une autre ISR, celle du timer, permettant d'afficher les données selon l'axe choisi.


