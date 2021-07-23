%% Permanent change in global population 

function [t, m1] = run(m, size, reportStamp)

thisDir = string(fileparts(mfilename("fullpath")));
areas = accessUserData(m, "areas");
prefix = utils.resolveArea(areas, "prefix");

%
% Create model with a different level of global population
%

m1 = m;
m1.gg_nt = m.gg_nt * (1 + size);

m1 = steady( ...
    m1 ...
    , "fixLevel", ["gg_a", "gg_nt", prefix+"pc"] ...
    , "blocks", false ...
);

checkSteady(m1);

%
% Report steady state comparative static to table and spreadsheet
%

excelFileName = fullfile( ...
    thisDir ...
    , sprintf("global-population-%s.xlsx", reportStamp) ...
);

t = table( ...
    [m, m1] ...
    , ["steadyLevel", "compareSteadyLevel", "steadyChange", "compareSteadyChange", "form", "description"] ...
    , "round", 8 ...
    , "writeTable", excelFileName ...
); 

end%

