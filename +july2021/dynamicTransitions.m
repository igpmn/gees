%% Set of dynamic simulations of steady state transitions

clear
close all
rehash path


%% Create different versions of the model

ma = model.autarky.create();
m2 = model.symmetric2A.create();
m4 = model.global4A.create();
 

%% Permanent increase in global productivity

[s, smc, d, m4a] = simulate.globalProductivity.run(m4, 1:10, 0.10, "G4");

