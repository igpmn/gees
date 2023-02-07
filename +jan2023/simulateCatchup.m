
close all
clear
%#ok<*NOPTS> 
%#ok<*CLARRSTR> 

load +model/+global4A/model.mat m4
m = m4;

t = table( ...
    m, "steadyLevel" ...
    , "writeTable", "+jan2023/catchup.xlsx" ...
);

t(["us_ar", "ea_ar", "cn_ar", "rw_ar"], :)


% 0.38 -> 0.70

% at the end of period 10, 0.68

% What rho_ar do we need?

mrw = m;
mrw.rw_ss_ar = 0.70;
mrw.rw_rho_ar = 0.75;
mrw = steady(mrw, "fixLevel", ["gg_a", "gg_nt", "us_pc", "ea_pc", "cn_pc", "rw_pc"]);
checkSteady(mrw);
mrw = solve(mrw);

d = databank.forModel(m, 1:20);
s = simulate(mrw, d, 1:20, "method", "stacked", "prependInput", true);

smc = databank.minusControl(mrw, s, d);


%% Chart results

ch = Chartpack();
ch.Range = 0:10;
ch.Transform = @(x) 100*(x-1);
ch.PlotSettings = {"marker", "o"}; 
ch.Expansion = {"?", ["us", "ea", "cn", "rw"]};
ch.Round = 8;

ch + ["Productivity: (gg_a * ?_ar)", "Consumption: ?_ch", "Inflation: ?_roc_pc", "Short rate: ?_r"];
ch + ["Capital: ?_k", "Investment: ?_ih", "Labor: ?_nh", "NFA to GDP: ^ 100*?_nfa_to_ngdp"];
ch + ["Nominal exchange rate: ?_e", "Non-commodity TB to GDP: ^ 100*?_netxx_to_ngdp", "Commodity TB to GDP: ^ 100*?_netxq_to_ngdp"];

draw(ch, smc);
visual.hlegend("bottom", "US", "EA", "CN", "RW");
visual.heading("RW catching up");








