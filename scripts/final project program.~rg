'Antonio Jurlina
'ECO 530 
'Final Project Program
'11/6/2018

cd  "E:\UMaine\Fall (2018)\ECO 530\economicfreedom"

wfopen "gdp_data"

spool results
output(s) results

'creating variables necessary to introduce growth to the model
series pp = log(gdp)
series growth = (pp - pp(-1)) / 5

'''''' Creating summary statistics, graphs and a covariance matrix'''''''''''''''''
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
alpha country = countries
group dataset country year gdp gov growth*100 legal money oecd pp regulation trade
results.insert dataset
delete country

gdp.statby(max, min, nov, noa, p) countries
close gdp
graph ggdp.line(m, ab = histogram, panel = individual) gdp
ggdp.options connect
results.insert ggdp

growth.statby(max, min, nov, noa, p) countries
close growth
graph ggrowth.line(m, ab = histogram, panel = individual) growth
ggrowth.options connect
results.insert ggrowth

gov.statby(max, min, nov, noa, p) countries
close gov
graph ggov.line(m, ab = histogram, panel = individual) gov
ggov.options connect
results.insert ggov

legal.statby(max, min, nov, noa, p) countries
close legal
graph glegal.line(m, ab = histogram, panel = individual) legal
glegal.options connect
results.insert glegal

money.statby(max, min, nov, noa, p) countries
close money
graph gmoney.line(m, ab = histogram, panel = individual) money
gmoney.options connect
results.insert gmoney

trade.statby(max, min, nov, noa, p) countries
close trade
graph gtrade.line(m, ab = histogram, panel = individual) trade
gtrade.options connect
results.insert gtrade

regulation.statby(max, min, nov, noa, p) countries
close regulation
graph gregulation.line(m, ab = histogram, panel = individual) regulation
gregulation.options connect
results.insert gregulation

group variables growth gdp gov legal money regulation trade 
matrix x = @cor(variables)
x.setcollabels growth gdp gov legal money regulation trade
x.setrowlabels growth gdp gov legal money regulation trade
x.displayname Correlation Matrix
x.label
results.insert x

delete ggdp ggov glegal gtrade gmoney gregulation ggrowth world_gdp usd
delete variables rank economic_freedom_summary_index x

results.displayname untitled01 "Data Set"
results.displayname untitled02 "GDP per capita"
results.displayname untitled03 "GDP per capita"
results.displayname untitled04 "Growth rate"
results.displayname untitled05 "Growth rate"
results.displayname untitled06 "Size of Government"
results.displayname untitled07 "Size of Government"
results.displayname untitled08 "Legal System & Property Rights"
results.displayname untitled09 "Legal System & Property Rights"
results.displayname untitled10 "Sound Money"
results.displayname untitled11 "Sound Money"
results.displayname untitled12 "Freedom to trade internationally"
results.displayname untitled13 "Freedom to trade internationally"
results.displayname untitled14 "Regulation"
results.displayname untitled15 "Regulation"
results.displayname untitled16 "Correlation Matrix"
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
''''''' end of summary statistics '''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''


''''''' Fixed effects OLS models ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
smpl @all
equation eq_a.ls(cx=f) growth c gov(-1) legal(-1) money(-1) trade(-1) regulation(-1) pp(-1)
results.insert eq_a
results.displayname untitled17 "OLS (pooled)"

smpl if oecd = 0
equation eq_b.ls(cx=f) growth c gov(-1) legal(-1) money(-1) trade(-1) regulation(-1) pp(-1)
results.insert eq_b
results.displayname untitled18 "OLS (non-OECD)"

smpl if oecd = 1
equation eq_c.ls(cx=f) growth c gov(-1) legal(-1) money(-1) trade(-1) regulation(-1) pp(-1)
results.insert eq_c
results.displayname untitled19 "OLS (OECD)"
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
'''''''''' End of OLS estimation ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''


'''''' Tests '''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
smpl @all
equation eq_d.ls(cx=f, per=f) growth c gov(-1) legal(-1) money(-1) trade(-1) regulation(-1) pp(-1)
eq_d.fixedtest(p)
results.displayname untitled20 "Redundancy Test a"
smpl if oecd = 0
equation eq_e.ls(cx=f, per=f) growth c gov(-1) legal(-1) money(-1) trade(-1) regulation(-1) pp(-1)
eq_e.fixedtest(p)
results.displayname untitled21 "Redundancy Test b"
smpl if oecd = 1
equation eq_f.ls(cx=f, per=f) growth c gov(-1) legal(-1) money(-1) trade(-1) regulation(-1) pp(-1)
eq_f.fixedtest(p)
results.displayname untitled22 "Redundancy Test c"
close eq_d
close eq_e
close eq_f

