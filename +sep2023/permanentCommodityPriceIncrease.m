
%% Permanent increase in real commodity price

close
clear

startSimulation = 1;
endSimulation = 20;
simulationRange = startSimulation : endSimulation;

% Create global 4A model object

m = model.global4A.create();
d = databank.forModel(m, simulationRange);


% Create economy with permanently higher commodity prices

m1 = m;
m1.gg_aut_pq = 1.50;

fix = accessUserData(m1, "fix");
m1 = steady(m1, "fix", fix);
checkSteady(m1);
m1 = solve(m1);

ss1 = access(m1, "steady");

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


% Report the results

report.basic( ...
    m1, smc1, 1:20 ...
    , "Permanent commodity price increase" ...
    , ["Permanent anticipated"] ...
    , "+sep2023/html/permanent-commodity-price-shock.html" ...
);

