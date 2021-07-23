%% Permanent change in global productivity 

function [t, m1] = run(m, size, reportStamp)

thisDir = string(fileparts(mfilename("fullpath")));
areas = accessUserData(m, "areas");
prefix = utils.resolveArea(areas, "prefix");

%
% Create model with a different level of global productivity
%

m1 = m;

% m1.gg_a = m.gg_a * (1 + size);
m1.gg_a = real(m.gg_a)*(1 + size) + 1i*imag(m.gg_a);

m1 = steady( ...
    m1 ...
    , "fixLevel", ["gg_a", "gg_nt", prefix+"pc"] ...
    , "blocks", false ...
);

checkSteady(m1);

t = table( ...
    [m, m1] ...
    , ["steadyLevel", "compareSteadyLevel", "steadyChange", "compareSteadyChange", "form", "description"] ...
    , "round", 8 ...
    , "writeTable", fullfile(thisDir, "global-productivity-"+string(reportStamp)+".xlsx") ...
); 

end%

