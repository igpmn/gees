%% Simulate flight to quality in international financial markets



%% Load the global 4A model

close all
clear

g4 = model.global4A.create();


accessUserData(g4, "areas")


%% Comparative steady-state analysis

g4 = alter(g4, 2);
g4.us_ss_zh_aut(2) = g4.us_ss_zh_aut(2) - 0.02;

g4 = steady(g4);
g4 = solve(g4);


%% Report steady state table

table( ...
    g4, ["steadyLevel", "compareSteadyLevel", "steadyChange", "form", "description"] ...
    , "writeTable", "+april2022/steady-flight-to-quality.xlsx" ...
)


%% Simulate dynamic adjustment

d = steadydb(g4(1), 1:40);

s = simulate( ...
    g4(2), d, 1:40 ...
    , "prependInput", true ...
    , "method", "stacked" ...
);

smc = databank.minusControl(g4, s, d);

%% Basic results

close all

ch = databank.Chartpack();
ch.Range = 0:40;
ch.Round = 8;
ch.Expansion = {"?", ["us", "ea", "cn", "rw"]};
ch.Transform = @(x) 100*(x-1);

ch < ["Private consumption: ?_ch", "Non-comm imports: ?_mm", "CPI inflation: ?_roc_pc"];
ch < ["Nominal exchange rate: ?_e", "Policy rate: ?_r", "NFA to GDP: ^ 100*?_nfa_to_ngdp"];

draw(ch, smc);

visual.hlegend("bottom", "US", "EA", "CN", "RW");


