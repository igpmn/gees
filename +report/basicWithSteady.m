function basicWithSteady(model, simulationDb, steadyDb, range, reportTitle, legends, fileName)

%% List of global and are series to report

    globalSeries = [
        "gg_a"
        "gg_nt"
        "gg_nn"
        "gg_roc_gdp"
        "gg_roc_gdp_to_nn"
        "gg_pq_to_pxx"
        "gg_qq"
    ];

    areaSeries = [
        "ar"
        "roc_gdp"
        "ch"
        "ih"
        "cg"
        "^txls1_to_nc"
        "xx"
        "mm"
        "e"
        "pc"
        "roc_pc"
        "r"
        "pk"
        "u"
        "k"
        "mq"
        "dg_to_ngdp"
        "^nfa_to_ngdp"
    ];



%% Preparation

    thisDir = string(fileparts(mfilename("fullpath")));

    % Round all numbers to 8 decimals (for reporting only)
    simulationDb = databank.apply(simulationDb, @(x) round(x, 8));
    if ~isempty(steadyDb)
        steadyDb = databank.apply(steadyDb, @(x) round(x, 8));
    end

    % Dates and ranges for charts and tables
    numPeriods = numel(range);
    % startDate = yy(0);
    startDate = dater.plus(range(1), -1);
    endDate = startDate + numPeriods;
    tableDates = startDate : startDate+min(10, numPeriods);

    legends = textual.stringify(legends);


    % List of areas from model object
    areas = accessUserData(model, "areas");

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


%% Chart global variables 

    % Initialize grid element for global series
    heading = "Global";
    numRows = [];
    numColumns = 3;
    grid = rephrase.Grid(heading, numRows, numColumns, "ShowTitle", true);

    % Add dividing heading to table
    table + rephrase.Heading(heading);

    % Loop over time series 
    for n = reshape(globalSeries, 1, [])
        series = simulationDb.(n);
        if ~isempty(steadyDb)
            steadyLine = steadyDb.(n);
        end
        local_seriesToChart(grid, "", series, steadyLine, startDate, endDate, legends, func);
        local_seriesToTable(table, "", series, legends, func);
    end

    report + grid;


%% Chart each area

    pager = rephrase.Pager("");

    % Loop over areas
    for a = reshape(areas, 1, [])
        heading = "Area " + upper(a);
        grid = rephrase.Grid(heading, numRows, numColumns, "ShowTitle", true);
        table + rephrase.Heading(heading);
        % Loop over time series 
        for n = reshape(areaSeries, 1, [])
            thisFunc = func;
            name = n;
            if startsWith(n, "^")
                name = extractAfter(name, 1);
                thisFunc = altFunc;
            end
            name = utils.resolveArea(a, "prefix") + name;
            series = simulationDb.(name);
            if ~isempty(steadyDb)
                steadyLine = steadyDb.(name);
            end
            local_seriesToChart(grid, upper(a), series, steadyLine, startDate, endDate, legends, thisFunc);
            local_seriesToTable(table, "", series, legends, thisFunc);
        end
        pager + grid;
    end

    % Add charts with all areas together
    for column = 1 : numel(legends)
        heading = "All areas (" + legends(column) + ")";
        grid = rephrase.Grid(heading, numRows, numColumns, "ShowTitle", true);

        % Loop over time series 
        for n = reshape(areaSeries, 1, [])
            thisFunc = func;
            name = n;
            if startsWith(name, "^")
                name = extractAfter(name, 1);
                thisFunc = altFunc;
            end
            temp = comment(simulationDb.(areas(1)+"_"+name));
            series = databank.toSeries(simulationDb, areas+"_"+name, Inf, column);
            series = comment(series, temp);
            local_seriesToChart(grid, "", series, [], startDate, endDate, upper(areas), thisFunc);
        end
        pager + grid;
    end

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

function local_seriesToChart(grid, area, series, steadyLine, startDate, endDate, legends, func)
    % Create title from the time series comment
    title = comment(series);
    title = title(1);
    if strlength(area)>0
        title = area + " " + title;
    end

    % Apply transformation function
    if isa(func, 'function_handle')
        series = func(series);
        steadyLine = func(steadyLine);
    end

    % Create chart with series and steady lines and add it to grid
    chart = rephrase.SeriesChart(title, startDate:endDate, "dateFormat", "YY");
    chart + rephrase.Series.fromMultivariate(legends, series);
    if ~isempty(steadyLine)
        chart + rephrase.Series.fromMultivariate("Steady", steadyLine, "lineWidth", 0);
    end
    grid + chart;
end%


function local_seriesToTable(table, area, series, legends, func)
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

