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

%% Run simulation

s1 = simulate( ...
    m2, d, range ...
    , "prependInput", true ...
    , "method", "stacked" ...
);

smc1 = databank.minusControl(m2, s1, d0);


%% Plot result

close all;

plotRange = range(1)-1:range(end);

tiledlayout("flow");

nexttile();
hold on;
plot(smc1.us_py, "marker", "s", "range", plotRange);
plot(smc1.us_pxx, "marker", "s", "range", plotRange);
plot(smc1.us_pmm, "marker", "s", "range", plotRange);
plot(1/smc1.ea_e, "marker", "s", "range", plotRange);
legend("us_py", "us_pxx", "us_pmm", "usd/eur", "interpreter", "none");

nexttile();
hold on
plot(smc1.us_pxx, "marker", "s", "range", plotRange);
plot(smc1.ea_pmm, "marker", "s", "range", plotRange);
plot(smc1.ea_e, "marker", "s", "range", plotRange);
legend("us_pxx", "ea_pmm", "eur/usd", "interpreter", "none");

nexttile();
hold on
plot(smc1.ea_pmm, "marker", "s", "range", plotRange);
plot(smc1.ea_w, "marker", "s", "range", plotRange);
plot(smc1.ea_py3, "marker", "s", "range", plotRange);
legend("ea_pmm", "ea_w", "ea_py3", "interpreter", "none");

nexttile();
hold on
plot(smc1.ea_py3, "marker", "s", "range", plotRange);
plot(smc1.ea_pu, "marker", "s", "range", plotRange);
plot(smc1.ea_py2, "marker", "s", "range", plotRange);
legend("ea_py3", "ea_pu", "ea_py2", "interpreter", "none");

nexttile();
hold on
plot(smc1.ea_py2, "marker", "s", "range", plotRange);
plot(smc1.ea_pq, "marker", "s", "range", plotRange);
plot(smc1.ea_py1, "marker", "s", "range", plotRange);
legend("ea_py2", "ea_pq", "ea_py1", "interpreter", "none");

nexttile();
hold on
plot(smc1.ea_py1, "marker", "s", "range", plotRange);
plot(smc1.ea_py, "marker", "s", "range", plotRange);
legend("ea_py1", "ea_py", "interpreter", "none");

%%

figure();
plot([smc1.us_y, smc1.us_nv, smc1.us_mm, smc1.ea_y], "range", plotRange);
legend("US production", "US labor", "US imports/EA exports", "EA production");

    
%% Substitution in the US

figure();
plot([smc1.us_pmm/smc1.us_w, smc1.us_nv/smc1.us_my]);
legend("Price of US imports/US wages", "Quantity of US imports/labor");




