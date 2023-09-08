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
m1.gg_ss_zk = m1.gg_ss_zk * 0.9;

fix = accessUserData(m, "fix");
m1 = steady(m1, "fixLevel", fix);
checkSteady(m1);
m1 = solve(m1);


table( ...
    [m, m1], ["steadyLevel", "compareSteadyLevel", "form"] ...
    , "writeTable", "+sep2023/xlsx/permanent-uncertainty-capital.xlsx" ...
);

d = databank.forModel(m, 1:20);


s1 = simulate( ...
    m1, d, 1:20 ...
    , "prependInput", true ...
    , "method", "stacked" ...
);

%%

for x = linspace(0.88, 0.82, 4)
    m2 = m;
    m2.gg_ss_zk = m2.gg_ss_zk * x;
    
    m2 = steady(m2, "fixLevel", fix);
    checkSteady(m2);
    m2 = solve(m2);
    
    
    s2 = simulate( ...
        m2, s1, 1:20 ...
        , "prependInput", true ...
        , "method", "stacked" ...
        , "startIter", "data" ...
    );
end

%%

smc1 = databank.minusControl(m, s1, d);
smc2 = databank.minusControl(m, s2, d);

%
% Generate HTML report 
%

reportTitle = "Permanent uncertainty in capital";
legend = ["Baseline"];
fileName = "+sep2023/html/permanent-uncertainty-capital.html";

smc = databank.merge("horzcat", smc1, smc2);
report.basic(m, smc, 1:20, reportTitle, legend, fileName);

