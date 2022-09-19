function printParameters(model, folder)

    areaFileName = fullfile(folder, "calibration-area.md");
    globalFileName = fullfile(folder, "calibration-global.md");

    math = [
        "$$"
        "\newcommand{\ss}{\mathrm{ss}}"
        "\newcommand{\gg}{\mathrm{gg}}"
        "\newcommand{\tratio}[2]{\left[{#1}\,\middle/{#2}\right]}"
        "\newcommand{\roc}[1]{\overset{\scriptsize\Delta}{#1{}}}"
        "$$"
        "{ .math-definitions }"
        ""
    ];

    textual.write([
        "# Baseline calibration of area parameters"
        ""
        math
        ""
    ], areaFileName);

    list = [
        "Demography", ":demography"
        "Households", ":households"
        "Local supply side", ":production"
        "Monetary policy", ":monetary"
        "Fiscal policy", ":fiscal"
        "Open economy", ":open"
        "Trade linkages", ":trade"
        "Finance linkages", ":finance"
    ];

    for n = transpose(list)

        select = byAttributes(model, n(2), ":steady");
        select(~startsWith(select, "aa_")) = [];
        t = table( ...
            model, ["alias", "steadyLevel", "description"] ...
            , selectRows=select ...
            , title="## "+n(1)+": Steady-state parameters" ...
        );
        t.Properties.VariableNames = ["Math", "Value", "Description"];
        t.Properties.RowNames = extractAfter(t.Properties.RowNames, "aa_");
        mdown.fromTable(t, appendTo=areaFileName);

        select = byAttributes(model, n(2), ":dynamic");
        select(~startsWith(select, "aa_")) = [];
        t = table( ...
            model, ["alias", "steadyLevel", "description"] ...
            , selectRows=select ...
            , title="## "+n(1)+": Dynamic parameters" ...
        );
        t.Properties.VariableNames = ["Math", "Value", "Description"];
        t.Properties.RowNames = extractAfter(t.Properties.RowNames, "aa_");
        mdown.fromTable(t, appendTo=areaFileName);
    end




    textual.write([
        "# Baseline calibration of global parameters"
        ""
        math
        ""
    ], globalFileName);


    t = table( ...
        model, ["alias", "steadyLevel", "description"] ...
        , selectRows=byAttributes(model, ":global", ":steady") ...
        , title="## Global trends: Steady-state parameters" ...
    );
    t.Properties.VariableNames = ["Math", "Value", "Description"];
    mdown.fromTable(t, appendTo=globalFileName);

    t = table( ...
        model, ["alias", "steadyLevel", "description"] ...
        , selectRows=byAttributes(model, ":global", ":dynamic") ...
        , title="## Global trends: Dynamic parameters" ...
    );
    t.Properties.VariableNames = ["Math", "Value", "Description"];
    mdown.fromTable(t, appendTo=globalFileName);

%     t = table( ...
%         model, ["alias", "steadyLevel", "description"] ...
%         , selectRows=byAttributes(model, ":commodity", ":steady") ...
%         , title="## Global commodity supply: Steady-state parameters" ...
%     );
%     t.Properties.VariableNames = ["Math", "Value", "Description"];
%     mdown.fromTable(t, appendTo=globalFileName);

    t = table( ...
        model, ["alias", "steadyLevel", "description"] ...
        , selectRows=byAttributes(model, ":commodity", ":dynamic") ...
        , title="## Global commodity supply: Dynamic parameters" ...
    );
    t.Properties.VariableNames = ["Math", "Value", "Description"];
    mdown.fromTable(t, appendTo=globalFileName);


end%

