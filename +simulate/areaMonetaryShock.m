function [s, smc] = areaMonetaryShock(m,area,simrange,anticipate)

d = steadydb(m, simrange);
d.(area + "_shk_r")(simrange(4)) = ((1-anticipate)*1i + anticipate)*...
                                       real(m.(area + "_unc_r"))*0.1;

s = simulate( ...
    m, d, simrange ...
    , "prependInput", true ...
    , "method", "stacked" ...
    , "blocks", false ...
);

smc = databank.minusControl(m, s, d);

end%

