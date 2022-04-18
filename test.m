


load +model/+autarky/model.mat ma
load +model/+global4A/model.mat m4

m = ma;
% m = m4;


areas = accessUserData(m, "areas");
if isequal(areas, "")
    areas = "";
    shk_area = "";
else
    areas = areas + "_";
    shk_area = areas(1);
end


% m = alter(m, 2);
% m = assign(m, areas+"chi_curr", 0);
m.eta = 0.5;
% m(2) = assign(m(2), areas+"theta_1", 0.5);
m = steady(m);
checkSteady(m);
m = solve(m);

ss = steadydb(m, 1:10);

d = ss;
%d.(shk_area+"shk_w")(1) = 0.01;
d.(shk_area+"shk_nf_to_nw")(1) = -0.10;

s = simulate(m, d, 1:10, method="stacked", prependInput=true);
smc = databank.minusControl(m, s, ss);

%%

ch = databank.Chartpack();
ch.Range = 0:10;
ch.Round = 8;

ch < ["nf", "nh", "w", "w/pc", "roc_pc", "ch", "ih", "ref_ch", "k", "nfa_to_ngdp"];

if isequal(areas, "")
    chartDb = smc;
else
    listUS = databank.filterFields(smc, name=@(n) startsWith(n, "us_"));
    chartDb = databank.copy(smc, sourceNames=listUS, targetNames=@(n) erase(n, "us_"));
end

draw(ch, chartDb);

