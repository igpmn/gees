

clear all
close

load +model/+symmetric2A/model.mat m2

range = 1:10;

d = databank.forModel(m2, range);

d.aa_shk_py(1) = 0.10;

s0 = simulate(m2, d, range);



