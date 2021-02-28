function [s, smc] = globalProductivityImprovements(m,simrange,anticipate)

% simrange = 1:numel(simrange);

d = steadydb(m, simrange);
d.gg_shk_a(simrange(4)) = ((1-anticipate)*1i + anticipate)*log(1.10);

s = simulate( ...
    m, d, simrange ...
    , "prependInput", true ...
    , "method", "stacked" ...
    , "blocks", false ...
);

smc = databank.minusControl(m, s, d);

end%

