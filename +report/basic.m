function basic(m, s, simulationRange, reportTitle, legends, fileName)

%% Preparation

    thisDir = string(fileparts(mfilename("fullpath")));

    % Round all numbers to 8 decimals (for reporting only)
    s = databank.apply(s, @(x) round(x, 8));

    % Dates and ranges for charts and tables
    firstSimulationDate = simulationRange(1);
    numPeriods = numel(simulationRange);
    startDate = firstSimulationDate - 1;
    endDate = startDate + numPeriods - 1;
    tableDates = startDate : startDate+min(10, numPeriods);

    legends = textual.stringify(legends);


    % List of areas from model object
    areas = accessUserData(m, "areas");
    fullAreaNames = accessUserData(m, "fullAreaNames");

    % Transformation function
    func = @(x) 100*(x - 1);
    altFunc = @(x) 100*x;


%% Start report object

    report = rephrase.Report(reportTitle);


    % Initialize table element
    extras = cell.empty(1, 0);
    if numel(legends)==2
        extras = { ...
            "RowTitles", struct("Baseline", legends(1), "Alternative", legends(2), "Diff", "Diff") ...
            , "ShowRows", struct("Baseline", true, "Alternative", true, "Diff", true) ...
        };
    end

    table = rephrase.Table( ...
        "Summary table", tableDates ...
        , "DateFormat", "YY"  ...
        , "NumDecimals", 2 ...
        , extras{:} ...
    );


%% Create pager

    pager = rephrase.Pager("");


%% Chart global variables

    globalSeries = [
        "gg_a"
        "gg_nt"
        "gg_nn"
        "gg_roc_gdp"
        "gg_roc_gdp_to_nn"
        "gg_pq_to_pxx"
        "gg_qq"
    ];

    % Initialize grid element for global series
    heading = "Global";
    numRows = [];
    numColumns = 3;
    section = rephrase.Section(heading);
    grid = rephrase.Grid("", numRows, numColumns, "ShowTitle", true);
    table + rephrase.Heading(heading);

    % Loop over time series
    for n = reshape(globalSeries, 1, [])
        series = s.(n);
        [grid, chart] = local_seriesToChart(grid, "", series, startDate, endDate, legends, func);
        table = local_seriesToTable(table, "", series, legends, func);
    end

    section + grid;
    pager + section;


%% Chart each area

    areaSeries = [
        "ar"
        "roc_gdp"
        "ch"
        "ih"
        "cg"
        "^txls1_to_nc"
        "xx"
        "mm"
        "roc_pc"
        "r"
        "pk"
        "u"
        "k"
        "nh"
        "nf"
        "mq"
        "^nfa_to_ngdp"
        "^dg_to_ngdp"
    ];


    % Loop over areas
    for a = [areas; fullAreaNames]

        heading = a(2) + " [" + upper(a(1)) + "]";
        section = rephrase.Section(heading);
        grid = rephrase.Grid("", numRows, numColumns, "ShowTitle", true);
        table + rephrase.Heading(heading);

        % Loop over time series
        for n = reshape(areaSeries, 1, [])
            thisFunc = func;
            name = n;
            if startsWith(n, "^")
                name = extractAfter(name, 1);
                thisFunc = altFunc;
            end
            series = s.(a(1) + "_" + name);
            grid = local_seriesToChart(grid, upper(a(1)), series, startDate, endDate, legends, thisFunc);
            table = local_seriesToTable(table, "", series, legends, thisFunc);
        end

        section + grid;
        pager + section;

    end

    % Add table to report

    report + pager;
    report + table;


%% Create HTML report

    build( ...
        report, fileName, [] ...
        , "source", "web" ...
        , "userStyle", fullfile(thisDir, "basic-extra.css") ...
    );

end%

%
% Local functions
%

function [grid, chart] = local_seriesToChart(grid, area, series, startDate, endDate, legends, func)

    % Create title from the time series comment
    title = comment(series);
    title = title(1);
    if strlength(area)>0
        title = area + " " + title;
    end

    % Apply transformation function
    if isa(func, 'function_handle')
        series = func(series);
    end

    % Create chart and add it to grid
    chart = rephrase.Chart.fromSeries( ...
        {title, startDate, endDate, "DateFormat", "YYYY"}, {legends, series} ...
    );

    grid = grid + chart;
end%


function table = local_seriesToTable(table, area, series, legends, func)

    % Create title from the time series comment
    title = comment(series);
    if strlength(area)>0
        title = area + " " + title;
    end

    % Apply transformation function
    if isa(func, 'function_handle')
        series = func(series);
    end

    if size(series, 2)==1
        table + rephrase.Series(title(1), round(series, 5));
    elseif size(series, 2)==2
        table + rephrase.DiffSeries(title(1), series{:, 1}, series{:, 2});
    else
        table + rephrase.Series.fromMultivariate(title+legends, series);
    end

end%

