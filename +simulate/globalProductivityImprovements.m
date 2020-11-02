function [s, smc] = globalProductivityImprovements(m)

T = 20;

d = steadydb(m, 1:T, "numColumns", 2);
d.gg_shk_a(4) = [log(1.10), 1i*log(1.10)];

s = simulate( ...
    m, d, 1:T ...
    , "prependInput", true ...
    , "method", "stacked" ...
    , "blocks", false ...
);

smc = databank.minusControl(m, s, d);

return

figure();
tiledlayout("flow");
nexttile; plot(0:T, smc.ch); title ch;
nexttile; plot(0:T, smc.ih); title ih;
nexttile; plot(0:T, smc.cg); title cg;
nexttile; plot(0:T, smc.w*smc.nh/smc.pch); title curr;

return

dbplot( ...
    smc, 0:T, access(m, "transitionVariables") ...
    , "marker", "s" ...
    , "round", 7 ...
);

end%

