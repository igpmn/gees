%% Permanent change in global productivity 

function [s, smc, d, m1] = run(m, range, size, reportStamp)

thisDir = string(fileparts(mfilename("fullpath")));
size = log(1 + size);

%
% Create model with a higher level of productivity
%

m1 = m;
m1.gg_a = complex( real(m1.gg_a)*exp(size), imag(m1.gg_a) );
areas = accessUserData(m1, "areas");
areas = utils.resolveArea(areas, "prefix");
m1 = steady( ...
    m1 ...
    , "fix", ["gg_nt", "gg_a", areas+"pch"] ...
    , "blocks", false ...
);
checkSteady(m1);
m1 = solve(m1);

%
% Simulate dynamic response to productivity shock, 3 variants:
% * Unanticipated
% * Anticipated
% * Half-anticipated
%

d = steadydb(m, range(1)-1:range(end), "numColumns", 3);
d0 = d;
d.gg_shk_a(range(2), :) = [1i*size, size, (0.5+0.5i)*size];

s = simulate( ...
    m, d, range ...
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

reportTitle = "Global productivity simulation";

% Unanticipated vs anticipated
smc12 = databank.retrieveColumns(smc, 1:2);
legends12 = ["Unanticipated", "Anticipated"];
report.basic( ...
    m, smc12, range, reportTitle, legends12 ...
    , fullfile(thisDir, "global-productivity-unanticipated-anticipated-" + string(reportStamp)) ...
);

% Anticipated vs half-anticipated
smc23 = databank.retrieveColumns(smc, 2:3);
legends23 = ["Anticipated", "Half-anticipated"];
report.basic( ...
    m, smc23, range, reportTitle, legends23 ...
    , fullfile(thisDir, "global-productivity-anticipated-halfanticipated-" + string(reportStamp)) ...
);

end%

