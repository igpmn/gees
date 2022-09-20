

close all
clear

% ma = model.autarky.create();
load +model/+autarky/model.mat ma

checkSteady(ma);

ma1 = ma;

ma1.gg_a = 100;
% ma1.gg_nt = 1;

for x = linspace(1, 1.10, 2)
    ma1.gg_a = x;
    ma1 = steady(ma1, "fixLevel", ["gg_a", "gg_nt", "pc"]); %, "solver", {"qnsd", "maxIterations", 500});
    checkSteady(ma1);
end

ma2 = ma;
ma2.pc = 1.10;
ma2 = steady(ma2, "fixLevel", ["gg_a", "gg_nt", "pc"]);

table( ...
    [ma, ma1, ma2] ...
    , ["steadyLevel", "compareSteadyLevel" ...
       , "steadyChange", "compareSteadyChange", "description"] ...
    , "writeTable", "+sep2023/compStaticProductivity.xlsx" ...
)
