********************************************************************************
*				STATA: Data processing
*
*				BY Harouna TRAORE
*				
********************************************************************************

// ctrl+L: Select the line 
// ctrl+D : Execute the line


//**** Import stata format dataset 
use "D:\UN jobs application\Code samples\STATA\STATA_codes_for_data_analysis_and_econometrics\STATA_codes_for_data_analysis_and_econometrics\raw datasets\compose_men"

//*******************  Data management *****************//
//***** describe the master dataset
describe
codebook
summarize

//Pour avoir le nom des variables	ds:describe short
ds
//(b) description des variables dont le nom commence par B
describe B*
//(b) description des variables dont le nom contient "i"
//On peut le faire à partir de la barre de recherche au dessus des variables
//Sinon on peut le faire avec le code lookfor avec le mot cherché en argument
lookfor i
lookfor emploi
//liste des individus de la 3ieme ligne à la 54ieme ligne
list in 3/54
list B2-B6
count
list B2-B6 in 3/54
//Pour avoir jusqu'à la dernière ligne
list in 23000/l
//Pour avoir les deux dernières lignes
list in -2/l
//Compter les individus qui ont 70 ans et plus (veiller à enlever les données manquantes ainsi que les "ne sait pas" ou valeur 999, etc.)
count if B4>=70
count if B4==.
count if B4>=70 & B4!=.
browse B4
count if B4>=70 & B4!=. & B4!=999
browse if B4>=70 & B4!=. & B4!=999
//Calculatrice
display 2+3
//On peut faire des somme de matrice, etc
//Pour passer carrément en mode calculatrice
mata
2+3
end
//Pour trier une base
sort B4
browse B4
//hilo : highest lowest
hilo B4
hilo B4 if B4!=.
help hilo
//Affiche des labels de la variable niveau d'instruction
label list B6
tabulate B5
tabulate B5, nolab
//On peut ajouter au label son code
numlabel B5, add
tabulate B5
browse if B5==1 | B5==3
//Définir label
/* On a trois types de label
1- Le label de la base
3- Le label de la variable
3- Le label des modalités

*/

//Labélisation de la base de données
label data "Base de données des individus des ménages de Dakar"
//Labélisation d'une variable
label variable nom_variable "label"
label variable B3 "Sexe des individus"
//Labélisation des modalité définition et allocation
//Méthode 1
label define ouinon 1 "oui" 2 "non"
label list ouinon
gen ouinon = 1 if B3==1		//création de la variable ouinon
replace ouinon=2 if ouinon!=1
//Méthode 2
label define ouinon 1 "oui"
label define ouinon 2 "non", add
//Méthode 3 (délimit ; veut dire que chaque syntaxe se termine par ";". On aurait pu mettre quelque chose d'autre.)
#delimit ;
label define ouinon 1 "oui"
					2 "non";
#delimit cr			//Pour revenir à la normale
//Affection de label à une variable (label values variable label)
label values ouinon ouinon
//Enlever le label de la variable
label values ouinon

//Création de variable
generate
egen //extension de generate
gen age_rec =1 if B4<20
replace age_rec =2 if B4>= 20 & B4 <60
replace age_rec = 3 if B4>60
replace age_rec =. if B4==.|B4==999

//On peut utiliser la commande suivante mais l'intervalle est fermé à droite
gen age_rec = recode(nom variable, borne sup1, borne sup2, etc.)
gen age_rec = recode(B4, 20 ,60, 100)

/*	moins de 20
	entre 20 et 60
	plus de 60
*/
//Couper de 0 à 100 par pas de 20
egen age_rec = cut(B4), at(0(20)100)
//Couper de 0 à 100 en 5 groupes
egen age_rec = cut(B4), group(5)
//Benen méthode encore
recode B4 (0/20=1) (20/59=2) (60/100=3), generate age_rec


//Recode pour labeliser (changer les modalités)
recode age_rec (20=1) (60=2) (100=3)


//Croisement de deux variables (distribution de la i eme modalités de la première variable aux modalités de l'autre)
/*	sexe 1 age 1
	sexe 1 age 2
	...
	sexe 1 age n
	sexe 2 age 1
	sexe 2 age 2
	...
	sexe 2 age n
*/
egen sex_age = group(B3 age_rec)

***************************seance ratée**************
*****************************************************
//Remplacer toutes les modalités ne sait pas par des valeurs manquantes pour l'age
**on regarde d'abord le code de la modalité ne sait pas
numlabel B4, add
tab B4
**ensuite on remplace en faisant
replace B4=. if B4==999
**ou bien
recode B4 (999=.)
//mvencode & mvdecode
mvdecode B4, mv(999=.) //on passe de 999 à  .
mvencode B4, mv(.=999) //on passe de . à 999

//Tirer un échantillon de 25%
**Création de frame
frame create base
**changement d'une frame à une autre
frame change base
frame change default
**échantillonnage
preserve
sample 25			//25 pourcent
sample 25, count	//25 individus
restore

//fusion de bases selon l'id
preserve
**on ajoute des variables pour les memes individus
merge 1:1 variable_id using "chemin_de_l_autre_base_qu_on_veut"
merge 1:1 _n using "chemin_de_l_autre_base_qu_on_veut"
**on ajoute des individus avec les memes variables
append using "chemin_de_l_autre_base_qu_on_veut"

//table, collapse, contract, reshape, tabstat

