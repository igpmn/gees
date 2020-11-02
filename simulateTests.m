
close all
clear

load mat/createModel.mat m

T = 20;

[d, dev] = zerodb(m, 1:T);
d.shk_a(4) = log(1.10);
p = true;

% d.shk_w(1) = log(1.10);
% d.shk_curr(1) = log(1.10);

% {
[d, dev] = steadydb(m, 1:T);
m.ss_dg_to_ngdp = m.ss_dg_to_ngdp + 0.20;
m.tau_cg = 3;
m.tau_txl1 = 0;
p = Plan.forModel(m, 1:T);
p = swap(p, 1:2, ["txl1", "shk_txl1"]);

m = steady(m ...
    , "fixLevel", ["a", "nn", "pch"] ...
);
checkSteady(m);
m = solve(m);
% } 

s = simulate( ...
    m, d, 1:T ...
    , "prependInput", true ...
    , "method", "stacked" ...
    , "blocks", false ...
    , "deviation", dev ...
    , "plan", p ...
);

smc = dbminuscontrol(m, s, d);

figure();
subplot(3,2,1); plot(0:T, smc.ch); title ch;
subplot(3,2,2); plot(0:T, smc.ih); title ih;
subplot(3,2,3); plot(0:T, smc.cg); title cg;
subplot(3,2,4); plot(0:T, smc.w*smc.nh/smc.pch); title curr;
return

dbplot( ...
    smc, 0:T, access(m, "transitionVariables") ...
    , "marker", "s" ...
    , "round", 7 ...
);


