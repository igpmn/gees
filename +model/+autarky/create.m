%% Create single-area autarky economy 

function [ma, ta] = create()

    thisDir = string(fileparts(mfilename("fullpath")));

    %% Create model object 

    sourceFiles = [
        "model-source/demography.md"
        "model-source/households.md"
        "model-source/production.md"
        "model-source/monetary.md"
        "model-source/fiscal.md"
        "model-source/open.md"
        "model-source/commodity.md"
        "model-source/globals.md"
        "model-source/wrapper-autarky.md"
    ];

    ma = Model.fromFile( ...
        sourceFiles ...
        , "growth", true ...
        , "comment", "Autarky economy" ...
        , "savePreparsed", fullfile(thisDir, "preparsed.md") ...
    );

    ma = assignUserData(ma, "areas", "");


    %% Calibrate parameters 

    % Global parameters
    ma = calibrate.baselineGlobal(ma);

    % Area specific parameters
    ma = calibrate.baselineArea(ma);


    %% Calculate steady state 

    % Anchor the level of three independent stochastic trends

    ma.gg_a = 1;
    ma.gg_nt = 1;
    ma.pc = 1;


    % Initialize some values to help numerical convergence

    ma.r = 1.05;
    ma.nch_to_netw_minus_nu_0 = 0;
    ma.upsilon_1_py_to_pu = 1;
    ma.nh = 1;

    homotopy = [
        struct('gg_nt', 0.5), ...
        struct('gg_nt', ma.gg_nt), ...
    ];

    ma.eta = 0.5;

    for h = homotopy
        ma = assign(ma, h);

        ma = steady(ma ...
            , "fixLevel", ["gg_a", "gg_nt", "pc"] ...
            , "exogenize", ["nh", "r", "nch_to_netw_minus_nu_0", "upsilon_1_py_to_pu"] ...
            , "endogenize", ["eta0", "gg_nu", "nu_0", "upsilon_0"] ...
            , "blocks", false ...
        );
    end

    checkSteady(ma);


    %% Calculate first order solution

    ma = solve(ma);


    %% Report steady state

    ta = table( ...
        ma, ["steadyLevel", "steadyChange", "form", "description"] ...
        , "writeTable", fullfile(thisDir, "steady.xlsx") ...
    );


    %% Save model object to mat file

    save(fullfile(thisDir, "model.mat"), "ma", "ta");

end%

