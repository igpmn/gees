%% Simulate a permanent change in area govt debt 

function [s, smc, d, modelAfter] = run(model, area, range, size, reportStamp)

thisDir = string(fileparts(mfilename("fullpath")));
prefix = utils.resolveArea(area, "prefix");
allAreas = accessUserData(model, "areas");
allPrefixes = utils.resolveArea(allAreas, "prefix");

%
% Create initial steady state databank
%

d = steadydb(model, range);


%
% Create economy with higher debt and reaction function through consumption
%

modelAfter = model;
modelAfter.(prefix+"ss_dg_to_ngdp") = modelAfter.(prefix+"ss_dg_to_ngdp") + size;
modelAfter.(prefix+"tau_cg") = 5;
modelAfter.(prefix+"tau_txls1") = 0;

modelAfter = steady(modelAfter ...
    , "fixLevel", ["gg_a", "gg_nt", allPrefixes+"pc"] ...
    , "blocks", false ...
);
checkSteady(modelAfter);
modelAfter = solve(modelAfter);


%
% Simulate government debt expansion from low to high
%
p = Plan.forModel(modelAfter, range);
p = swap(p, range(1:2), [prefix+"txls1_to_nc", prefix+"shk_txls1"]);

s = simulate( ...
    modelAfter, d, range ...
    , "prependInput", true ...
    , "method", "stacked" ...
    , "plan", p ...
);


%
% Simulate transition to the new level of debt; turn off reaction
% in lump-sum taxes temporarily off
%

smc = databank.minusControl(model, s, "range", range);

%
% Generate HTML reports
%

htmlFileName = fullfile( ...
    thisDir ...
    , sprintf("area-govt-debt-%s-%s", upper(area), reportStamp) ...
);

reportTitle = "Area " + upper(area) + " government debt expansion simulation";
legend = string(100*size) + "%";

report.basic(model, smc, range, reportTitle, legend, htmlFileName);

end%

