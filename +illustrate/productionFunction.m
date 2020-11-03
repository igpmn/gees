
close all
clear

m = Model("+illustrate/productionFunction.model");

m = alter(m, 2);
m.gamma_n1 = 0.45;
m.gamma_n2 = 0.45;
m.xi = [0, 5];
m.rho_a = 0.5;
m.rdf = 0.95;
m.ss_a = [1, 1];
m.ss_y = 1;
m.ss_pn1 = 1;
m.ss_pn2 = 1;
m.ss_pn3 = 1;


m = steady(m);
m = solve(m);

d = steadydb(m(1), 1:10);
d.shk_pn1(1) = log(1.10);
s = simulate(m, d, 1:10, "prependInput", true);

dbplot( ...
    s, 0:10, ["pn1", "pn2", "pn3", "n1", "n2", "n3", "py", "y", "a"] ...
    , "tight", true ...
    , "marker", "s" ...
    , "round", 8 ...
);


