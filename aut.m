
clear

load +model/+autarky/model.mat ma

ma = alter(ma, 2);
ma.ss_nf_to_nw(2) = ma.ss_nf_to_nw(2) - 0.05;

ma = steady(ma);

table(ma, ["steadyLevel", "compareSteadyLevel"], round=8)

