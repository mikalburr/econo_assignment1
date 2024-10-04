/***

Michael Burrage II
Econometrics 
Assignment 1

***/

//QUESTION 1
* load csv file
import delimited "/Users/michaelburrageii/Library/Mobile Documents/com~apple~CloudDocs/Documents/Burrage II_OP_PhD/Year2/FA24/Econometrics/Assignment 1/untitled folder/dataset_nobel_chocolate.csv", clear

* summary statistics
summarize nobel chocolate

//QUESTION 2
* scatter plot: chocolate  vs. nobel laureates
graph twoway (scatter nobel chocolate), xlabel(0(2)15) ylabel(0(2)35) ///
title("Chocolate Consumption vs. Nobel Laureates")

//QUESTION 3 A
* correlation : chocolate and nobel laureates
correlate nobel chocolate

//QUESTION 3 B
* exclude Sweden and redo correlation
drop if name == "Sweden"
correlate nobel chocolate

//QUESTION 3 C
*  regression of nobel laureates on chocolate 
regress nobel chocolate

//QUESTION 3 D
* amount of chocolate needed for the U.S. to produce 1 additional laureate
gen additional_chocolate = 1/2.579

* recalc correlation and regression excluding Sweden
drop if name == "Sweden"
correlate nobel chocolate
regress nobel chocolate

//QUESTION 4 - QUESTION 7 on pdf

//QUESTION 8
* change to dta and rename to "country_name"
import delimited "/Users/michaelburrageii/Library/Mobile Documents/com~apple~CloudDocs/Documents/Burrage II_OP_PhD/Year2/FA24/Econometrics/Assignment 1/untitled folder/dataset_nobel_chocolate.csv", clear
rename name country_name
* clean names
replace country_name = subinstr(country_name, "UnitedStates", "United States", .)
replace country_name = subinstr(country_name, "UnitedKingdom", "United Kingdom", .)
save "chocolate_nobel.dta", replace

*load extended data, rename, clean
use "/Users/michaelburrageii/Library/Mobile Documents/com~apple~CloudDocs/Documents/Burrage II_OP_PhD/Year2/FA24/Econometrics/Assignment 1/untitled folder/dataset_nobel_chocolate_extended.dta", clear
rename name country_name
replace country_name = ustrregexra(country_name, "�", "")
replace country_name = trim(country_name)
replace country_name = subinstr(country_name, "United States", "United States", .)
replace country_name = subinstr(country_name, "United Kingdom", "United Kingdom", .)

save "cleaned_data.dta", replace

* cleaned .dta file
use "cleaned_data.dta", clear

* merge and check
merge 1:1 country_name using "chocolate_nobel.dta"
tab _merge
keep if _merge == 3
save "merged_data.dta", replace

* Regression with additional variables
regress nobel chocolate gdp life
