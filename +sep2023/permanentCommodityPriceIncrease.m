
%% Permanent increase in real commodity price


close all
clear

startSimulation = 1;
endSimulation = 20;
simulationRange = startSimulation : endSimulation;


%
% Create global 4A m object
%

m = model.global4A.create();
checkSteady(m);
d = databank.forModel(m, simulationRange);


%
% Create economy with permanently higher commodity prices
%

m1 = m;
m1.gg_ss_aut_pq = 1.50;
m1.gg_rho_aut_pq = 0;

fix = accessUserData(m1, "fix");
m1 = steady(m1, "fix", fix);
checkSteady(m1);
m1 = solve(m1);


%
% Steady state comparison
%

table( ...
    [m, m1], ["steadyLevel", "compareSteadyLevel"] ...
    , "writeTable", "+sep2023/xlsx/permanent-commodity-price-increase.xlsx" ...
);


% Simulate transition from the original to the new steady state

d1 = d;
s1 = simulate( ...
    m1, d1, simulationRange ...
    , "prependInput", true ...
    , "method", "stacked" ...
);

smc1 = databank.minusControl(m, s1, d);


%
% Make the production technology transition faster
%

m2 = m1;
m2.us_rho_alpha = 0;
m2.ea_rho_alpha = 0;
m2.cn_rho_alpha = 0;
m2.rw_rho_alpha = 0;
checkSteady(m2);
m2 = solve(m2);

d2 = d;
s2 = simulate( ...
    m2, d2, simulationRange ...
    , "prependInput", true ...
    , "method", "stacked" ...
);

smc2 = databank.minusControl(m, s2, d);



%
% Make people believe the commodity price increase is temporary
%


p3 = Plan.forModel(m, simulationRange, "anticipate", false);
p3 = exogenize(p3, simulationRange, "gg_aut_pq");
p3 = endogenize(p3, simulationRange, "gg_shk_aut_pq");

d3 = d;
d3.gg_aut_pq(simulationRange) = 1.5;

s3 = simulate( ...
    m, d3, simulationRange ...
    , "prependInput", true ...
    , "method", "stacked" ...
    , "plan", p3 ...
);

smc3 = databank.minusControl(m, s3, d);



%
% Generate HTML report
%

reportTitle = "Permanent commodity price increase";
legend = ["Anticipated permanent", "Fast technology", "Anticipated temporary"];
fileName = "+sep2023/html/permanent-commodity-price-shock.html";

smc = databank.merge("horzcat", smc1, smc2, smc3);

report.basic(m1, smc, simulationRange, reportTitle, legend, fileName);

