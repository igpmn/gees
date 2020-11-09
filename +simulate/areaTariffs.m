function [s, smc] = areaTariffs(m, importer, exporter, size)

T = 20;
d = steadydb(m, 1:T);

m0 = m;


m.rw_ss_trm_us = m.rw_ss_trm_us + 0.25;

% m.(importer+"_ss_trm_"+exporter) = m.(importer+"_ss_trm_"+exporter) + size;



m = steady(m);
checkSteady(m);
m = solve(m);

s = simulate( ...
    m, d, 1:T ...
    , "prependInput", true ...
    , "method", "stacked" ...
);


%%

SHK_
SHKA_

areas = accessUserData(m, "areas");

p = Plan.forModel(m, 1:T, "anticipate", false);
p = exogenize(p, 1:2, areas(2:end)+"_e");
p = endogenize(p, 1:2, areas(2:end)+"_shk_e");

s2 = simulate( ...
    m, d, 1:T ...
    , "prependInput", true ...
    , "method", "stacked" ...
    , "plan", p ...
);

s = databank.merge("horzcat", s1, s2);


smc = databank.minusControl(m, s, d);

end%

