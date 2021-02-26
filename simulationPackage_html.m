
% Housekeeping

close all
clear

addpath codes;
% Load the model
load mat/createSymmetricWorld.mat mw

% Common parameters
% simrange = yy(1):yy(20);
simrange = 1:20;
areas = ["us", "ea", "cn", "rw"];
% Area-specific variables
list = [
    "nw"
    "nf"
    "ch"
    "ih"
    "r"
    "roc_pch"
    "e"
    "xx"
    "mm"
    "nh"
    "q"
    "cg"
    "dg_to_ngdp"
];


%% Simulations
%01. Permanent level improvements in global productivity
[~, smc] = simulate.globalProductivityImprovements(mw,simrange,true);
[~, smc2] = simulate.globalProductivityImprovements(mw,simrange,false);
% locallyPlotResults(smc, "Global Productivity ");

%   02. Permanent level improvements in regional productivity

% Country whith improved productivity
% simrange = 1:20;
% simrange = yy(1):yy(20);
cc_select3 = "us";
[~, smc3] = simulate.areaProductivityImprovements(mw, simrange, cc_select3);

% 03. Permanent level increase in global population
[~, smc4] = simulate.globalPopulationIncrease(mw,simrange,true);
[~, smc5] = simulate.globalPopulationIncrease(mw,simrange,false);

% 04. Permanent level increase in regional population

cc_select6 = "us";
[~, smc6] = simulate.areaPopulationIncrease(mw, simrange, cc_select6);

% 05 Temporary monetary policy shock

cc_select7 = "us";
[~, smc7] = simulate.areaMonetaryShock(mw, cc_select7, simrange, true);
[~, smc8] = simulate.areaMonetaryShock(mw, cc_select7, simrange, false);

% 06. Permanent increase in government debt through temporary
% increases government consumption

cc_select9 = "rw";
[~, smc9] = simulate.areaGovtDebtExpansion(mw,"rw", simrange, 0.1);

% 07. Permanent increase in government debt through temporary increases government investment
% (not possible to simulate yet)

% 08. Introduction of permanent import tariffs

importer = "rw";
exporter = "us";
[~, smc10] = simulate.areaTariffs(mw, importer, exporter, simrange, 0.25);


mw1 = mw;
mw1.rw_xi_mm = 0;
mw1.rw_xi_y3 = 0;
mw1 = solve(mw1);

[~, smc11] = simulate.areaTariffs(mw1, importer, exporter, simrange, 0.25);

%% Reporting
 rep = rephrase.Report( ...
      "Simulation Experiments Package" ...
      , "chartLibrary", "plotly" ... % chartjs/plotly
      , "interactiveCharts", false ... % make it `false` for huge reports
  );

plotrange = yy(simrange(1)-1):yy(simrange(end));
%%
%01. Permanent level improvements in global productivity

rep ...
    < rephrase.Text.fromString( ...
    "01. Permanent level improvements in global productivity" , "");

for i=1:length(areas)   
    varList = ["gg_a"; areas(i) + "_" + list];
    dbase = {dbinit2time(smc,varList, simrange),...
            dbinit2time(smc2,varList, simrange)};
    gridTitle = [upper(areas(i)) + ": Global productivity shock, deviation from control"];
    label = ["Anticipated", "Non-anticipated"];
    [grid,chr] = locallyPlotResults_html(dbase, varList, plotrange, gridTitle, label);
    eval(chr);
end

 
%  for i = 1:length(areas)            
%   grid = rephrase.Grid(upper(areas(i) + ": Global productivity shock, deviation from control"), 4, 4, 'DateFormat', 'YY', "DisplayTitle", true);
%       chart1 = rephrase.Chart(get(smc.gg_a,'comment'),simrange(1),simrange(end)) ...
%           < rephrase.Series("Anticipated", smc.gg_a) ...
%           < rephrase.Series("Non-anticipated", smc2.gg_a);
%     for j = 1:length(varlist)
%       assignin ( 'caller', "chart" + num2str(j+1), ...
%         rephrase.Chart(get(smc.(areas(i) + "_" + varlist(j)),'comment'),simrange(1),simrange(end)) ...
%           < rephrase.Series("Anticipated", smc.(areas(i) + "_" + varlist(j))) ...
%           < rephrase.Series("Non-anticipated", smc2.(areas(i)+ "_" +varlist(j))) );
%     end
%   rep ...
%       < rephrase.Pagebreak( ) ...
%       < (grid < chart1 < chart2 < chart3 < chart4 ...
%               < chart5 < chart6 < chart7 < chart8 ...
%               < chart9 < chart10 < chart11 < chart12 ...
%               < chart13 < chart14); 
 
  %%
