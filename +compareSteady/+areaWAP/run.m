%% Permanent change in area working age population 

function [steadyTable, modelAfter] = run(model, area, size, reportStamp)

thisDir = string(fileparts(mfilename("fullpath")));

prefix = utils.resolveArea(area, "prefix");

areas = accessUserData(model, "areas");
allPrefixes = utils.resolveArea(areas, "prefix");

%
% Create model with a different share of WAP in total population
%

modelAfter = model;
modelAfter.(prefix+"ss_nw_to_nn") = model.(prefix+"ss_nw_to_nn") + size;

modelAfter = steady( ...
    modelAfter ...
    , "fixLevel", ["gg_a", "gg_nt", allPrefixes+"pc"] ...
    , "blocks", false ...
);

checkSteady(modelAfter);

steadyTable = table( ...
    [model, modelAfter] ...
    , ["steadyLevel", "compareSteadyLevel", "steadyChange", "compareSteadyChange", "form", "description"] ...
    , "round", 8 ...
    , "writeTable", fullfile(thisDir, "area-wap-"+upper(area)+"-"+string(reportStamp)+".xlsx") ...
); 

end%

