%{

# Simulate a change in the discount factor in the autarky economyu

%}


    close all
    clear

    try
        load("+model/+autarky/model.mat", "ma");
        m = ma;
    catch
        disp("Run model.autarky.create() first.");
        return
    end

    m1 = m;
    m1.beta = 0.97;

    m1 = steady(m1, "fixLevel", ["gg_a", "gg_nt", "pc"]);
    checkSteady(m1);
    m1 = solve(m1);

    t = table( ...
        [m, m1], ["steadyLevel", "steadyChange", "form", "description"] ...
        , "writeTable", "+jan2023/beta-autarky.xlsx" ...
    )

    d = databank.forModel(m, 1:10);
    d1 = databank.forModel(m1, 1:10);

    s = simulate( ...
        m1, d, 1:10 ...
        , "method", "stacked" ...
        , "prependInput", true ...
    );

    smc = databank.minusControl(m1, s, d);
    d1mc = databank.minusControl(m1, d1, d);

    report.basicWithSteady( ...
        m1, smc, d1mc, -1:10, "Beta in Autarky", [], "+jan2023/beta-autarky" ...
    );


