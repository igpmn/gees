%% Simulate a permanent increase in uncertainty in capital

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


%
% Increase uncertainty in capital pricing equation (globally)
%

m1 = m;
m1.gg_ss_zk = m1.gg_ss_zk * 0.8;

fix = accessUserData(m, "fix");
m1 = steady(m1, "fixLevel", fix);
checkSteady(m1);
m1 = solve(m1);


table( ...
    [m, m1], ["steadyLevel", "compareSteadyLevel", "form"] ...
    , "writeTable", "+sep2023/xlsx/permanent-uncertainty-capital.xlsx" ...
);




