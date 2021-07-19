function [s, smc, d, m1] = run(m, area, range, size, reportStamp)

thisDir = string(fileparts(mfilename("fullpath")));
prefix = utils.resolveArea(area, "prefix");

m1 = m;
d = steadydb(m, range);

%
% Create economy with higher debt
%
m1.(prefix+"ss_dg_to_ngdp") = m1.(prefix+"ss_dg_to_ngdp") + size;
m1.(prefix+"tau_cg") = 5;
m1.(prefix+"tau_trls1") = 0;

m1 = steady(m1 ...
    , "fixLevel", ["gg_a", "gg_nt", prefix+"pch"] ...
    , "blocks", false ...
);
checkSteady(m1);
m1 = solve(m1);

%
% Simulate government debt expansion from low to high
%
p = Plan.forModel(m1, range);
p = swap(p, range(1:2), [prefix+"trls1", prefix+"shk_trls1"]);

s = simulate( ...
    m1, d, range ...
    , "prependInput", true ...
    , "method", "stacked" ...
    , "plan", p ...
);

smc = databank.minusControl(m, s, "range", range);

%
% Generate HTML reports
%

reportTitle = "Area " + upper(area) + " government debt expansion simulation";
legend = string(100*size) + "%";

report.basic( ...
    m, smc, range, reportTitle, legend ...
    , fullfile(thisDir, "report-" + string(reportStamp)) ...
);

end%

