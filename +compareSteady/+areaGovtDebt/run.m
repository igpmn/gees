%% Permanent change in area government debt 

function [steadyTable, modelAfter] = run(model, area, size, reportStamp)

thisDir = string(fileparts(mfilename("fullpath")));

prefix = utils.resolveArea(area, "prefix");
areas = accessUserData(model, "areas");
allPrefixes = utils.resolveArea(areas, "prefix");

%
% Create model with a different level of government debt in all areas
%

modelAfter = model;
modelAfter.(prefix+"ss_dg_to_ngdp") = model.(prefix+"ss_dg_to_ngdp") + size;

modelAfter = steady( ...
    modelAfter ...
    , "fixLevel", ["gg_a", "gg_nt", allPrefixes+"pch"] ...
    , "blocks", false ...
);

checkSteady(modelAfter);

%
% Create steady state comparison table, save to Excel spreadsheet
%

excelFileName = fullfile( ...
    thisDir ...
    , sprintf("area-govt-debt-%s-%s.xlsx", upper(area), string(reportStamp)) ...
);

steadyTable = table( ...
    [model, modelAfter] ...
    , ["steadyLevel", "compareSteadyLevel", "steadyChange", "compareSteadyChange", "form", "description"] ...
    , "round", 8 ...
    , "writeTable", excelFileName ...
); 

end%

