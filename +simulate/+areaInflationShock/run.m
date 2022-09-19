%% Simulate temporary inflation shock 

function [s, smc, d, modelAfter] = areaInflationShock(model, area, range, size, stamp)

htmlFileNameTemplate = "area-inflation-shock-$(area)-$(stamp)";
reportTitleTemplate = "Area $(area) inflation shock";
legend = string(100*size) + "%";

thisDir = string(fileparts(mfilename("fullpath")));
areaPrefix = utils.resolveArea(area, "prefix");
allAreas = accessUserData(model, "areas");
allPrefixes = utils.resolveArea(allAreas, "prefix");


%
% Create initial steady state databank
%

d0 = databank.forModel(model, range);


%
% Create an economy with a new level of govt debt
%

modelAfter = model;


%
% Simulate shock
%

d = d0;
d.(areaPrefix+"shk_py")(range(1)) = size;

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

