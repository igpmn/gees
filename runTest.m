close all
clear

m = Model("test2.model", "growth", true);
% m.k = 1;
% m.uk = 1;
% m.y = 1;
% m = steady(m, "blocks", false, "fixLevel", "y");
m = steady(m, "blocks", false, "nanInit", "rand");
checkSteady(m);

