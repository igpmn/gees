
close all
clear

% ms = model.symmetric2A.create();
load ./+model/+symmetric2A/model.mat m2
ms = m2;

ms1 = ms;
ms1.aa_beta = 0.97;
% ms1 = steady(ms1, "fixLevel", ["gg_a", "gg_nt", "aa_pc", "bb_pc"]);

ms2 = ms;
ms2.aa_ss_nw_to_nn = ms2.aa_ss_nw_to_nn - 0.05;
% ms2.aa_nu_1 = 0.10;
ms2 = steady(ms2, "fixLevel", ["gg_a", "gg_nt", "aa_pc", "bb_pc"]);
checkSteady(ms2);

