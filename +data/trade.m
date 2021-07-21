%% Visualize trade linkages data


%% Clear workspace

close all
clear

load +data/mat/imf.mat dot bop ifs
chartRange = yy(2015) : yy(2021);


%% Import, export shares of GDP 

d = struct();

for a = ["us", "u2", "cn"]
    d.(a+"_e") = ifs.(a+"_enda_xdc_usd_rate"); 
    d.(a+"_nm_usd") = ifs.(a+"_bmg_bp6_usd") + ifs.(a+"_bms_bp6_usd");
    d.(a+"_nx_usd") = ifs.(a+"_bxg_bp6_usd") + ifs.(a+"_bxs_bp6_usd");
    d.(a+"_ngdp") = ifs.(a+"_ngdp_xdc");
    d.(a+"_ngdp_usd") = d.(a+"_ngdp") / d.(a+"_e");
    d.(a+"_nm_to_ngdp") = d.(a+"_nm_usd") / d.(a+"_ngdp_usd");
    d.(a+"_nx_to_ngdp") = d.(a+"_nx_usd") / d.(a+"_ngdp_usd");
end

d = databank.copy(d, "targetNames", @(n) replace(n, "u2", "ea"), "targetDb", d);

figure();
t = tiledlayout(2, 2);
for a = ["us", "ea", "cn"]
    nexttile();
    bar(chartRange, [d.(a+"_nm_to_ngdp"), d.(a+"_nx_to_ngdp")], "barWidth", 1, "lineStyle", "none");
    title(upper(a));
    legend("Import to GDP ratio", "Export to GDP ratio", "location", "southEast");
end
title(t, "Trade ratios", "fontSize", 20, "fontName", "Open Sans");



%% Regional shares 

figure();
t = tiledlayout(2, 2);
title(t, "Regional breakdown of imports", "fontSize", 20, "fontName", "Open Sans");

% US

d.us_nmg_usd = dot.us_tmg_cif_usd_w00;
d.us_nmg_usd_ea = dot.us_tmg_cif_usd_u2;
d.us_nmg_usd_cn = dot.us_tmg_cif_usd_cn;
d.us_nmg_usd_rw = d.us_nmg_usd - d.us_nmg_usd_ea - d.us_nmg_usd_cn;

nexttile();
area(chartRange, [d.us_nmg_usd_ea, d.us_nmg_usd_cn, d.us_nmg_usd_rw]/d.us_nmg_usd, "lineStyle", "none");
title("US");
legend("US", "EA", "CN");


% Consolidate Eura Area

d.ea_nmg_usd = dot.u2_tmg_cif_usd_w00 - dot.u2_tmg_cif_usd_u2;
d.ea_nxg_usd = dot.u2_txg_fob_usd_w00 - dot.u2_txg_fob_usd_u2;

d.ea_nmg_usd_us = dot.u2_tmg_cif_usd_us;
d.ea_nmg_usd_cn = dot.u2_tmg_cif_usd_cn;
d.ea_nmg_usd_rw = d.ea_nmg_usd - d.ea_nmg_usd_us - d.ea_nmg_usd_cn;

nexttile();
area(chartRange, [d.ea_nmg_usd_us, d.ea_nmg_usd_cn, d.ea_nmg_usd_rw]/d.ea_nmg_usd);
title("EA");
legend("US", "CN", "RW");

% US

d.cn_nmg_usd = dot.cn_tmg_cif_usd_w00;
d.cn_nmg_usd_us = dot.cn_tmg_cif_usd_us;
d.cn_nmg_usd_ea = dot.cn_tmg_cif_usd_u2;
d.cn_nmg_usd_rw = d.cn_nmg_usd - d.cn_nmg_usd_us - d.cn_nmg_usd_ea;

nexttile();
area(chartRange, [d.cn_nmg_usd_us, d.cn_nmg_usd_ea, d.cn_nmg_usd_rw]/d.cn_nmg_usd);
title("CN");
legend("US", "EA", "RW");


% RW

d.rw_nmg_usd_us = ...
    + dot.w00_tmg_cif_usd_us ... 
    - dot.u2_tmg_cif_usd_us ...
    - dot.cn_tmg_cif_usd_us;
;

d.rw_nmg_usd_ea = ...
    + dot.w00_tmg_cif_usd_u2 ... 
    - dot.us_tmg_cif_usd_u2 ...
    - dot.cn_tmg_cif_usd_u2;
;

d.rw_nmg_usd_cn = ...
    + dot.w00_tmg_cif_usd_cn ... 
    - dot.us_tmg_cif_usd_cn ...
    - dot.u2_tmg_cif_usd_cn;
;

d.rw_nmg_usd = d.rw_nmg_usd_us + d.rw_nmg_usd_ea + d.rw_nmg_usd_cn;

nexttile();
area(chartRange, [d.rw_nmg_usd_us, d.rw_nmg_usd_ea, d.rw_nmg_usd_cn]/d.rw_nmg_usd);
title("RW");
legend("US", "EA", "CN");



