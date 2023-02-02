
close all
clear


g = Model.fromFile( ...
    "model-source/globals.md" ...
    , "growth", true ...
);

% access(g, "parameter-values")

g = calibrate.baselineGlobal(g);

% access(g, "parameter-values")

g.gg_a = 1;
g.gg_nt = 1;
g = steady(g, "fixLevel", ["gg_a", "gg_nt"]);

checkSteady(g);

g = solve(g);

table( ...
    g ...
    , ["steadyLevel", "steadyChange", "description"] ...
)



% Create a steady state database
% for a simulation range 1:20

T = 30;
d = databank.forModel(g, 1:T);


% In the database, assign gg_shk_a
% some value in period 1

d.gg_shk_a(1) = log(1.10);


% Run the simulation on a simulation range 1:20

s = simulate( ...
    g, d, 1:T ...
    , "method", "stacked" ...
    , "prependInput", true ...
);

% Plot the level of gg_a with no shock,
% and the level of gg_a with the shock

figure();
plot([d.gg_a, s.gg_a], "marker", "o");


% Plot the percent difference between
% the level of gg_a with the shock,
% and the level of gg_a with no shock

figure();
plot(100*(s.gg_a/d.gg_a-1), "marker", "o");
















