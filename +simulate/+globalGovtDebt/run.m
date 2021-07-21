%% Simulate a permanent change in govt debt globally (in all areas) 

function [s, smc, d, modelAfter] = run(model, range, size, reportStamp)

thisDir = string(fileparts(mfilename("fullpath")));
allAreas = accessUserData(model, "areas");
allPrefixes = utils.resolveArea(allAreas, "prefix");

%
% Create initial steady state databank
%

d = steadydb(model, range);


%
% Create economy with higher debt and reaction function through consumption
% in all areas
%

modelAfter = model;
for a = allPrefixes
    modelAfter.(a+"ss_dg_to_ngdp") = modelAfter.(a+"ss_dg_to_ngdp") + size;
    modelAfter.(a+"tau_cg") = 5;
    modelAfter.(a+"tau_txls1") = 0;
end

modelAfter = steady( ...
    modelAfter ...
    , "fixLevel", ["gg_a", "gg_nt", allPrefixes+"pch"] ...
    , "blocks", false ...
);
checkSteady(modelAfter);
modelAfter = solve(modelAfter);


%
% Simulate transition to the new level of debt; turn off reaction
% in lump-sum taxes temporarily off
%

p = Plan.forModel(modelAfter, range);
for a = allPrefixes
    p = swap(p, range(1:2), [a+"txls1_to_nc", a+"shk_txls1"]);
end

s = simulate( ...
    modelAfter, d, range ...
    , "prependInput", true ...
    , "method", "stacked" ...
    , "plan", p ...
);

%
% Create simulation-minus-control databank
%

smc = databank.minusControl(model, s, "range", range);

%
% Generate HTML report 
%

htmlFileName = fullfile( ...
    thisDir ...
    , sprintf("global-govt-debt-%s", reportStamp) ...
);

reportTitle = "Global change in govt debt through govt consumption";
legend = string(100*size) + "%";

report.basic(model, smc, range, reportTitle, legend, htmlFileName);

end%

