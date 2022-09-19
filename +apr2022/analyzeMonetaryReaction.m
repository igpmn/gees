%% Investigate monetary policy reaction function


clear
close all

m2 = model.symmetric2A.create();




%% Plain vanilla demand shock in AA


d = steadydb(m2, 1:20);

m2 = alter(m2, 4);
m2.aa_psi_nh = [0, 0.2, 0.4, 0.6];

checkSteady(m2);
m2 = solve(m2);

p = Plan.forModel(m2, 1:20);
p = swap(p, 1, ["aa_ch", "aa_shk_ch"]);

d.aa_ch(1) = d.aa_ch(1) * 1.01;

s1 = simulate( ...
    m2, d, 1:20 ...
    , "prependInput", true ...
    , "method", "stacked" ...
    , "plan", p ...
);



%% Plain vanilla cost push shock in AA

d = steadydb(m2, 1:20);
d.aa_shk_py(1) = 0.03;

s2 = simulate( ...
    m2, d, 1:20 ...
    , "prependInput", true ...
    , "method", "stacked" ...
);


%% Basic results


smc1 = databank.minusControl(m2, s1, d);
smc2 = databank.minusControl(m2, s2, d);


close all

ch = databank.Chartpack();
ch.Range = 0:20;
ch.Round = 8;
ch.Transform = @(x) 100*(x-1);

ch < ["Private consumption: aa_ch", "Non-comm imports: aa_mm", "CPI inflation: aa_roc_pc"];
ch < ["Nominal exchange rate: 1/bb_e", "Policy rate: aa_r", "Hours worked per worker: aa_nh"];

draw(ch, smc1);
visual.hlegend("bottom", "\psi_{nh}=0", "\psi_{nh}=0.2", "\psi_{nh}=0.4", "\psi_{nh}=0.6");
visual.heading("Demand shock");

draw(ch, smc2);
visual.hlegend("bottom", "\psi_{nh}=0", "\psi_{nh}=0.2", "\psi_{nh}=0.4", "\psi_{nh}=0.6");
visual.heading("Cost push shock");


