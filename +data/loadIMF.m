%% Load IMF data on BOP, IIP and GDP

close all
clear

areas = ["US", "U2", "CN", "W00"];


%% Directions of trade 

dotIndicators = "";

fprintf("• Loading DOT...");
dot = databank.fromIMF.data("DOT", Frequency.Yearly, areas, {dotIndicators, areas}, "nameFunc", @lower);
fprintf("done\n");


%% BOP and IIP aggregates 

bopIndicators = [
    textual.xlist("", ["BM", "BX"], ["G", "S"], "_BP6_USD") ...
];

fprintf("• Loading BOPAGG...");
bop = databank.fromIMF.data("BOPAGG", Frequency.Yearly, areas, bopIndicators, "nameFunc", @lower);
fprintf("done\n");


%% International financial statistics 

% GDP, export, import

ifsIndicators1 = [ 
    , textual.xlist("", ["NGDP", "NX", "NM"], ["_XDC"]) ...
    , textual.xlist("", ["BM", "BX"], ["G", "S"], "_BP6_", ["USD", "XDC"]) ...
    , textual.xlist("", "TM", ["G", "S"], ["_FOB_", "_CIF_"], ["USD", "XDC"]) ...
];

fprintf("• Loading IFS Part 1...");
ifs1 = databank.fromIMF.data("IFS", Frequency.Yearly, areas, ifsIndicators1, "nameFunc", @lower);
fprintf("done\n");


% Exchange rates

ifsIndicators2 = [
    , ["ENDE_XDC_USD_RATE", "ENDA_XDC_USD_RATE"] ...
];

fprintf("• Loading IFS Part 2...");
ifs2 = databank.fromIMF.data("IFS", Frequency.Yearly, areas, ifsIndicators2, "nameFunc", @lower);
fprintf("done\n");


% Interest rates

ifsIndicators3 = [
    "FIGBY_PA"
    "FII_3M_PA"
    "FIACF_PA"
    "FIBFR_PA"
    "FICB_PA"
    "FICD_PA"
    "FICPR_PA"
    "FIDR_FX_EUR_PA"
    "FIDR_FX_USD_PA"
    "FIDR_FX_PA"
    "FIDR_ON_PA"
    "FIDR_PA"
    "FID_FX_PA"
    "FID_PA"
    "FIDFR_PA"
    "FIGBY_MT_PA"
    "FIGBY_SM_PA"
    "FIGB_MLT_PA"
    "FIGB_PA"
    "FIGB_S_PA"
    "FITB_3M_PA"
    "FITBBE_PA"
    "FITB_FX_PA"
    "FITB_IX"
    "FITB_L_PA"
    "FITB_PA"
    "FIH_HH_L_CC_1Y_PA"
    "FIH_HH_L_HP_O5Y_PA"
    "FIH_NFC_L_1Y_PA"
    "FIHN_HH_D_AM_1Y_PA"
    "FIHN_HH_D_FX_PA"
    "FIHN_HH_D_NC_PA"
    "FIHN_NFC_D_AM_1Y_PA"
    "FIHN_NFC_D_FX_PA"
    "FIHN_NFC_D_NC_PA"
    "FIHN_HH_L_CO_1Y_PA"
    "FIHN_HH_L_FX_PA"
    "FIHN_HH_L_HP_O5Y_PA"
    "FIHN_HH_L_NC_PA"
    "FIHN_NFC_L_FX_PA"
    "FIHN_NFC_L_NC_PA"
    "FIHN_NFC_L_OT_O1MILL_1Y_PA"
    "FIHN_NFC_L_OT_O1MILL_3M_1Y_PA"
    "FIHO_HH_D_AM_2Y_PA"
    "FIHO_NFC_D_AM_2Y_PA"
    "FIHO_NFC_D_RP_PA"
    "FIRAK_PA"
    "FILR_FX_EUR_PA"
    "FILR_FX_PA"
    "FILR_FX_USD_PA"
    "FILR_ON_PA"
    "FILR_PA"
    "FILED_3M_PA"
    "FILIBOR_1M_PA"
    "FILIBOR_1Y_PA"
    "FILIBOR_ON_PA"
    "FILIBOR_6M_PA"
    "FPOLM_PA"
    "FIMM_FX_PA"
    "FIMM_MAX_PA"
    "FIMM_MIN_PA"
    "FIMM_PA"
    "FIRR_PA"
    "FIR_PA"
    "FIRA_PA"
    "FIRAR_PA"
    "FISR_FX_PA"
    "FISR_PA"
    "FISDR_PA"
];

fprintf("• Loading IFS Part 3...");
ifs3 = struct();
by = 1;
for i = 1 : by : numel(ifsIndicators3)
    sublist = ifsIndicators3(i:min(i+by-1, end));
    temp = databank.fromIMF.data("IFS", Frequency.Yearly, areas, sublist, "nameFunc", @lower, "whenEmpty", "silent");
    ifs3 = databank.merge("error", ifs3, temp);
end
fprintf("done\n");

% Prices

ifsIndicators4 = [
    "PCPI_IX"
    "PCPIHA_IX"
    "PPPIFG_IX"
];

fprintf("• Loading IFS Part 4...");
ifs4 = databank.fromIMF.data("IFS", Frequency.Yearly, areas, ifsIndicators4, "nameFunc", @lower);
fprintf("done\n");


% Merge all IFS retrievals

ifs = databank.merge("error", ifs1, ifs2, ifs3, ifs4);


%% Save to mat 

if ~exist(fullfile("+data", "mat"), "dir")
    mkdir(fullfile("+data", "mat"));
end

save +data/mat/imf.mat dot bop ifs 

