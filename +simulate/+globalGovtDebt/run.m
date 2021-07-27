%% Simulate a permanent change in govt debt globally 

function [s, smc, d, modelAfter] = run(model, range, size, stamp)

htmlFileNameTemplate = "global-govt-debt-$(stamp)";
reportTitleTemplate = "Global change in government debt";
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
% Create an economy with a new level of govt debt
%

modelAfter = model;
for a = allPrefixes
    modelAfter.(a+"ss_dg_to_ngdp") = modelAfter.(a+"ss_dg_to_ngdp") + size;
    modelAfter.(a+"tau_cg") = 5;
    modelAfter.(a+"tau_txls1") = 0;
end

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
for a = allPrefixes
    p = swap(p, range(1:2), [a+"txls1_to_nc", a+"shk_txls1"]);
end

s = simulate( ...
    modelAfter, d, range ...
    , "prependInput", true ...
    , "method", "stacked" ...
    , "plan", p ...
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

