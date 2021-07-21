%% Create symmetric two-area economy model 

function [m2, t2] = create()

thisDir = string(fileparts(mfilename("fullpath")));

ma = model.autarky.create();

areas = ["aa", "bb"];
numAreas = numel(areas);


%% Clone model files from autarky 

sourceFiles = [
    "source/demography.model"
    "source/local.model"
    "source/open.model"
    "source/fiscal.model"
];

template = model.File(sourceFiles);
template = preparse(template, "assign", struct("areas", areas));

globalNames = collectAllNames(template, @(x) startsWith(x, "gg_"));

modelFiles = model.File.empty(1, 0);
for n = areas
    modelFiles(end+1) = clone(template, [n + "_", ""], "namesToKeep", globalNames); %#ok<SAGROW>
end


%% Add multi-area global equations and create model object 

modelFiles(end+1) = model.File("source/globals.model");
modelFiles(end+1) = model.File("source/wrapper-multiarea.model");
modelFiles(end+1) = model.File("source/commodity.model");
modelFiles(end+1) = model.File("source/trade.model");
modelFiles(end+1) = model.File("source/finance.model");

m2 = Model.fromFile( ...
    modelFiles ...
    , "growth", true ...
    , "assign", struct("areas", areas) ...
    , "comment", "Symmetric two-area economy" ...
    , "savePreparsed", fullfile(thisDir, "preparsed.model") ...
);

m2 = assignUserData(m2, "areas", areas);


%% Reassign Parameters from Autarky

% Reassign autarky parameters to each area
for i = 1 : numAreas
    a = areas(i);
    prefix = a + "_";
    suffix = "";
    m2 = assign(m2, ma, @all, [prefix, suffix]);
end

% Global parameters
m2 = assign(m2, ma, globalNames);


%% Calibrate symmetric two-area parameters 

% Sum up global population and demand for commodities
m2.gg_nn = 0;
m2.gg_q = 0;
for n = areas
    m2.gg_nn = m2.gg_nn + real(m2.(n+"_nn"));
    m2.gg_q = m2.gg_q + real(m2.(n+"_mq"));
end
m2.gg_nn = m2.gg_nn + 1i*m2.gg_ss_roc_nt;
m2.gg_q = m2.gg_q + 1i*imag(ma.gg_q);
m2.gg_qq = m2.gg_q;


% Symmetric directions of trade
gg_nn = real(m2.gg_nn);
for n = areas
    n_nn = real(m2.(n+"_nn"));
    m2.(n+"_xi_mm") = 0.5;
    m2.(n+"_lambda") = n_nn / gg_nn;
    for x = setdiff(areas, n)
        x_nn = real(m2.(x+"_nn"));
        m2.(n+"_omega_"+x) = x_nn / (gg_nn - n_nn);
        m2.(n+"_mm_sh_"+x) = x_nn / (gg_nn - n_nn);
        m2.(n+"_ss_trm_"+x) = 0;
        m2.(n+"_rho_trm_"+x) = 0;
        m2.(n+"_trm_"+x) = 0;
    end
end

% Corporate equity exposures
own = 0.90;
for a = areas
    for b = areas
        n = a + "_phi_" + b;
        if a==b
            m2.(n) = own;
        else
            m2.(n) = (1 - own) / (numAreas-1);
        end
    end
end


%% Calculate steady state and first order solution 

m2 = steady( ...
    m2 ...
    , "fix", ["gg_nt", "gg_a", areas+"_pch"] ...
    , "blocks", false ...
);

checkSteady(m2);


%% Calculate first order solution 

m2 = solve(m2);


%% Report steady state table 

t2 = table( ...
    m2, ["steadyLevel", "steadyChange", "form", "description"] ...
    , "writeTable", fullfile(thisDir, "steady.xlsx") ...
);


%% Save model object to mat file 

save(fullfile(thisDir, "model.mat"), "m2", "t2");

end%

