function [s, smc] = areaTariffs(m, importer, exporter, range, size)

d = steadydb(m, range);

m0 = m;

if strlength(exporter)>0
    exporter = "_" + exporter;
end

m.(importer+"_ss_trm"+exporter) = m.(importer+"_ss_trm"+exporter) + size;

m = steady(m);
checkSteady(m);
m = solve(m);

s = simulate( ...
    m, d, range ...
    , "prependInput", true ...
    , "method", "stacked" ...
);

smc = databank.minusControl(m, s, d);

end%

