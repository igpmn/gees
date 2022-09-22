
close all
clear

m = model.symmetric2A.create();

areas = accessUserData(m, "areas");

m0 = m;
m = alter(m, 2);
m.us_chi_curr(2) = 0.5;
m.ea_chi_curr(2) = 0.5;
m = steady(m, "fixLevel", ["gg_a", "gg_nt", areas+"_pc"]);
m = solve(m);

[s, smc] = simulate.areaInflationShock.run(m, "us", 1:10, 0.10, "+sep2022/alternative-us-inflation.html");

figure();
plot([smc.us_pc{:,2}-smc.us_pc{:,1}, smc.ea_pc{:,2}-smc.ea_pc{:,1}]);
