%% Simulate a permanent change in govt debt 


close all
clear
%#ok<*CLARRSTR> 

load +model/+autarky/model.mat ma
m = ma;

m = alter(m, 3);
m.chi_curr = [0, 0.3, 0.3];
m.nu_1     = [0, 0,   0.07];
m = steady(m, "fixLevel", ["gg_a", "gg_nt", "pc"]);
checkSteady(m);
m = solve(m);

%
% Create initial steady state databank
%

T = 20;
c = databank.forModel(m, 1:T);


%
% Create an economy with a new level of govt debt
%

m1 = m;
m1.ss_dg_to_ngdp = m1.ss_dg_to_ngdp + 0.30;
m1.tau_cg = 5;
m1.tau_txls1 = 0;

m1 = steady(m1, "fixLevel", ["gg_a", "gg_nt", "pc"]);
checkSteady(m1);
m1 = solve(m1);


%
% Simulate transition
%

d = c;

p = Plan.forModel(m1, 1:T);
p = swap(p, 1:2, ["txls1_to_nc", "shk_txls1"]);

s = simulate( ...
    m1, d, 1:T ...
    , "prependInput", true ...
    , "method", "stacked" ...
    , "plan", p ...
);

smc = databank.minusControl(m, s, c);


%% Chart results

ch = Chartpack();
ch.Range = 0:T;
ch.Transform = @(x) 100*(x-1);
ch.PlotSettings = {"marker", "o"}; 
ch.Expansion = {"?", ["us", "ea"]};
ch.TitleSettings = {"fontSize", 20};
ch.AxesExtras = {@(a) yline(0, "lineWidth", 2)};
ch.Round = 8;

ch + ["Private consumption: ch", "Private investment: ih", "Govt consumption: cg"];
ch + ["Govt debt to GDP: ^ 100*dg_to_ngdp", "Short rate: r", "Inflation: roc_pc"];
ch + ["Real labor income: nh * w / pc"];

draw(ch, smc);

