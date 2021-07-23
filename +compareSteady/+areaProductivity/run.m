%% Permanent change in area productivity 

function [t, m1] = run(m, area, size, reportStamp)

thisDir = string(fileparts(mfilename("fullpath")));
prefix = utils.resolveArea(area, "prefix");
allAreas = accessUserData(m, "areas");
allPrefixes = utils.resolveArea(allAreas, "prefix");


%
% Create model with a different level of area productivity
%

m1 = m;

m1.(prefix+"ss_ar") = m1.(prefix+"ss_ar") * (1 + size);

m1 = steady( ...
    m1 ...
    , "fixLevel", ["gg_a", "gg_nt", allPrefixes+"pc"] ...
    , "blocks", false ...
);

checkSteady(m1);

t = table( ...
    [m, m1] ...
    , ["steadyLevel", "compareSteadyLevel", "steadyChange", "compareSteadyChange", "form", "description"] ...
    , "round", 8 ...
    , "writeTable", fullfile(thisDir, "area-productivity-"+upper(area)+"-"+string(reportStamp)+".xlsx") ...
); 

end%

