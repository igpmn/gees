function [s, smc] = areaTariffs(m, importer, exporter, simrange, size)

% T = 20;
d = steadydb(m, simrange);

m0 = m;

m.(importer+"_ss_trm_"+exporter) = m.(importer+"_ss_trm_"+exporter) + size;

m = steady(m);
checkSteady(m);
m = solve(m);

checkSteady(m);
m = solve(m);

s = simulate( ...
    m, d, simrange ...
    , "prependInput", true ...
    , "method", "stacked" ...
);

% areas = accessUserData(m, "areas");
% 
% p = Plan.forModel(m, simrange, "anticipate", false);
% p = exogenize(p, simrange(1:3), areas(2:end)+"_e");
% p = endogenize(p, simrange(1:3), areas(2:end)+"_shk_e");
% 
% s = simulate( ...
%     m, d, simrange ...
%     , "prependInput", true ...
%     , "method", "stacked" ...
%     , "plan", p ...
% );

% s = databank.merge("horzcat", s1, s2);


smc = databank.minusControl(m, s, d);

end%

