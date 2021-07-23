%% Permanent change in government debt in all areas 

function [t, m1] = run(m, size, reportStamp)

thisDir = string(fileparts(mfilename("fullpath")));
areas = accessUserData(m, "areas");
prefixes = utils.resolveArea(areas, "prefix");

%
% Create model with a different level of government debt in all areas
%

m1 = m;
for a = prefixes
    m1.(a+"ss_dg_to_ngdp") = m.(a+"ss_dg_to_ngdp") + size;
end

m1 = steady( ...
    m1 ...
    , "fixLevel", ["gg_a", "gg_nt", prefixes+"pc"] ...
    , "blocks", false ...
);

checkSteady(m1);

excelFileName = fullfile(thisDir, "global-govt-debt-"+string(reportStamp)+".xlsx");

t = table( ...
    [m, m1] ...
    , ["steadyLevel", "compareSteadyLevel", "steadyChange", "compareSteadyChange", "form", "description"] ...
    , "round", 8 ...
    , "writeTable", excelFileName ...
); 

end%

