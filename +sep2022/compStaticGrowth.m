%% Comparative static for productivity and population growth

close all
clear

% ma = model.autarky.create();
load +model/+autarky/model.mat ma

checkSteady(ma);

ma1 = ma;
ma1.gg_ss_roc_a = ma1.gg_ss_roc_a + 0.01;
ma1 = steady(ma1, "fixLevel", ["gg_a", "gg_nt", "pc"]);
checkSteady(ma1);

ma2 = ma;
ma2.gg_ss_roc_nt = ma2.gg_ss_roc_nt + 0.01;
ma2 = steady(ma2, "fixLevel", ["gg_a", "gg_nt", "pc"]);
checkSteady(ma2);

table( ...
    [ma, ma1, ma2], ["steadyLevel", "steadyChange", "description"] ...
    , "writeTable", "+sep2023/compStaticGrowth.xlsx" ...
);
