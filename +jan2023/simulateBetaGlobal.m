%{

# Simulate a change in the discount factor in the 4A global economy

%}


    close all
    clear
    %#ok<*NOPTS> 

    try
        load("+model/+global4A/model.mat", "m4");
        m = m4;
    catch
        disp("Run model.global4A.create() first.");
        return
    end

    accessUserData(m, "areas")

    m1 = alter(m, 2);
    m1.cn_beta = [0.92, 0.90];
    m1 = steady(m1, "fixLevel", ["gg_a", "gg_nt", "us_pc", "ea_pc", "cn_pc", "rw_pc"]);
    checkSteady(m1);
    m1 = solve(m1);

    t = table( ...
        [m, m1], ["steadyLevel", "steadyChange", "form", "description"] ...
        , "writeTable", "+jan2023/beta-global4A.xlsx" ...
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
        m1, smc, [], -1:10, "Beta in 4A global", ["0.92", "0.90"], "+jan2023/beta-global4A" ...
    );

