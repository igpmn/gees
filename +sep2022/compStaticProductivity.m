

close all
clear

% ma = model.autarky.create();
load +model/+autarky/model.mat ma

checkSteady(ma);

ma1 = ma;
ma1.gg_a = 1.10;
ma1 = steady(ma1, "fixLevel", ["gg_a", "gg_nt", "pc"]); %, "solver", {"qnsd", "maxIterations", 500});
checkSteady(ma1);


ma2 = ma;
ma2.pc = 1.10;
ma2 = steady(ma2, "fixLevel", ["gg_a", "gg_nt", "pc"]);
checkSteady(ma2);


table( ...
    [ma, ma1, ma2] ...
    , ["steadyLevel", "compareSteadyLevel" ...
       , "steadyChange", "compareSteadyChange", "description"] ...
    , "writeTable", "+sep2023/compStaticProductivity.xlsx" ...
)


% Resimulate steady paths
d = databank.forModel(ma, 1:10);
s0 = simulate(ma, d, 1:10);
s1 = simulate(ma, d, 1:10, "method", "stacked");
[d.ch, s0.ch, s1.ch]





