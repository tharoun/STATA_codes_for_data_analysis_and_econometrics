********************************************************************************
*				STATA BASIC CONCEPT
*
*				BY Harouna TRAORE
*				
********************************************************************************

// ctrl+L: Select the line 
// ctrl+D : Execute the line



//****************  General commands ****************// 

//******* help screen for any command
* help command
help cd

//******** check the directory 
pwd

//***** Change the working directory
cd "D:\UN jobs application\Code samples\STATA\STATA_codes_for_data_analysis_and_econometrics\STATA_codes_for_data_analysis_and_econometrics"

//***** Display and use stata as calculator
/* Clear the memory*/
clear all 
/* Display strings (Traditional hello world!)*/
display "hello, world!"
/* Display number*/
display 1 + 4
display ln(0.3 / (1 - 0.3))

// System values
display c(current_date)


//****************  Import datasets and saving ****************//

//**** Import stata format dataset 
use "D:\UN jobs application\Code samples\STATA\STATA_codes_for_data_analysis_and_econometrics\STATA_codes_for_data_analysis_and_econometrics\raw datasets\compose_men"

//**** Import excel format dataset
import excel "D:\UN jobs application\Code samples\STATA\STATA_codes_for_data_analysis_and_econometrics\STATA_codes_for_data_analysis_and_econometrics\Raw datasets\data_etalons.xlsx", sheet("Feuil1") firstrow clear

//**** Import csv format dataset
import delimited "D:\UN jobs application\Code samples\STATA\STATA_codes_for_data_analysis_and_econometrics\STATA_codes_for_data_analysis_and_econometrics\Raw datasets\FAO_grains_NA.csv", encoding(ISO-8859-2) clear

//****** saving master dataset in STATA format
save master_dataset.dta, replace


