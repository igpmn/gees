function [s, smc, d, modelAfter] = run(model, area, range, size, stamp)

d = steadydb(model, range);

prefix = utils.resolveArea(area, "prefix");
areas = accessUserData(model, "areas");
prefixes = utils.resolveArea(areas, "prefix");

modelAfter = model;
modelAfter.(prefix+"_ss_ar") = modelAfter.(prefix+"_ss_ar") * (1 + size);

modelAfter = steady( ...
    modelAfter ...
    , "fixLevel", ["gg_a", "gg_nt", prefixes+"pc"] ...
    , "blocks", false ...
);

checkSteady(modelAfter);
modelAfter = solve(modelAfter);

s = simulate( ...
    modelAfter, d, range ...
    , "prependInput", true ...
    , "method", "stacked" ...
    , "blocks", false ...
);

smc = databank.minusControl(modelAfter, s, d);

reportTitle = "Area specific productivity simulation";
legend = string(size*100)+"% in "+upper(area);
htmlFileName = sprintf("area-productivity-%s-%s", upper(area), string(stamp));

report.basic(m, smc, range, reportTitle, legend, htmlFileName);

end%

