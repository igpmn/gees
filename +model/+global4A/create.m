%% Create global four-area (US, EA, CN, RW) economy model 

function [m4, t4] = create()

thisDir = string(fileparts(mfilename("fullpath")));

areas = ["us", "ea", "cn", "rw"];
numAreas = numel(areas);


%% Calibrate population in autarky templates 

ma = model.autarky.create();
ma4 = alter(ma, numAreas);

ma4.ss_nr = [0.331, 0.515, 1.439, NaN];
ma4.ss_nr(end) = 7.123 - nansum(ma4.ss_nr);

ma4 = steady( ...
    ma4 ...
    , "fix", ["gg_nt", "gg_a", "pch"] ...
    , "blocks", false ...
);

checkSteady(ma4);


%% Clone names in model files for each area 

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
    modelFiles(end+1) = ...
        clone(template, [n + "_", ""], "namesToKeep", globalNames); %#ok<SAGROW>
end


%% Add multi-area global equations and create model object 

modelFiles(end+1) = model.File("source/globals.model");
modelFiles(end+1) = model.File("source/wrapper-multiarea.model");
modelFiles(end+1) = model.File("source/commodity.model");
modelFiles(end+1) = model.File("source/trade.model");
modelFiles(end+1) = model.File("source/finance.model");

m4 = Model.fromFile( ...
    modelFiles ...
    , "growth", true ...
    , "assign", struct("areas", areas) ...
    , "comment", "Global four-area economy" ...
    , "savePreparsed", fullfile(thisDir, "preparsed.model") ...
);

m4 = assignUserData(m4, "areas", areas);


%% Reassign parameters from autarky 

% Reassign autarky parameters to each area
for i = 1 : numAreas
    a = areas(i);
    prefix = a + "_";
    suffix = "";
    m4 = assign(m4, ma4(i), @all, [prefix, suffix]);
end

% Reassign global parameters
m4 = assign(m4, ma, globalNames);


% Calibrate multi-area parameters and steady-state values

% Sum up global population and demand for commodities
m4.gg_nn = 0;
m4.gg_q = 0;
for n = areas
    m4.gg_nn = m4.gg_nn + real(m4.(n+"_nn"));
    m4.gg_q = m4.gg_q + real(m4.(n+"_mq"));
end
m4.gg_nn = m4.gg_nn + 1i*m4.gg_ss_roc_nt;
m4.gg_q = m4.gg_q + 1i*imag(ma.gg_q);
m4.gg_qq = m4.gg_q;


% Symmetric directions of trade
gg_nn = real(m4.gg_nn);
for n = areas
    n_nn = real(m4.(n+"_nn"));
    m4.(n+"_xi_mm") = 0.5;
    m4.(n+"_lambda") = n_nn / gg_nn;
    for x = setdiff(areas, n)
        x_nn = real(m4.(x+"_nn"));
        m4.(n+"_omega_"+x) = x_nn / (gg_nn - n_nn);
        m4.(n+"_mm_sh_"+x) = x_nn / (gg_nn - n_nn);
        m4.(n+"_ss_trm_"+x) = 0;
        m4.(n+"_rho_trm_"+x) = 0;
        m4.(n+"_trm_"+x) = 0;
    end
end

% Calibrate corporate equity exposures
own = 0.90;
for a = areas
    for b = areas
        n = a + "_phi_" + b;
        if a==b
            m4.(n) = own;
        else
            m4.(n) = (1 - own) / (numAreas-1);
        end
    end
end


m4 = steady( ...
    m4 ...
    , "fix", ["gg_nt", "gg_a", areas+"_pch"] ...
    , "blocks=", false ...
);

checkSteady(m4);


%% Calibrate labor market demography 

% Adapt WAP and labor market participation
m4.us_ss_nw_to_nn = 0.65;
m4.ea_ss_nw_to_nn = 0.64;
m4.cn_ss_nw_to_nn = 0.70;
m4.rw_ss_nw_to_nn = 0.64;

m4.us_ss_nf_to_nw = 0.73;
m4.ea_ss_nf_to_nw = 0.74;
m4.cn_ss_nf_to_nw = 0.76;
m4.rw_ss_nf_to_nw = 0.66; %0.93???


%% Calibrate distribution of commodity extraction 

m4.us_lambda = 0.20;
m4.ea_lambda = 0.05;
m4.cn_lambda = 0.30; %%%%%%%% FIXME
m4.rw_lambda = 1 - m4.us_lambda - m4.ea_lambda - m4.cn_lambda;

m4 = steady( ...
    m4 ...
    , "fixLevel", ["gg_nt", "gg_a", areas+"_pch"] ...
    , "blocks", false ...
);

checkSteady(m4);


%% Calibrate productivity differentials 

m4.ea_comp_ch_to_nn = 0.73;
m4.cn_comp_ch_to_nn = 0.40; %%%%% FIXME
m4.rw_comp_ch_to_nn = 0.32;

% m4 = steady( ...
    % m4 ...
    % , "fix", ["gg_nt", "gg_a", areas+"_pch"] ...
    % , "exogenize", ["ea", "cn", "rw"]+"_comp_ch_to_nn" ...
    % , "endogenize", ["ea", "cn", "rw"]+"_ss_ar" ...
    % , "blocks", false ...
% );
% 
% checkSteady(m4);

m4.us_nmm_to_ngdp = 0.15;
m4.ea_nmm_to_ngdp = 0.25;
m4.cn_nmm_to_ngdp = 0.18;

m4 = steady( ...
    m4 ...
    , "fix", ["gg_nt", "gg_a", areas+"_pch"] ...
    , "exogenize", [["ea", "cn", "rw"]+"_comp_ch_to_nn", ["us", "ea", "cn"]+"_nmm_to_ngdp"] ...
    , "endogenize", [["ea", "cn", "rw"]+"_ss_ar", ["us", "ea", "cn"]+"_gamma_m"] ...
    , "blocks", false ...
);

checkSteady(m4);


%% Calculate first order solution

m4 = solve(m4);


%% Report steady state table 

t4 = table( ...
    m4, ["steadyLevel", "description"] ...
    , "writeTable", fullfile(thisDir, "steady.xlsx") ...
);


%% Save model object to mat file 

save(fullfile(thisDir, "model.mat"), "m4", "t4");

end%

