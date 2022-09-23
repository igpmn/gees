
load +model/+symmetric2A/model.mat m2

steadyF = @(m) steady(m, fixLevel=["gg_a", "gg_nt", "us_pc", "ea_pc"]);

m2.us_gamma_xx = 0;
m2.ea_gamma_xx = 1;
m2.us_chi_curr = 0;
m2.ea_chi_curr = 0;
m2.us_nu_1 = 0;
m2.ea_nu_1 = 0;
m2.us_eta = 0;
m2.ea_eta = 0;
m2 = steadyF(m2);
checkSteady(m2);

n2 = m2;
n2.us_ss_ar = 1.10;
n2 = steadyF(n2);
checkSteady(n2);

p2 = m2;
p2.ea_ss_ar = 1.10;
p2 = steadyF(p2);
checkSteady(p2);