smpl @all
equation eq_d.ls(cx=r) growth c gov(-1) legal(-1) money(-1) trade(-1) regulation(-1) pp(-1)
eq_d.ranhaus(p)
close eq_d
results.displayname untitled23 "RE vs FE Test a"

smpl if oecd = 0
equation eq_e.ls(cx=r) growth c gov(-1) legal(-1) money(-1) trade(-1) regulation(-1) pp(-1)
eq_e.ranhaus(p)
close eq_e
results.displayname untitled24 "RE vs FE Test b"

smpl if oecd = 1
equation eq_f.ls(cx=r) growth c gov(-1) legal(-1) money(-1) trade(-1) regulation(-1) pp(-1)
eq_f.ranhaus(p)
close eq_f
results.displayname untitled25 "RE vs FE Test c"

smpl @all
EQ_A.makeresids resid_a
graph res_a.spike(m, panel = combine) resid_a
res_a.options connect
results.insert res_a
results.displayname untitled26 "OLS (pooled) Residuals"

smpl if oecd = 0
EQ_B.makeresids resid_b
graph res_b.spike(m, panel = combine)  resid_b
res_b.options connect
results.insert res_b
results.displayname untitled27 "OLS (non-OECD) Residuals"

smpl if oecd = 1
EQ_C.makeresids resid_c
graph res_c.spike(m, panel = combine)  resid_c
res_c.options connect
results.insert res_c
results.displayname untitled28 "OLS (OECD) Residuals"

smpl @all
eq_a.forecast(e, g) growthf
graph hetero1.scat(panel = stack) growthf resid_a
hetero1.axis(b) angle(auto)
hetero1.legend position(LEFT)
hetero1.setelem(1) symbol(CIRCLE) linepattern(none) linecolor(@rgb(57,106,177))
hetero1.setelem(1) legend(Fitted Values)
hetero1.setelem(2) legend(Residuals)
hetero1.setelem(1) axis(b)
results.insert hetero1
results.displayname untitled29 "OLS (pooled) Residuals Plot"

smpl if oecd = 0
eq_b.forecast(e, g) growthf
graph hetero2.scat(panel = stack) growthf resid_b
hetero2.axis(b) angle(auto)
hetero2.legend position(LEFT)
hetero2.setelem(1) symbol(CIRCLE) linepattern(none) linecolor(@rgb(57,106,177))
hetero2.setelem(1) legend(Fitted Values)
hetero2.setelem(2) legend(Residuals)
hetero2.setelem(1) axis(b)
results.insert hetero2
results.displayname untitled30 "OLS (non-OECD) Residuals Plot"

smpl if oecd = 1
eq_c.forecast(e, g) growthf
graph hetero3.scat(panel = stack) growthf resid_c
hetero3.axis(b) angle(auto)
hetero3.legend position(LEFT)
hetero3.setelem(1) symbol(CIRCLE) linepattern(none) linecolor(@rgb(57,106,177))
hetero3.setelem(1) legend(Fitted Values)
hetero3.setelem(2) legend(Residuals)
hetero3.setelem(1) axis(b)
results.insert hetero3
results.displayname untitled31 "OLS (OECD) Residuals Plot"

delete res_a res_b res_c hetero1 hetero2 hetero3 resid_a resid_b resid_c  growthf

smpl @all
equation eq_g.ls(cx=f) growth c gov(-1) legal(-1) money(-1) trade(-1) regulation(-1) pp(-1) ar(1) ar(2)
results.insert eq_g
results.displayname untitled32 "OLS (pooled)"

smpl if oecd = 0
equation eq_h.ls(cx=f) growth c gov(-1) legal(-1) money(-1) trade(-1) regulation(-1) pp(-1) ar(1) ar(2)
results.insert eq_h
results.displayname untitled33 "OLS (non-OECD)"

