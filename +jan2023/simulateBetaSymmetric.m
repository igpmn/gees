%{

# Simulate a change in the discount factor in the 2A symmetric economy

%}


    close all
    clear
    %#ok<*NOPTS> 

    try
        load("+model/+symmetric2A/model.mat", "m2");
        m = m2;
    catch
        disp("Run model.symmetric2A.create() first.");
        return
    end

    accessUserData(m, "areas")

    m1 = m;
    m1.us_beta = 0.97;

    m1 = steady(m1, "fixLevel", ["gg_a", "gg_nt", "us_pc", "ea_pc"]);
    checkSteady(m1);
    m1 = solve(m1);

    t = table( ...
        [m, m1], ["steadyLevel", "steadyChange", "form", "description"] ...
        , "writeTable", "+jan2023/beta-symmetric2A.xlsx" ...
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
        m1, smc, d1mc, -1:10, "Beta in 2A symmetric", [], "+jan2023/beta-symmetric2A" ...
    );

