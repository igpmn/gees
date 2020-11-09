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
numAreas = numel(areas);

template = model.File(sourceFiles);
template = preparse(template, "assign", struct("areas", areas));

gg = collectAllNames(template, @(x) startsWith(x, "gg_"));

modelFiles = model.File.empty(1, 0);
for n = areas
    modelFiles(end+1) = clone(template, [n + "_", ""], "namesToKeep", gg); %#ok<SAGROW>
end


%% Add Multi-Area Global Equations and Create Model Object

modelFiles(end+1) = model.File("source/globals.model");
modelFiles(end+1) = model.File("source/wrapper-multiarea.model");
modelFiles(end+1) = model.File("source/commodity.model");
modelFiles(end+1) = model.File("source/trade.model");

mw = Model( ...
    modelFiles ...
    , "growth", true ...
    , "assign", struct("areas", areas) ...
);

mw = assignUserData(mw, "areas", areas);


%% Reassign Parameters from Autarky

load mat/createAutarky.mat ma mas

% Area-specific parameters
for i = 1 : numAreas
    n = areas(i);
    mw = assign(mw, mas(i), @all, [n + "_", ""]);
end

% Global parameters
mw = assign(mw, ma, gg);


%% Calibrate Multi-Area Parameters

% Global population
mw.gg_nn = 0;
mw.gg_q = 0;
for n = areas
    mw.gg_nn = mw.gg_nn + real(mw.(n+"_nn"));
    mw.gg_q = mw.gg_q + real(mw.(n+"_q"));
end
mw.gg_nn = mw.gg_nn + 1i*mw.gg_ss_roc_nn;
mw.gg_q = mw.gg_q + 1i*imag(ma.gg_q);
mw.gg_qq = mw.gg_q;


% Directions of trade
for i = 1 : numAreas
    n = areas(i);
    shn = real(mw.(n+"_nn")) / real(mw.gg_nn);
    mw.(n+"_xi_mm") = 0.5;
    mw.(n+"_lambda") = shn;
    for j = 1 : numAreas
        x = areas(j);
        shx = real(mw.(x+"_nn")) / real(mw.gg_nn);
        mw.(n+"_omega_"+x) = shx;
        mw.(n+"_mm_"+x) = real(mas(i).mm) * shx + 1i*imag(ma.mm);
        mw.(n+"_ss_trm_"+x) = 0;
        mw.(n+"_rho_trm_"+x) = 0;
    end
end


%% Calculate Steady State and First Order Solution

[~, list] = isnan(mw, "steady");
mw = steady( ...
    mw ...
    , "fix", Except(list) ...
    , "blocks", false ...
);

checkSteady(mw);

%% Labor Market Demography

% Adapt WAP and labor market participation
mw.us_ss_nw_to_nn = 0.65;
mw.ea_ss_nw_to_nn = 0.64;
mw.rw_ss_nw_to_nn = 0.68;

mw.us_ss_nf_to_nw = 0.72;
mw.ea_ss_nf_to_nw = 0.74;
mw.rw_ss_nf_to_nw = 0.66;

mw = steady( ...
    mw ...
    , "fixLevel", ["gg_nt", "gg_a", areas+"_pch"] ...
    , "blocks", false ...
);

% Distribute commodity output across areas
mw.us_lambda = 0.20;
mw.ea_lambda = 0.05;
mw.rw_lambda = 0.75;


mw = steady( ...
    mw ...
    , "fixLevel", ["gg_nt", "gg_a", areas+"_pch"] ...
    , "blocks", false ...
);


t = table( ...
    mw, ["steadyLevel", "description"] ...
    , "writeTable", "tables/createSymmetricWorldAfterOil.xlsx" ...
);


% Create productivity differentials

mw.calib_y_pw_rw_us = 0.32;
mw.calib_y_pw_ea_us = 0.73;


mw = steady( ...
    mw ...
    , "fixLevel", ["gg_nt", "gg_a", areas+"_pch"] ...
    , "exogenize", ["calib_y_pw_rw_us", "calib_y_pw_ea_us"] ...
    , "endogenize", ["rw_ss_ar", "ea_ss_ar"] ...
    , "blocks", false ...
);

mw = solve(mw);


%% Save Model Object to MAT File

save mat/createSymmetricWorld.mat mw

