cd "C:\Users\Dimitris\Desktop\"

use "gas_data.dta", clear

//////Data Manipulation
keep if year==2019
drop if iso3_country=="EU28"
drop if iso3_country=="EU27"
gen lngas=ln(gas)
gen lnpop=ln(pop)
gen lnsiz=ln(size)

//////Correlation Indexes
corr gas size population

//////Graphs
////Scatter plots - Gas Emissions & Population
quietly regress gas population 
// find dependent variable
local eq `"`e(depvar)' ="'
// choose display format for the constant
local eq "`eq' `: di  %5.2f _b[_cons]'"
// add or subtract the coefficient and choose display format
local eq `"`eq' `=cond(_b[population]>0, "+", "-")'"'
local eq `"`eq'`:di %5.2f abs(_b[population])' pop"'
// add the error term
local eq `"`eq' + {&epsilon}"'

twoway scatter gas population ,   msymbol() msize(tiny) mlabel(iso3_country) mlabsize(vsmall) ///
 ytitle("Total Greenhouse gas emissions (thousands tonnes)" , size(medsmall))  ///
 ylabel(,labsize(small)) ysca(titlegap(.8)) text(750000 30000000 "{bf:{it:`eq'}}", size(medsmall) col(black))  ///
 xtitle("Population" , size(medsmall)) xlabel(,labsize(small))  xsca(titlegap(.8)) ///
 || lfit   gas population , legend(off) name(gr1 , replace) 
 
quietly regress lngas lnpop 
// find dependent variable
local eq `"`e(depvar)' ="'
// choose a  display format for the constant
local eq "`eq' `: di  %3.2f _b[_cons]'"
// add or subtract the coefficient and choose display format
local eq `"`eq' `=cond(_b[lnpop]>0, "+", "-")'"'
local eq `"`eq'`:di %5.2f abs(_b[lnpop])' lnpop"'
// add the error term
local eq `"`eq' + {&epsilon}"'
  
twoway scatter lngas lnpop ,   msymbol() msize(tiny) mlabel(iso3_country) mlabsize(vsmall) ///
 ytitle("Ln of Total Greenhouse gas emissions (thousands tonnes)" , size(medsmall))  ///
 ylabel(,labsize(small)) ysca(titlegap(.8))  ///
 xtitle("Ln of Population" , size(medsmall)) xlabel(,labsize(small))  xsca(titlegap(.8))  text(13.35 15.1 "{bf:{it:`eq'}}", size(medsmall) col(black))  ///
 || lfit   lngas lnpop , legend(off) name(gr2 , replace)
  
graph combine gr1 gr2,   col(2) 
graph export graph1.png
 
 
////Scatter plots - Gas Emissions & Population
quietly regress gas size 
// find the dependt variable
local eq `"`e(depvar)' ="'
// choose a nice display format for the constant
local eq "`eq' `: di  %7.2f _b[_cons]'"
// add or subtract the coefficient and choose display format
local eq `"`eq' `=cond(_b[size]>0, "+", "-")'"'
local eq `"`eq'`:di %5.2f abs(_b[size])' siz"'
// add the error term
local eq `"`eq' + {&epsilon}"'

twoway scatter gas size ,   msymbol() msize(tiny) mlabel(iso3_country) mlabsize(vsmall) ///
 ytitle("Total Greenhouse gas emissions (thousands tonnes)" , size(medsmall))  ///
 ylabel(,labsize(vsmall)) ysca(titlegap(.8))  ///
 xtitle("Size of country (thousands of km{superscript:2})" , size(medsmall)) xlabel(,labsize(vsmall))  xsca(titlegap(.8)) text(750000 220000 "{bf:{it:`eq'}}", size(medsmall) col(black))  ///
 || lfit   gas size , legend(off) name(gr3 , replace)

 //Scatter plots - Gas Emissions & Population
quietly regress lngas lnsiz 
// find the dependt variable
local eq `"`e(depvar)' ="'
// choose a nice display format for the constant
local eq "`eq' `: di  %3.2f _b[_cons]'"
// add or subtract the coefficient and choose display format
local eq `"`eq' `=cond(_b[lnsiz]>0, "+", "-")'"'
local eq `"`eq'`:di %5.2f abs(_b[lnsiz])' lnsiz"'
// add the error term
local eq `"`eq' + {&epsilon}"'

twoway scatter lngas lnsiz ,   msymbol() msize(tiny) mlabel(iso3_country) mlabsize(vsmall) ///
 ytitle("Ln of Total Greenhouse gas emissions (thousands tonnes)" , size(medsmall))  ///
 ylabel(,labsize(vsmall)) ysca(titlegap(.8))  ///
 xtitle("Ln of Size of country (thousands of km{superscript:2})" , size(medsmall)) xlabel(,labsize(vsmall))  xsca(titlegap(.8))  text(13.1 8.8 "{bf:{it:`eq'}}", size(medsmall) col(black))  /// ///
 || lfit   lngas lnsiz , legend(off) name(gr4 , replace)
 
graph combine gr3 gr4,   col(2) 
graph export graph2.png

 
   
 
////Graphs (without printing regressions)
//Scatter plots - Gas Emissions & Population
twoway scatter gas population ,   msymbol() msize(tiny) mlabel(iso3_country) mlabsize(vsmall) ///
 ytitle("Total Greenhouse gas emissions (thousands tonnes)" , size(small))  ///
 ylabel(,labsize(vsmall)) ysca(titlegap(.8))  ///
 xtitle("Population" , size(small)) xlabel(,labsize(vsmall))  xsca(titlegap(.8)) ///
 || lfit   gas population , legend(off) name(gr1 , replace)

twoway scatter lngas lnpop ,   msymbol() msize(tiny) mlabel(iso3_country) mlabsize(vsmall) ///
 ytitle("Ln of Total Greenhouse gas emissions (Thousands tonnes)" , size(small))  ///
 ylabel(,labsize(vsmall)) ysca(titlegap(.8))  ///
 xtitle("Ln of Population" , size(small)) xlabel(,labsize(vsmall))  xsca(titlegap(.8)) ///
 || lfit   loggas logpop , legend(off) name(gr2 , replace)
 
graph combine gr1 gr2,   col(2)
graph export graph1a.png

//Scatter plots - Gas Emissions & Population
twoway scatter gas size ,   msymbol() msize(tiny) mlabel(iso3_country) mlabsize(vsmall) ///
 ytitle("Total Greenhouse gas emissions (thousands tonnes)" , size(small))  ///
 ylabel(,labsize(vsmall)) ysca(titlegap(.8))  ///
 xtitle("Size of country (thousands of km{superscript:2})" , size(small)) xlabel(,labsize(vsmall))  xsca(titlegap(.8)) ///
 || lfit   gas size , legend(off) name(gr3 , replace)

twoway scatter lngas lnsiz ,   msymbol() msize(tiny) mlabel(iso3_country) mlabsize(vsmall) ///
 ytitle("Ln of Total Greenhouse gas emissions (thousands tonnes)" , size(small))  ///
 ylabel(,labsize(vsmall)) ysca(titlegap(.8))  ///
 xtitle("Ln of Size of country (thousands of km{superscript:2})" , size(small)) xlabel(,labsize(vsmall))  xsca(titlegap(.8)) ///
 || lfit   lngas lnsiz , legend(off) name(gr4 , replace)
 
graph combine gr3 gr4,   col(2) 
graph export graph2a.png

 
