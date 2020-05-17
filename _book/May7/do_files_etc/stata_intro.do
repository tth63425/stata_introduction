* stata_introduction

clear all


capture log close


cd "/Users/akirasato/Docs/stata_introduction/May7/do_files_etc"

log using stataoutput, replace


use http://fmwww.bc.edu/ec-p/data/wooldridge/401ksubs

scatter inc age
graph export bin1.png, replace

binscatter inc age
graph export bin2.png, replace
