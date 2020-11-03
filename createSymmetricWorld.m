
close all
clear

ma = loadFrom("mat/createAutarky.mat", "m");

sourceFiles = [
    "source/demography.model"
    "source/local.model"
    "source/open.model"
    "source/fiscal.model"
];

areas = ["us", "ea", "rw"];

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
mf(end+1) = model.File("source/wrapper-multiarea.model");
mf(end+1) = model.File("source/trade.model");

m = Model(mf, "assign", struct("open", true, "areas", areas));

for n = areas
    m = assign(m, ma, @all, [n + "_", ""]);
end

m = assign(m, ma, gg);
for n = areas
    for x = setdiff(areas, n)
        m.(n+"_omega_"+x) = 1/(numel(areas)-1);
        m.(n+"_xi_mm") = 0.5;
        % m.(n+"_mm_"+x) = m.(n+"_omega_"+x) * real(m.(n+"_mm"));
    end
end

m = steady(m, "fixLevel", ["gg_nn", "gg_a", areas+"_pch"]);
checkSteady(m);
m = solve(m);

m0 = m;

% m.us_beta = 0.93;
m.ea_pch = 1.10;

m = steady( ...
    m ...
    , "fixLevel", ["gg_a", "gg_nn", "us_pch", "ea_pch"] ...
    , "blocks", false ...
);

checkSteady(m);

m = solve(m);

