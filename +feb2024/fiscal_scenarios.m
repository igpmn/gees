                                                                                
%% Simulate fiscal consolidation
                                                                                

close all
clear

load +feb2024/mat/global4a.mat m4
m = m4;

areas = accessUserData(m, "areas");
fix = accessUserData(m, "fix");
tableColumns = ["steadyLevel", "steadyChange", "compareSteadyLevel", "compareSteadyChange"];

for a = areas
    m.(a+"_chi_curr") = 0.5;
end

m = steady(m, fixLevel=fix);
checkSteady(m);
m = solve(m);

T = 30;
d0 = databank.forModel(m, 1:T);


                                                                                
%% Scenario A: Global fiscal consolidation
                                                                                

ma = m;
for a = areas
    ma.(a+"_ss_dg_to_ngdp") = ma.(a+"_ss_dg_to_ngdp") - 0.20;
    ma.(a+"_tau_cg") = 3;
    ma.(a+"_tau_txls1") = 0;
end

ma = steady(ma, fixLevel=fix);
checkSteady(ma);
ma = solve(ma);

ta = table( ...
    [m, ma], tableColumns ...
    , round=8 ...
    , writeTable="+feb2024/steady/fiscal_a.xlsx" ...
);

da = d0;

p = Plan.forModel(ma, 1:T);
for a = areas
    p = swap(p, 1:2, [a+"_txls1_to_nc", a+"_shk_txls1"]);
end

sa = simulate( ...
    ma, da, 1:T ...
    , prependInput=true ...
    , method="stacked" ...
    , plan=p ...
);

smca = databank.minusControl(m, sa, d0);


                                                                                
%% Scenario B: Global fiscal consolidation
                                                                                

mb = m;
for a = ["ea", ]
    mb.(a+"_ss_dg_to_ngdp") = mb.(a+"_ss_dg_to_ngdp") - 0.20;
    mb.(a+"_tau_cg") = 3;
    mb.(a+"_tau_txls1") = 0;
end

mb = steady(mb, fixLevel=fix);
checkSteady(mb);
mb = solve(mb);

tb = table( ...
    [m, mb], tableColumns ...
    , round=8 ...
    , writeTable="+feb2024/steady/fiscal_b.xlsx" ...
);

db = d0;

p = Plan.forModel(mb, 1:T);
for a = areas
    p = swap(p, 1:2, [a+"_txls1_to_nc", a+"_shk_txls1"]);
end

sb = simulate( ...
    mb, db, 1:T ...
    , prependInput=true ...
    , method="stacked" ...
    , plan=p ...
);

smcb = databank.minusControl(m, sb, d0);

report.basic( ...
    m, databank.merge("horzcat", smca, smcb), 1:T ...
    , "Demography: Shrinking WAP" ...
    , ["Global", "EA only"] ...
    , "+feb2024/html/fiscal_ab" ...
);