%   02. Permanent level improvements in regional productivity

rep ...
    < rephrase.Text.fromString( ...
    "02. Permanent level improvements in regional productivity" , "");

for i=1:length(areas)   
    varList = ["gg_a"; areas(i) + "_" + list];
    dbase = {dbinit2time(smc3,varList, simrange)};
    gridTitle = [upper(areas(i)) + ": Area productivity shock (" + upper(cc_select6) + "), deviation from control"];
    label = [""];
    [grid,chr] = locallyPlotResults_html(dbase, varList, plotrange, gridTitle, label);
    eval(chr);
end


  %%
% 03. Permanent level increase in global population

rep ...
    < rephrase.Text.fromString( ...
    "03. Permanent level increase in global population" , "");

for i=1:length(areas)   
    varList = ["gg_a"; areas(i) + "_" + list];
    dbase = {dbinit2time(smc4,varList, simrange),...
            dbinit2time(smc5,varList, simrange)};
    gridTitle = [upper(areas(i)) + ": Permanent level increase in global population, deviation from control"];
    label = ["Anticipated", "Non-anticipated"];
    [grid,chr] = locallyPlotResults_html(dbase, varList, plotrange, gridTitle, label);
    eval(chr);
end

%%
% 04. Permanent level increase in regional population

rep ...
    < rephrase.Text.fromString( ...
    "04. Permanent level increase in regional population" , "");

for i=1:length(areas)   
    varList = ["gg_a"; areas(i) + "_" + list];
    dbase = {dbinit2time(smc6,varList, simrange)};
    gridTitle = [upper(areas(i)) + ": Permanent level increase in area population (" + upper(cc_select6) + "), deviation from control"];
    label = [""];
    [grid,chr] = locallyPlotResults_html(dbase, varList, plotrange, gridTitle, label);
    eval(chr);
end

%%
% 05. Temporary monetary policy shock

rep ...
    < rephrase.Text.fromString( ...
    "05. Temporary monetary policy shock" , "");

for i=1:length(areas)   
    varList = ["gg_a"; areas(i) + "_" + list];
    dbase = {dbinit2time(smc7,varList, simrange),...
                dbinit2time(smc8,varList, simrange)};
    gridTitle = [upper(areas(i)) + ": Temporary monetary policy shock (" + upper(cc_select7) + "), deviation from control"];
    label = ["Anticipated", "Non-anticipated"];
    [grid,chr] = locallyPlotResults_html(dbase, varList, plotrange, gridTitle, label);
    eval(chr);
end
%%
% 06. Permanent increase in government debt through temporary
% increases government consumption

rep ...
    < rephrase.Text.fromString( ...
    "06. Permanent increase in government debt through temporary increases government consumption" , "");

for i=1:length(areas)   
    varList = ["gg_a"; areas(i) + "_" + list];
    dbase = {dbinit2time(smc9,varList, simrange)};
    gridTitle = [upper(areas(i)) + ": Permanent increase in government debt (" + upper(cc_select9) + "), deviation from control"];
    label = [""];
    [grid,chr] = locallyPlotResults_html(dbase, varList, plotrange, gridTitle, label);
    eval(chr);
end
%%
% 07. Permanent increase in government debt through temporary increases government investment
% (not possible to simulate yet)

%%
% 08. Introduction of permanent import tariffs
 
rep ...
    < rephrase.Text.fromString( ...
    "08. Introduction of permanent import tariffs" , "");

for i=1:length(areas)   
    varList = ["gg_a"; areas(i) + "_" + list];
    dbase = {dbinit2time(smc10,varList, simrange),...
                dbinit2time(smc11,varList, simrange)};
    gridTitle = [upper(areas(i)) + ": Introduction of permanent import tariffs (" + upper(importer) + " against "+upper(exporter)+ "), deviation from control"];
    label = ["Adjustment cost", "No adjustment cost"];
    [grid,chr] = locallyPlotResults_html(dbase, varList, plotrange, gridTitle, label);
    eval(chr);
end

  fileNames = build( ...
      rep, "docs/Simulation_Experiments_Package", smc ...
      , "source", ["web"] ...
  );
  disp('HTML reporting finished')

