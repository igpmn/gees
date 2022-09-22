%% Simulate a permanent change in an area's steady-state inflation a

function [s, smc, d, modelAfter] = areaDisinflation(model, area, range, size, htmlFileName)

%htmlFileNameTemplate = "area-disinflation-$(area)-$(stamp)";
reportTitleTemplate = "Area $(area) disinflation";
legend = upper(area) + "@" + string(100*size) + "%";

thisDir = string(fileparts(mfilename("fullpath")));
areaPrefix = utils.resolveArea(area, "prefix");
allAreas = accessUserData(model, "areas");
allPrefixes = utils.resolveArea(allAreas, "prefix");


%
% Create initial steady state databank
%

d0 = steadydb(model, range);


%
% Create an economy with a new level of inflation
%

modelAfter = model;
modelAfter.(areaPrefix+"ss_roc_pc") = modelAfter.(areaPrefix+"ss_roc_pc") - size;

modelAfter = steady( ...
    modelAfter ...
    , "fixLevel", ["gg_a", "gg_nt", allPrefixes+"pc"] ...
    , "blocks", false ...
);
checkSteady(modelAfter);
modelAfter = solve(modelAfter);


%
% Simulate transition 
%

d = d0;

s = simulate( ...
    modelAfter, d, range ...
    , "prependInput", true ...
    , "method", "stacked" ...
);

smc = databank.minusControl(model, s, d0, "range", range);
steadyDb = databank.forModel(modelAfter, range);
steadyDb = databank.minusControl(model, steadyDb, d0, "range", range);


%
% Generate HTML reports
%

reportTitle = reportTitleTemplate;
reportTitle = replace(reportTitle, "$(area)", upper(area));

%htmlFileName = htmlFileNameTemplate;
htmlFileName = replace(htmlFileName, "$(area)", upper(area));
% htmlFileName = replace(htmlFileName, "$(stamp)", stamp);
% htmlFileName = fullfile(thisDir, htmlFileName);

report.basicWithSteady(model, smc, steadyDb, range, reportTitle, legend, htmlFileName);

end%

