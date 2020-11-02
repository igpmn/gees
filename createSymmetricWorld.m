
close all
clear

ma = loadFrom("mat/createAutonomous.mat", "m");

sourceFiles = [
    "source/real.model"
    "source/export.model"
    "source/fiscal.model"
    "source/demography.model"
    "source/bop.model"
];

areas = ["us", "ea"];

template = model.File(sourceFiles);

gg = collectAllNames(template, @(x) startsWith(x, "gg_"));
keep = ["open", gg];

mf = model.File.empty(1, 0);
for n = areas
    mf(end+1) = clone(template, [n + "_", ""], "namesToKeep", keep); %#ok<SAGROW>
end

%
% Add the wrapper module
%
mf(end+1) = model.File("source/globals.model");
mf(end+1) = model.File("source/world.model");

m = Model(mf, "assign", struct("open", true, "areas", areas));

for n = areas
    m = assign(m, ma, @all, [n + "_", ""]);
end

m = assign(m, ma, gg);

checkSteady(m);

m0 = m;

m.us_beta = 0.93;

m = steady( ...
    m ...
    , "fixLevel", ["gg_a", "gg_nn", "us_pch", "ea_pch"] ...
    , "blocks", false ...
);

checkSteady(m);

m = solve(m);



