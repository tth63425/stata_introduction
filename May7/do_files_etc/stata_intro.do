clear all

capture log close

cd "/Users/akirasato/Docs/Okamuro_Seminar/stata_introduction"

log using stataoutput, replace

use https://stats.idre.ucla.edu/stat/stata/dae/logit.dta

reg admit gpa gre, r
test gpa
local F1 = r(F)
local P1 = r(p)
local effect1 = _b[_cons] + _b[gpa] * 3.5 + _b[gre] * 750
outreg2 using table1.doc, adds(F-value, `F1', p-value, `P1', Predicted Effect, `effect1') replace

probit admit gpa gre, r
local effect2 = normal(_b[_cons] + _b[gpa] * 3.5 + _b[gre] * 750)
outreg2 using table1.doc, adds(Predicted Effect, `effect2') append

logit admit gpa gre, r
nlcom logistic(_b[_cons] + _b[gpa] * 4 + _b[gre] * 790) - logistic(_b[_cons] + _b[gpa] * 3.5 + _b[gre] * 750), post
local dif = _b[_nl_1]
local ste = _se[_nl_1]
dis `dif'
dis `ste'
logit admit gpa gre, r
local effect3 = logistic(_b[_cons] + _b[gpa] * 3.5 + _b[gre] * 750)
outreg2 using table1.doc, adds(Predicted Effect, `effect3') append













dis  logistic(_b[_cons] + _b[gpa] * 3.5 + _b[gre] * 750)
