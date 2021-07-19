%% Verify monetary neutrality 

function [t, m1] = run(m, area, size, reportStamp)

thisDir = string(fileparts(mfilename("fullpath")));

prefix = utils.resolveArea(area, "prefix");

areas = accessUserData(m, "areas");
prefixes = utils.resolveArea(areas, "prefix");

m1 = m;
m1.(prefix+"ss_roc_pch") = m1.(prefix+"ss_roc_pch") + size;

m1 = steady( ...
    m1 ...
    , "fixLevel", ["gg_a", "gg_nt", prefixes+"pch"] ...
    , "blocks", false ...
);

checkSteady(m1);

t = table( ...
    [m, m1] ...
    , ["steadyLevel", "compareSteadyLevel", "steadyChange", "compareSteadyChange", "form", "description"] ...
    , "round", 8 ...
    , "writeTable", fullfile(thisDir, "area-monetary-neutrality-"+upper(area)+"-"+string(reportStamp)+".xlsx") ...
); 

end%

