%% Permanent change in global risk appetite for capital 

function [t, m1] = run(m, target, reportStamp)

thisDir = string(fileparts(mfilename("fullpath")));
areas = accessUserData(m, "areas");
prefix = utils.resolveArea(areas, "prefix");

%
% Create model with a different level of global population
%

m1 = m;
m1.gg_ss_zk = target;

m1 = steady( ...
    m1 ...
    , "fixLevel", ["gg_a", "gg_nt", prefix+"pc"] ...
    , "blocks", false ...
);

checkSteady(m1);
m1 = solve(m1);


%
% Report steady state comparative static to table and spreadsheet
%

excelFileName = fullfile( ...
    thisDir ...
    , sprintf("global-risk-appetite-capital-%s.xlsx", reportStamp) ...
);

t = table( ...
    [m, m1] ...
    , ["steadyLevel", "compareSteadyLevel", "steadyChange", "compareSteadyChange", "form", "description"] ...
    , "round", 8 ...
    , "writeTable", excelFileName ...
); 

end%

