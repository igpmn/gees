function [t, m1] = monetaryNeutrality(m, area, size)

if strlength(area)>0
    area = area + "_";
else
    area = "";
end

m1 = m;
m1.(area+"ss_roc_pch") = m1.(area+"ss_roc_pch") + size;

m1 = steady( ...
    m1 ...
    ... , "fixLevel", ["gg_a", "gg_nn"] ...
    , "blocks", false ...
);

columns = [
    "steadyLevel"
    "compareSteadyLevel"
    "steadyChange"
    "compareSteadyChange"
];

t = table(m, columns);

end%

