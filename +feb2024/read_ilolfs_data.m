
close all
clear

load +feb2024/mat/wpp2022_data.mat wpp

table = readtable( ...
    "+feb2024/EAP_2WAP_SEX_AGE_RT_A.csv" ...
    , NumHeaderLines=0 ...
    , TextType="string" ...
    , VariableNamingRule="preserve" ...
);

ea = struct("at", "aut", "be", "bel", "cy", "cyp", "ee", "est", "fi", "fin", "fr", "fra", "de", "deu", "gr", "grc", "ie", "irl", "it", "ita", "lv", "lva", "lt", "ltu", "lu", "lux", "mt", "mlt", "nl", "nld", "pt", "prt", "sk", "svk", "si", "svn", "es", "esp", "hr", "hrv");
regions = struct("cn", "chn", "us", "usa");

lfs = struct();
lfs.ea_nf = 0;
for n2 = databank.fieldNames(ea)
    n3 = ea.(n2);
    inx = ...
        table.("ref_area") == upper(n3) ...
        & table.("sex") == "SEX_T" ...
        & table.("classif1") == "AGE_YTHADULT_Y15-64" ...
    ;
    years = yy(table.("time")(inx));
    values = table.("obs_value")(inx);

    lfs.(n2 + "_nf_to_nw") = Series(years, values) / 100;
    lfs.(n2 + "_nf") = lfs.(n2 + "_nf_to_nw") * wpp.(n2 + "_nw");
    lfs.ea_nf = lfs.ea_nf + lfs.(n2 + "_nf");
end
lfs.ea_nf_to_nw = lfs.ea_nf / wpp.ea_nw;


for n2 = databank.fieldNames(regions)
    n3 = regions.(n2);
    inx = ...
        table.("ref_area") == upper(n3) ...
        & table.("sex") == "SEX_T" ...
        & table.("classif1") == "AGE_YTHADULT_Y15-64" ...
    ;
    years = yy(table.("time")(inx));
    values = table.("obs_value")(inx);

    lfs.(n2 + "_nf_to_nw") = Series(years, values) / 100;
    lfs.(n2 + "_nf") = lfs.(n2 + "_nf_to_nw") * wpp.(n2 + "_nw");
end

save +feb2024/mat/ilolfs.mat lfs
databank.toSheet(lfs, "+feb2024/csv/ilolfs.csv");

