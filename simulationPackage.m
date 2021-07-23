


close all
clear


load mat/createSymmetricWorld.mat mw


%{
[~, smc] = simulate.globalProductivityImprovements(mw);
locallyPlotResults(smc, "Global Productivity ");

[~, smc] = simulate.areaProductivityImprovements(mw, "us");
locallyPlotResults(smc, "US Productivity ");

[~, smc] = simulate.governmentDebtExpansion(mw, "rw");
locallyPlotResults(smc, "RW Govt Debt ");
%}

[~, smc] = simulate.areaWAP(mw, "ea", 0.04);
locallyPlotResults(smc, "Decline in EA WAP");

%{

mw1 = mw;
mw1.rw_xi_mm = 0;
mw1.rw_xi_y3 = 0;
mw1 = solve(mw1);

[~, smc1] = simulate.areaTariffs(mw, "rw", "us", 0.25);
[~, smc2] = simulate.areaTariffs(mw1, "rw", "us", 0.25);

smc = databank.merge("horzcat", smc1, smc2);

%%

close all


tiledlayout("flow");

nexttile;
plot(0:10, [smc.rw_y, smc.us_y, smc.ea_y]);
title("Gross Production");

nexttile;
plot(0:10, [smc.rw_ch, smc.us_ch, smc.ea_ch]);
title("Consumption");

nexttile;
plot(0:10, [smc.rw_e, smc.us_e, smc.ea_e]);
title("Nominal Exchange Rate");

nexttile;
plot(0:10, [smc.rw_roc_pc, smc.us_roc_pc, smc.ea_roc_pc]);
title("Consumer Inflation");

visual.hlegend("bottom", "RW Baseline", "RW No AC", "US Baseline", "US No AC", "EA Baseline", "EA No AC")

%}


%% Plot Results

function locallyPlotResults(smc, heading)

list = [
    "nw"
    "nf"
    "ch"
    "ih"
    "r"
    "roc_pc"
    "e"
    "xx"
    "mm"
    "nh"
    "q"
    "cg"
    "dg_to_ngdp"
];

dbplot(smc, 0:10, ["gg_a"; "us_"+list], "tight", true, "marker", "s", "caption", @comment, "round", 7);
visual.heading(heading + "US, Deviations from Control");

dbplot(smc, 0:10, ["gg_a"; "ea_"+list], "tight", true, "marker", "s", "caption", @comment, "round", 7);
visual.heading(heading + "EA, Deviations from Control");

dbplot(smc, 0:10, ["gg_a"; "rw_"+list], "tight", true, "marker", "s", "caption", @comment, "round", 7);
visual.heading(heading + "RW, Deviations from Control");

end    
