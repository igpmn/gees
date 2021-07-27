%% Simulate an area's change in import tariffs on another area 

function [s, smc, d, modelAfter] = run(model, area, counter, range, size, stamp)

htmlFileNameTemplate = "area-import-tariffs-$(area)-$(counter)-$(stamp)";
reportTitleTemplate = "Area $(area) change in import tariffs on $(counter)";
legend = string(100*size) + "%";

thisDir = string(fileparts(mfilename("fullpath")));
areaPrefix = utils.resolveArea(area, "prefix");
counterSuffix = utils.resolveArea(counter, "suffix");
allAreas = accessUserData(model, "areas");
allPrefixes = utils.resolveArea(allAreas, "prefix");


%
% Create initial steady state databank
%

d0 = steadydb(model, range);


%
% Create an economy with a new level of import tariffs
%

modelAfter = model;
modelAfter.(areaPrefix+"ss_trm"+counterSuffix) = modelAfter.(areaPrefix+"ss_trm"+counterSuffix) + size;

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
    , "blocks", false ...
);

smc = databank.minusControl(modelAfter, s, d);


%
% Generate HTML reports
%

reportTitle = reportTitleTemplate;
reportTitle = replace(reportTitle, "$(area)", upper(area));
reportTitle = replace(reportTitle, "$(counter)", upper(counter));

htmlFileName = htmlFileNameTemplate;
htmlFileName = replace(htmlFileName, "$(area)", upper(area));
htmlFileName = replace(htmlFileName, "$(counter)", upper(counter));
htmlFileName = replace(htmlFileName, "$(stamp)", stamp);
htmlFileName = fullfile(thisDir, htmlFileName);

report.basic(model, smc, range, reportTitle, legend, htmlFileName);

end%

