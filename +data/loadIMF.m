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

ifsIndicators1 = [ 
    , textual.xlist("", ["NGDP", "NX", "NM"], ["_XDC"]) ...
    , textual.xlist("", ["BM", "BX"], ["G", "S"], "_BP6_", ["USD", "XDC"]) ...
    , textual.xlist("", "TM", ["G", "S"], ["_FOB_", "_CIF_"], ["USD", "XDC"]) ...
];

fprintf("• Loading IFS Part 1...");
ifs1 = databank.fromIMF.data("IFS", Frequency.Yearly, areas, ifsIndicators1, "nameFunc", @lower);
fprintf("done\n");

ifsIndicators2 = [
    , ["ENDE_XDC_USD_RATE", "ENDA_XDC_USD_RATE"] ...
];

fprintf("• Loading IFS Part 2...");
ifs2 = databank.fromIMF.data("IFS", Frequency.Yearly, areas, ifsIndicators2, "nameFunc", @lower);
fprintf("done\n");

ifs = databank.merge("error", ifs1, ifs2);


%% Save to mat 

if ~exist(fullfile("+data", "mat"), "dir")
    mkdir(fullfile("+data", "mat"));
end

save +data/mat/imf.mat dot bop ifs 