smpl if oecd = 1
equation eq_i.ls(cx=f) growth c gov(-1) legal(-1) money(-1) trade(-1) regulation(-1) pp(-1) ar(1) ar(2)
results.insert eq_i
results.displayname untitled34 "OLS (OECD)"

''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
'''' end of tests ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

smpl @all
equation eq_j.ls(cx=f, wgt=cxdiag, deriv=aa) growth c gov(-1) legal(-1) money(-1) trade(-1) regulation(-1) pp(-1) ar(1) ar(2)
results.insert eq_j
results.displayname untitled35 "OLS (pooled)"

smpl if oecd = 0
equation eq_k.ls(cx=f, wgt=cxdiag, deriv=aa) growth c gov(-1) legal(-1) money(-1) trade(-1) regulation(-1) pp(-1) ar(1) ar(2)
results.insert eq_k
results.displayname untitled36 "OLS (non-OECD)"

smpl if oecd = 1
equation eq_l.ls(cx=f, wgt=cxdiag, deriv=aa) growth c gov(-1) legal(-1) money(-1) trade(-1) regulation(-1) pp(-1) ar(1) ar(2)
results.insert eq_l
results.displayname untitled37 "OLS (OECD)"

smpl @all
equation eq_m.ls(cx=f, per=f) growth c gov(-1) legal(-1) money(-1) trade(-1) regulation(-1) pp(-1) 
results.insert eq_m
results.displayname untitled38 "OLS (pooled)"

smpl if oecd = 0
equation eq_n.ls(cx=f, per=f) growth c gov(-1) legal(-1) money(-1) trade(-1) regulation(-1) pp(-1) 
results.insert eq_n
results.displayname untitled39 "OLS (non-OECD)"

smpl if oecd = 1
equation eq_o.ls(cx=f, per=f) growth c gov(-1) legal(-1) money(-1) trade(-1) regulation(-1) pp(-1) 
results.insert eq_o
results.displayname untitled40 "OLS (OECD)"

smpl @all
eq_j.makeresids resid_j
graph res_j.spike(m, panel = combine) resid_j
res_j.options connect
results.insert res_j
results.displayname untitled41 "OLS (pooled) Residuals"

smpl if oecd = 0
eq_k.makeresids resid_k
graph res_k.spike(m, panel = combine) resid_k
res_k.options connect
results.insert res_k
results.displayname untitled42 "OLS (non-OECD) Residuals"

smpl if oecd = 1
eq_l.makeresids resid_l
graph res_l.spike(m, panel = combine) resid_l
res_l.options connect
results.insert res_l
results.displayname untitled43 "OLS (OECD) Residuals"

smpl @all
eq_j.forecast(e, g) growthf
graph hetero1.scat(panel = stack) growthf resid_j
hetero1.axis(b) angle(auto)
hetero1.legend position(LEFT)
hetero1.setelem(1) symbol(CIRCLE) linepattern(none) linecolor(@rgb(57,106,177))
hetero1.setelem(1) legend(Fitted Values)
hetero1.setelem(2) legend(Residuals)
hetero1.setelem(1) axis(b)
results.insert hetero1
results.displayname untitled44 "OLS (pooled) Residuals Plot"

smpl if oecd = 0
eq_k.forecast(e, g) growthf
graph hetero2.scat(panel = stack) growthf resid_k
hetero2.axis(b) angle(auto)
hetero2.legend position(LEFT)
hetero2.setelem(1) symbol(CIRCLE) linepattern(none) linecolor(@rgb(57,106,177))
hetero2.setelem(1) legend(Fitted Values)
hetero2.setelem(2) legend(Residuals)
hetero2.setelem(1) axis(b)
results.insert hetero2
results.displayname untitled45 "OLS (non-OECD) Residuals Plot"

smpl if oecd = 1
eq_l.forecast(e, g) growthf
graph hetero3.scat(panel = stack) growthf resid_l
hetero3.axis(b) angle(auto)
hetero3.legend position(LEFT)
hetero3.setelem(1) symbol(CIRCLE) linepattern(none) linecolor(@rgb(57,106,177))
hetero3.setelem(1) legend(Fitted Values)
hetero3.setelem(2) legend(Residuals)
hetero3.setelem(1) axis(b)
results.insert hetero3
results.displayname untitled46 "OLS (OECD) Residuals Plot"

delete res_j res_k res_l hetero1 hetero2 hetero3 resid_j resid_k resid_l  growthf

results.options displaynames


