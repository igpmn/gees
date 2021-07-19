%% Permanent change in area price level 

function [t, m1] = run(m, area, size, reportStamp)

thisDir = string(fileparts(mfilename("fullpath")));

prefix = utils.resolveArea(area, "prefix");

areas = accessUserData(m, "areas");
prefixes = utils.resolveArea(areas, "prefix");

%
% Create model with a different level of price level in one area
%

m1 = m;
m1.(prefix+"pch") = m.(prefix+"pch") * (1 + size);

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
    , "writeTable", fullfile(thisDir, "area-price-level-"+upper(area)+"-"+string(reportStamp)+".xlsx") ...
); 

end%

