
%% Clear workspace

close all
clear


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

%% Anticipations

% Set up a shock
d = d0;
d.us_shk_py(2) = 0.10;

s3 = simulate( ...
    m2, d, range ...
    , "prependInput", true ...
    , "method", "stacked" ...
);

s4 = simulate( ...
    m2, d, range ...
    , "prependInput", true ...
    , "method", "stacked" ...
    , "anticipate", false ...
);

smc3 = databank.minusControl(m2, s3, d0);
smc4 = databank.minusControl(m2, s4, d0);

%% Anticipated but not happening

% Set up a shock
d = d0;
d.us_shk_py(2) = 0.10 - 0.10i;

s5 = simulate( ...
    m2, d, range ...
    , "prependInput", true ...
    , "method", "stacked" ...
);

smc5 = databank.minusControl(m2, s5, d0);


%% Type I policy error

% Set up a shock
d = d0;
d.us_shk_py(1) = 0.10;

p6 = Plan.forModel(m2, range);
p6 = anticipate(p6, false, "us_shk_r");
p6 = exogenize(p6, range(1:2), "us_r");
p6 = endogenize(p6, range(1:2), "us_shk_r");

s6 = simulate( ...
    m2, d, range ...
    , "prependInput", true ...
    , "method", "stacked" ...
    , "plan", p6 ...
);

smc6 = databank.minusControl(m2, s6, d0);


%% Report results
%#ok<*CLARRSTR> 

areaList = ["roc_pc", "r", "e", "rh", "ch", "ih", "pc", "w_to_pc"];

chartDb = databank.merge("horzcat", smc1, smc6);

databank.plot( ...
    chartDb, [areas(1)+"_"+areaList, areas(2)+"_"+areaList] ...
    , "range", range(1)-1:range(end) ...
    , "transform", @(x) 100*(x-1) ...
    , "autoCaption", true ...
    , "showFormulas", true ...
    , "yline", 0 ...
    , "highlight", 1:2 ...
    , "plotSettings", {"marker", "s"} ...
); 



