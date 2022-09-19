%% Simulate disruption to global trade

clear
close all

m2 = model.symmetric2A.create();


%% Comparative steady-state analysis

m2 = alter(m2, 2);

m2.gg_ss_dmm(2) = 1.10;

m2 = steady(m2);


%% Report steady state table

table( ...
    m2, ["steadyLevel", "compareSteadyLevel", "steadyChange", "form", "description"] ...
    , "writeTable", "+april2022/steady-trade-disruption.xlsx" ...
)



%% Dynamic transition from no disruption to 10% disruption


m2.gg_rho_dmm = 0;
m2 = solve(m2);


d = steadydb(m2(1), 1:20);

s = simulate( ...
    m2(2), d, 1:20 ...
    , "prependInput", true ...
    , "method", "stacked" ...
);

smc = databank.minusControl(m2, s, d);


%% Basic results

close all

ch = databank.Chartpack();
ch.Range = 0:20;
ch.Round = 8;
ch.Expansion = {"?", ["aa", "bb"]};
ch.Transform = @(x) 100*(x-1);

ch < ["Private consumption: ?_ch", "Non-comm imports: ?_mm", "CPI inflation: ?_roc_pc"];
ch < ["Nominal exchange rate: ?_e", "Policy rate: ?_r"];

draw(ch, smc);

visual.hlegend("bottom", "Area AA", "Area BB");


