
close all
clear

% ms = model.symmetric2A.create();
load ./+model/+symmetric2A/model.mat m2
ms = m2;

ms.aa_nu_1 = 0;
ms.bb_nu_1 = 0;
ms = steady(ms, "fixLevel", ["gg_a", "gg_nt", "aa_pc", "bb_pc"]);


ms1 = ms;
ms1.aa_beta = 0.97;
ms1 = steady(ms1, "fixLevel", ["gg_a", "gg_nt", "aa_pc", "bb_pc"]);
checkSteady(ms1);

s1 = access(ms1, "steady-level");
[
s1.aa_nfa_to_ngdp * s1.aa_ngdp
s1.bb_nfa_to_ngdp * s1.bb_ngdp / s1.bb_e
]



ms2 = ms;
ms2.aa_ss_nw_to_nn = ms2.aa_ss_nw_to_nn - 0.05;
ms2 = steady(ms2, "fixLevel", ["gg_a", "gg_nt", "aa_pc", "bb_pc"]);
checkSteady(ms2);


s2 = access(ms1, "steady-level");
[
s2.aa_nfa_to_ngdp * s2.aa_ngdp
s2.bb_nfa_to_ngdp * s2.bb_ngdp / s2.bb_e
]

