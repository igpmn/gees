

close all
clear
%#ok<*CLARRSTR> 

load +model/+symmetric2A/model.mat m2
m = m2;

checkSteady(m);
m = solve(m);

T = 30;

% Permanent productivity improvements
d1 = databank.forModel(m, 1:T);
d1.gg_shk_a(1) = log(1.10);

s1 = simulate( ...
    m, d1, 1:T ...
    , "method", "stacked" ...
    , "prependInput", true ...
);

smc1 = databank.minusControl(m, s1, d1);


%% Permanent area specific productivity improvements

mea = m;
mea.ea_ss_ar = 1.10;
mea = steady(mea, "fixLevel", ["gg_a", "gg_nt", "ea_pc", "us_pc"]);
checkSteady(mea);
mea = solve(mea);

t = table( ...
    [m, mea] ...
    , ["steadyLevel", "compareSteadyLevel", "form", "description"] ...
    , "writeTable", "+jan2023/productivityEA.xlsx" ...
);


% t(["ea_ar", "us_ar", "ea_ch", "us_ch", "ea_pc", "us_pc", "ea_e", "ea_nfa_to_ngdp", "us_nfa_to_ngdp" ...
%    "ea_pmm", "ea_pxx"], :)




%% Chart results

ch = Chartpack();
ch.Range = 0:10;
ch.Transform = @(x) 100*(x-1);
ch.PlotSettings = {"marker", "o"}; 
ch.Expansion = {"?", ["us", "ea"]};
ch.Round = 8;

ch + ["Productivity: (gg_a * ?_ar)", "Consumption: ?_ch", "Inflation: ?_roc_pc", "Short rate: ?_r"];
ch + ["Capital: ?_k", "Investment: ?_ih", "Labor: ?_nh", "NFA to GDP: ^ 100*?_nfa_to_ngdp"];
draw(ch, smc1);



