function [s, smc] = areaProductivityImprovements(m)

T = 20;

d = steadydb(m, 1:T);

m.us_ss_a = m.us_ss_a * 1.10;
m.us_a = m.us_a;
m = steady(m);
checkSteady(m);
m = solve(m);

p = Plan.forModel(m, 1:T);
p = swap(p, 1:2, ["us_a", "us_shk_a"]);

s = simulate( ...
    m, d, 1:T ...
    , "prependInput", true ...
    , "method", "stacked" ...
    , "blocks", false ...
    , "plan", p ...
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

