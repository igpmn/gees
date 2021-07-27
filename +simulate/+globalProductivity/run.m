%% Simulate global change in productivity 

function [s, smc, d, modelAfter] = run(model, range, size, stamp)

htmlFileNameTemplate = "global-productivity-$(stamp)";
reportTitleTemplate = "Global change in productivity";
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
% Create an economy with a new level of productivity
%

modelAfter = model;

modelAfter.gg_a = complex( ...
    real(modelAfter.gg_a) * (1 + size) ...
    , imag(modelAfter.gg_a) ...
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
d.gg_shk_a(range(1)) = log(1 + size);

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

