%% Permanent change in global risk appetite for capital 

function [s, smc, d, m1] = run(m, range, target, stamp)

thisDir = string(fileparts(mfilename("fullpath")));
allAreas = accessUserData(m, "areas");
allPrefixes = utils.resolveArea(allAreas, "prefix");

%
% Create model with a new level of risk appetite for capital
%

m1 = m;
m1.gg_ss_zk = target;
m1 = steady( ...
    m1 ...
    , "fix", ["gg_nt", "gg_a", allPrefixes+"pc"] ...
    , "blocks", false ...
);

checkSteady(m1);
m1 = solve(m1);

%
% Simulate dynamic response to a permanent change in risk appetite
%

d = steadydb(m, range(1)-1:range(end));
d0 = d;

s = simulate( ...
    m1, d, range ...
    , "prependInput", true ...
    , "method", "stacked" ...
    , "blocks", false ...
    , "startIter", "data" ...
);

s = postprocess(m, s, range(1)-1:range(end));

smc = databank.minusControl(m, s, d0);

%
% Generate HTML reports
%

reportTitle = "Permanent change in global risk appetite for capital";

legends = "Risk appetite " + string(target);

htmlFileName = fullfile( ...
    thisDir ...
    , sprintf("global-risk-appetite-capital-%s", stamp) ...
);

report.basic(m, smc, range, reportTitle, legends, htmlFileName);

end%

