
close all
clear 

m = Model("test.model");

m.y2 = 1;
m = steady( ...
    m ...
    , "fixLevel", "y2" ...
    , "blocks", false ...
);

m = solve(m);

d = steadydb(m, 1:200);
d.shk(3) = log(1.10);
s = simulate(m, d, 1:200);
smc = databank.minusControl(m, s, d);

