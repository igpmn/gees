%% Simulate permanent change in an area's relative productivity

function [s, smc, d, modelAfter] = run(model, area, range, size, stamp)

htmlFileNameTemplate = "area-productivity-$(area)-$(stamp)";
reportTitleTemplate = "Area $(area) change in relative productivity";
legend = string(100*size) + "%";

thisDir = string(fileparts(mfilename("fullpath")));
areaPrefix = utils.resolveArea(area, "prefix");
allAreas = accessUserData(model, "areas");
allPrefixes = utils.resolveArea(allAreas, "prefix");


%
% Create initial steady state databank
%

d0 = steadydb(model, range);


%
% Create an economy with a new level of relative productivity
%

modelAfter = model;
modelAfter.(areaPrefix+"ss_ar") = modelAfter.(areaPrefix+"ss_ar") * (1 + size);

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

smc = databank.minusControl(model, s, d0, "range", range);


%
% Generate HTML reports
%

reportTitle = reportTitleTemplate;
reportTitle = replace(reportTitle, "$(area)", upper(area));

htmlFileName = htmlFileNameTemplate;
htmlFileName = replace(htmlFileName, "$(area)", upper(area));
htmlFileName = replace(htmlFileName, "$(stamp)", stamp);
htmlFileName = fullfile(thisDir, htmlFileName);

report.basic(model, smc, range, reportTitle, legend, htmlFileName);

end%

