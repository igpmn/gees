%% Create Multi-Area Model

close all
clear


%% Clone Model Files from Autarky

sourceFiles = [
    "source/demography.model"
    "source/local.model"
    "source/open.model"
    "source/fiscal.model"
];

areas = ["us", "ea", "rw"];

template = model.File(sourceFiles);

gg = collectAllNames(template, @(x) startsWith(x, "gg_"));

modelFiles = model.File.empty(1, 0);
for n = areas
    modelFiles(end+1) = clone(template, [n + "_", ""], "namesToKeep", gg); %#ok<SAGROW>
end


%% Add Multi-Area Global Equations and Create Model Object

modelFiles(end+1) = model.File("source/globals.model");
modelFiles(end+1) = model.File("source/wrapper-multiarea.model");
modelFiles(end+1) = model.File("source/trade.model");

multiModel = Model(modelFiles, "assign", struct("areas", areas));


%% Reassign Parameters from Autarky

load mat/createAutarky.mat autarkyModel

% Area-specific parameters
for n = areas
    multiModel = assign(multiModel, autarkyModel, @all, [n + "_", ""]);
end

% Global parameters
multiModel = assign(multiModel, autarkyModel, gg);


%% Calibrate Multi-Area Parameters

for n = areas
    for x = setdiff(areas, n)
        multiModel.(n+"_omega_"+x) = 1/(numel(areas)-1);
        multiModel.(n+"_xi_mm") = 0.5;
    end
end


%% Calculate Steady State and First Order Solution

multiModel = steady( ...
    multiModel ...
    , "fixLevel", ["gg_nn", "gg_a", areas+"_y", areas+"_pch"] ...
    , "blocks", false ...
);

checkSteady(multiModel);


% Run postprocessor on steady state values

s = get(multiModel, "steady");
s = postprocess(multiModel, s, "steady");


% Report steady state

table( ...
    multiModel, ["steadyLevel", "steadyChange", "form", "description"] ...
    , "writeTable", "tables/createSymmetricWorld.xlsx" ...
);

multiModel = solve(multiModel)


%% Save Model Object to MAT File

save mat/createSymmetricWorld.mat multiModel

