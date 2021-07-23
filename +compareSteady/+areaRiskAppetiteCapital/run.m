%% Permanent change in area risk appetite for capital 

function [t, m1] = run(m, area, target, reportStamp)

thisDir = string(fileparts(mfilename("fullpath")));
prefix = utils.resolveArea(area, "prefix");
allAreas = accessUserData(m, "areas");
allPrefixes = utils.resolveArea(allAreas, "prefix");

%
% Create model with a different level of global population
%

m1 = m;
m1.(prefix+"ss_zk") = target;

m1 = steady( ...
    m1 ...
    , "fixLevel", ["gg_a", "gg_nt", allPrefixes+"pc"] ...
    , "blocks", false ...
);

checkSteady(m1);
m1 = solve(m1);


%
% Report steady state comparative static to table and spreadsheet
%

excelFileName = fullfile( ...
    thisDir ...
    , sprintf("area-risk-appetite-capital-%s-%s.xlsx", upper(area), reportStamp) ...
);

t = table( ...
    [m, m1] ...
    , ["steadyLevel", "compareSteadyLevel", "steadyChange", "compareSteadyChange", "form", "description"] ...
    , "round", 8 ...
    , "writeTable", excelFileName ...
); 

end%

