


close all;
%{
figure();

plot(100*([s.us_unc_r-1, s.us_r-1, s.us_rbl-1, s.us_theta_3*(s.us_unc_r-s.us_r)]));

visual.hlegend("bottom", "Unc", "Actual", "Lending", "Unconv");
%}

mw2 = mw1;
mw2.us_floor = 0;
mw2.ea_floor = 0;
mw2.rw_floor = 0;
[s2, smc2] = simulate.interestFloor(mw2);

tiledlayout("flow")
nexttile
plot([s.us_pk, s2.us_pk]);
title("Asset Prices")

nexttile
plot([s.us_r, s2.us_r]);
title("Nominal Short Rates")

