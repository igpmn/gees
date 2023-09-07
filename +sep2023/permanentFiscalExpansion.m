
%% Simulate a permanent change in govt debt through govt expenditures 

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
% Create an economy with a new level of govt debt, and recalibrate fiscal
% reaction parameters
%

m1 = m;
areas = accessUserData(m, "areas");
for a = areas
    m1.(a+"_ss_dg_to_ngdp") = m1.(a+"_ss_dg_to_ngdp") + 0.20;
    m1.(a+"_tau_cg") = 3;
    m1.(a+"_tau_txls1") = 0;
end

fix = accessUserData(m1, "fix");
m1 = steady(m1, "fixLevel", fix);
checkSteady(m1);
m1 = solve(m1);


%
% Steady state comparison
%

table( ...
    [m, m1], ["steadyLevel", "compareSteadyLevel"] ...
    , "writeTable", "+sep2023/xlsx/permanent-fiscal-exapansion.xlsx" ...
);


%
% Dynamic simulation
%

d1 = d;

p = Plan.forModel(m1, simulationRange);
for a = areas
    p = swap(p, simulationRange(1:2), [a+"_txls1_to_nc", a+"_shk_txls1"]);
end

s1 = simulate( ...
    m1, d1, simulationRange ...
    , "prependInput", true ...
    , "method", "stacked" ...
    , "plan", p ...
);

smc1 = databank.minusControl(m, s1, d);


%
% Generate HTML report 
%

reportTitle = "Permanent fiscal expansion";
legend = ["Global 20%"];
fileName = "+sep2023/html/permanent-fiscal-expansion.html";

report.basic(m, smc1, simulationRange, reportTitle, legend, fileName);

