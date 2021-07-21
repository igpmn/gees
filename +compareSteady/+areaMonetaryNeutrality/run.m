%% Verify monetary neutrality 

function [steadyTable, modelAfter] = run(model, area, size, reportStamp)

thisDir = string(fileparts(mfilename("fullpath")));

prefix = utils.resolveArea(area, "prefix");

areas = accessUserData(model, "areas");
prefixes = utils.resolveArea(areas, "prefix");

modelAfter = model;
modelAfter.(prefix+"ss_roc_pch") = modelAfter.(prefix+"ss_roc_pch") + size;

modelAfter = steady( ...
    modelAfter ...
    , "fixLevel", ["gg_a", "gg_nt", prefixes+"pch"] ...
    , "blocks", false ...
);

checkSteady(modelAfter);

steadyTable = table( ...
    [model, modelAfter] ...
    , ["steadyLevel", "compareSteadyLevel", "steadyChange", "compareSteadyChange", "form", "description"] ...
    , "round", 8 ...
    , "writeTable", fullfile(thisDir, "area-monetary-neutrality-"+upper(area)+"-"+string(reportStamp)+".xlsx") ...
); 

end%

