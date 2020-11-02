close all
clear 

m = Model("test.model");

m.k = 5;

m = steady(m);

m = solve(m)
