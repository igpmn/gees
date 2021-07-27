%% Simulate global change in population 

function [s, smc, d, modelAfter] = globalPopulation(model, range, size, stamp)

htmlFileNameTemplate = "global-population-$(stamp)";
reportTitleTemplate = "Global change in population";
legend = string(100*size) + "%";

area = "";
thisDir = string(fileparts(mfilename("fullpath")));
allAreas = accessUserData(model, "areas");
allPrefixes = utils.resolveArea(allAreas, "prefix");

%
% Create initial steady state databank
%

d0 = steadydb(model, range);


%
% Create an economy with a new level of population
%

modelAfter = model;
modelAfter.gg_nt = complex( ...
    real(modelAfter.gg_nt) * (1 + size) ...
    , imag(modelAfter.gg_nt) ...
);

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
d.gg_shk_nn(range(1)) = log(1 + size);

s = simulate( ...
    modelAfter, d, range ...
    , "prependInput", true ...
    , "method", "stacked" ...
);

smc = databank.minusControl(model, s, "range", range);


%
% Generate HTML report 
%

reportTitle = reportTitleTemplate;
reportTitle = replace(reportTitle, "$(area)", upper(area));

htmlFileName = htmlFileNameTemplate;
htmlFileName = replace(htmlFileName, "$(area)", upper(area));
htmlFileName = replace(htmlFileName, "$(stamp)", stamp);
htmlFileName = fullfile(thisDir, htmlFileName);

report.basic(model, smc, range, reportTitle, legend, htmlFileName);

end%

