
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
m1.gg_aut_pq = 1.50;

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
    m1, d, simulationRange ...
    , "prependInput", true ...
    , "method", "stacked" ...
);

smc1 = databank.minusControl(m, s1, d);


%
% Generate HTML report
%

reportTitle = "Permanent commodity price increase";
legend = ["Permanent anticipated"];
fileName = "+sep2023/html/permanent-commodity-price-shock.html";

report.basic(m1, smc1, simulationRange, reportTitle, legend, fileName);

