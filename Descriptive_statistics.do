********************************************************************************
*				STATA: Descriptive statistics
*
*				BY Harouna TRAORE
*				
********************************************************************************

// ctrl+L: Select the line 
// ctrl+D : Execute the line

//**** Import stata format dataset 
use "D:\UN jobs application\Code samples\STATA\STATA_codes_for_data_analysis_and_econometrics\STATA_codes_for_data_analysis_and_econometrics\raw datasets\compose_men"

//STATISTIQUE DESCRIPTIVE
**Moyenne d'âge
mean B4
sum B4
**Médiane (pour ce cas, STATA fait des tests non par)
median B4, by(B3)
**Autre méthode
summarize B4, detail
**Coefficient de correlation
correlate B4 B5 B6
**Intervalle de confiance de la moyenne
ci means B4
ci means B4, level(90)
**Avoir les quartiles (par défaut on a la deuxieme quartile)
centile B4
**Premiere quatile
centile B4, centile(25)
//Question 2 Tabulation de variables
tab1 B3 B5 B6
tab2 B5-B8
**Chi-deux sans tableau de contingence
tab2 B7 B8, chi2 nofreq
tab2 B5-B8, chi2 nofreq
**FAire des stat desc sur des variables quantitatives
tabstat 
**Tableau à trois dimensions
table B3 B4 B5
**Rreprésentation graphique de moyennes selon des groupes
grmeanby B3 B5 B6, sum(B4)
//Test d'hypothèse Skewness
sktest B4
swilk B4
sfrancia B4
//Tester l'egalité de la moyenne d'âge suivant le sexe
**B3 une variable binaire
sdtest B4, by(B3)
ttest B4, by(B3)
**Pour une variable à plusieurs modalités
pwmean B4, over(B5) effects
**Test de significativité du coefficient de correlation (test de nullité)
pwcorr B4 B5 B6, sig

