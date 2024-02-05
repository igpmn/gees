                                                                                
%% Simulate global demographic changes
                                                                                


close all
clear

load +feb2024/mat/wpp2022_data.mat wpp
load +feb2024/mat/ilolfs.mat lfs
load +feb2024/mat/global4a.mat m4


T = 30;
m = m4;

checkSteady(m);
m = solve(m);

d0 = databank.forModel(m, 1:T);

areas = accessUserData(m, "areas");
fix = accessUserData(m, "fix");
tableColumns = ["SteadyLevel", "SteadyChange", "CompareSteadyLevel", "CompareSteadyChange"];


                                                                                
%% Partial scenario A: Lower population growth
                                                                                

ma = m;
ma.gg_ss_roc_nt = 1.005;
ma = steady(ma, fixLevel=fix);

ta = table( ...
    [m, ma], tableColumns ...
    , round=8 ...
    , writeTable="+feb2024/steady/demography_a.xlsx" ...
);


                                                                                
%% Partial scenario B: Shrinking working age population
                                                                                

mb = alter(m, 2);

mb.us_ss_nw_to_nn = 0.60;
mb.ea_ss_nw_to_nn = 0.57;
mb.cn_ss_nw_to_nn = 0.65;
% mb.rw_ss_nw_to_nn = ...;

mb.us_eta_long = [0, 0.7];
mb.ea_eta_long = [0, 0.7];
mb.cn_eta_long = [0, 0.7];
mb.rw_eta_long = [0, 0.7];

mb.us_ref_nh = m.us_nh;
mb.ea_ref_nh = m.ea_nh;
mb.cn_ref_nh = m.cn_nh;
mb.rw_ref_nh = m.rw_nh;

mb = steady(mb, fixLevel=fix);
checkSteady(mb);
mb = solve(mb);

tb = table( ...
    [m, mb], ["SteadyLevel", "CompareSteadyLevel", "SteadyChange", "CompareSteadyChange"] ...
    , round=8 ...
    , writeTable="+feb2024/steady/demography_b.xlsx" ...
);

db = d0;
sb = simulate( ...
    mb, db, 1:T ...
    , prependInput=true ...
    , method="stacked" ...
);
sb = postprocess(mb, sb, 0:T);


smcb = databank.minusControl(m, sb, d0);

report.basic( ...
    m, smcb, 1:T ...
    , "Demography: Shrinking WAP" ...
    , [] ...
    , "+feb2024/html/demography_b" ...
);



                                                                                
%% Partial scenario C: Aging effect on consumption-saving
                                                                                


mc = m; %alter(m, 2);

% mc.us_eta_long = 0.7;
% mc.ea_eta_long = 0.7;
% mc.cn_eta_long = 0.7;
% mc.rw_eta_long = 0.7;
% 
% mc.us_ref_nh = m.us_nh;
% mc.ea_ref_nh = m.ea_nh;
% mc.cn_ref_nh = m.cn_nh;
% mc.rw_ref_nh = m.rw_nh;

% mc.us_nu_1 = mc.us_nu_1 / 2;
% mc.ea_nu_1 = mc.ea_nu_1 / 2;
% mc.cn_nu_1 = mc.cn_nu_1 / 2;
% mc.rw_nu_1 = mc.rw_nu_1 / 2;

% mc.us_nu_0 = mc.us_nu_0 * 0.8;
% mc.ea_nu_0 = mc.ea_nu_0 * 0.8;
% mc.cn_nu_0 = mc.cn_nu_0 * 0.8;
% mc.rw_nu_0 = mc.rw_nu_0 * 0.8;
% 
% mc = steady(mc, fixLevel=fix);
% checkSteady(mc);
% 
% tc = table( ...
%     [m, mc], ["SteadyLevel", "CompareSteadyLevel", "SteadyChange", "CompareSteadyChange"] ...
%     , round=8 ...
%     , writeTable="+feb2024/steady/demography_c.xlsx" ...
% );
% 
% xc = access([m, mc], "steady-level");
% 


                                                                                
%% Complete scenario D: All combined
                                                                                

md = m;

md.gg_ss_roc_nt = 1.005;


md.us_ss_nw_to_nn = 0.60;
md.ea_ss_nw_to_nn = 0.57;
md.cn_ss_nw_to_nn = 0.65;
% md.rw_ss_nw_to_nn = ...;

md.us_eta_long = 0.7;
md.ea_eta_long = 0.7;
md.cn_eta_long = 0.7;
md.rw_eta_long = 0.7;

md.us_ref_nh = m.us_nh;
md.ea_ref_nh = m.ea_nh;
md.cn_ref_nh = m.cn_nh;
md.rw_ref_nh = m.rw_nh;

md = steady(md, fixLevel=fix);
checkSteady(md);
md = solve(md);

td = table( ...
    [m, md], tableColumns ...
    , round=8 ...
    , writeTable="+feb2024/steady/demography_d.xlsx" ...
);

dd = d0;
sd = simulate( ...
    md, dd, 1:T ...
    , prependInput=true ...
    , method="stacked" ...
);
sd = postprocess(md, sd, 0:T);


smcd = databank.minusControl(m, sd, d0);

report.basic( ...
    m, smcd, 1:T ...
    , "Demography: Shrinking WAP" ...
    , [] ...
    , "+feb2024/html/demography_b" ...
);


