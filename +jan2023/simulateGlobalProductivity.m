

close all
clear

load +model/+autarky/model.mat ma
m = ma;

checkSteady(m);
m = solve(m);

T = 30;

% Premanent productivity improvements
d1 = databank.forModel(m, 1:T);
d1.gg_shk_a(1) = log(1.10);

s1 = simulate( ...
    m, d1, 1:T ...
    , "method", "stacked" ...
    , "prependInput", true ...
);

smc1 = databank.minusControl(m, s1, d1);

% Temporary productivity improvements
d2 = databank.forModel(m, 1:T);
d2.shk_ar(1) = log(1.10);

s2 = simulate( ...
    m, d2, 1:T ...
    , "method", "stacked" ...
    , "prependInput", true ...
);

smc2 = databank.minusControl(m, s2, d2);

ch = Chartpack();
ch.Range = 0:10;
ch.Transform = @(x) 100*(x-1);
ch.PlotSettings = {"marker", "o"};

ch + ["Productivity: (gg_a * ar)", "Consumption: ch", "Inflation: roc_pc", "Short rate: r"];
ch + ["Capital: k", "Investment: ih", "Labor: nh"];
draw(ch, databank.merge("horzcat", smc1, smc2));



