
%% Clear workspace

clear all
close


%% Load model

load +model/+symmetric2A/model.mat m2

areas = accessUserData(m2, "areas");

set(0, "defaultAxesFontSize", 22);


%% Set up simulation

range = 1:10;

% Create steady state databank including initial conditions
d0 = databank.forModel(m2, range);

% Set up a shock
d = d0;
d.us_shk_py(1) = 0.10;

%% Run simulations

s0 = simulate( ...
    m2, d, range ...
    , "prependInput", true ...
);

s1 = simulate( ...
    m2, d, range ...
    , "prependInput", true ...
    , "method", "stacked" ...
);

smc0 = databank.minusControl(m2, s0, d0);
smc1 = databank.minusControl(m2, s1, d0);

smc = databank.merge("horzcat", smc0, smc1);

%% Report results

areaList = ["roc_pc", "r", "e", "rh", "ch", "ih", "pc"];

databank.plot( ...
    smc1, [areas(1)+"_"+areaList, areas(2)+"_"+areaList] ...
    , "range", range(1)-1:range(end) ...
    , "transform", @(x) 100*(x-1) ...
    , "autoCaption", true ...
    , "showFormulas", true ...
    , "yline", 0 ...
);


