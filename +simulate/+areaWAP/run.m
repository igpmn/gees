%% Simulate increase in an area's working age population share 

function [s, smc, d, modelAfter] = areaPopulation(model, area, range, size, stamp)

htmlFileNameTemplate = "area-wap-$(area)-$(stamp)";
reportTitleTemplate = "Area $(area) change in working age population share";
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
% Create economy with a new level of population
%

modelAfter = model;
modelAfter.(areaPrefix+"ss_nw_to_nn") = model.(areaPrefix+"ss_nw_to_nn") + size;

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

