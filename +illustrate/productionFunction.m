
close all
clear

m = Model("+illustrate/productionFunction.model");
m = alter(m, 3);
m.gamma_n1 = 0.50;
m.xi = [0, 0.5, 0.5];
m.rho_a = 0.5;
m.rdf = 0.95;
m.ss_a = [1, 1, 0.95];
m.ss_y = 1;
m.ss_pn1 = 1;
m.ss_pn2 = 1;


m = steady(m);
m = solve(m);

d = steadydb(m(1), 1:10);
d.shk_pn1(1) = log(1.10);
s = simulate(m, d, 1:10, "prependInput", true);

dbplot( ...
    s, 0:10, ["pn1", "pn2", "py", "n1", "n2", "y", "a"] ...
    , "tight", true ...
    , "marker", "s" ...
    , "round", 8 ...
);


