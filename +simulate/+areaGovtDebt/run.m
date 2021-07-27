%% Simulate a permanent change in an area's govt debt 

function [s, smc, d, modelAfter] = run(model, area, range, size, stamp)

htmlFileNameTemplate = "area-govt-debt-$(area)-$(stamp)";
reportTitleTemplate = "Area $(area) government debt expansion simulation";
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
% Create an economy with a new level of govt debt
%

modelAfter = model;
modelAfter.(areaPrefix+"ss_dg_to_ngdp") = modelAfter.(areaPrefix+"ss_dg_to_ngdp") + size;
modelAfter.(areaPrefix+"tau_cg") = 5;
modelAfter.(areaPrefix+"tau_txls1") = 0;

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

p = Plan.forModel(modelAfter, range);
p = swap(p, range(1:2), [areaPrefix+"txls1_to_nc", areaPrefix+"shk_txls1"]);

s = simulate( ...
    modelAfter, d, range ...
    , "prependInput", true ...
    , "method", "stacked" ...
    , "plan", p ...
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

