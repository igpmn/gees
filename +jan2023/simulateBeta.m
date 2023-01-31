
close all
clear

load +model/+autarky/model.mat ma

% t = table( ...
%     ma, ["steadyLevel", "steadyChange", "form", "description"] ...
%     , "writeTable", "+jan2023/autarky.xlsx" ...
% )

ma1 = ma;
ma1.beta = 0.97;
ma1.gg_a = ma.gg_a;
ma1.gg_nt = ma.gg_nt;
ma1.pc = ma.pc;

ma1 = steady(ma1, "fixLevel", ["gg_a", "gg_nt", "pc"]);
ma1 = solve(ma1);


t = table( ...
    [ma, ma1], ["steadyLevel", "steadyChange", "form", "description"] ...
    , "writeTable", "+jan2023/autarky.xlsx" ...
)


da = databank.forModel(ma, 1:10);
da1 = databank.forModel(ma1, 1:10);

sa = simulate( ...
    ma1, da, 1:10 ...
    , "method", "stacked" ...
    , "prependInput", true ...
);

smca = databank.minusControl(ma1, sa, da);
dmca = databank.minusControl(ma1, da1, da);

report.basicWithSteady( ...
    ma1, smca, dmca, -1:10, "Beta in Autarky", [], "+jan2023/beta-autarky" ...
);

