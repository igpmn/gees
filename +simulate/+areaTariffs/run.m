function [s, smc, d, modelAfter] = run(model, importer, exporter, range, size)

areas = accessUserData(model, "areas");
prefixes = utils.resolveArea(areas, "prefix");

d = steadydb(model, range);

exporter = utils.resolveArea(exporter, "suffix");
importer = utils.resolveArea(importer, "prefix");

modelAfter = model;
modelAfter.(importer+"ss_trm"+exporter) = modelAfter.(importer+"ss_trm"+exporter) + size;

modelAfter = steady( ...
	modelAfter ...
    , "fixLevel", ["gg_a", "gg_nt", prefixes+"pch"] ...
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

end%

