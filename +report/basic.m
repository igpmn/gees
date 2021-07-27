function basic(m, s, simulationRange, reportTitle, legends, fileName)

thisDir = string(fileparts(mfilename("fullpath")));

if dater.getFrequency(simulationRange(1))==0
    s = databank.redate(s, simulationRange(1), yy(1));
end

% Round all numbers to 8 decimals (for reporting only)
s = databank.apply(s, @(x) round(x, 8));

% Dates and ranges for charts and tables
numPeriods = numel(simulationRange);
startDate = yy(0);
endDate = startDate + numPeriods - 1;
tableDates = startDate : startDate+min(10, numPeriods);

legends = textual.stringify(legends);


% List of areas from model object
areas = accessUserData(m, "areas");

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
        , "DisplayRows", struct("Baseline", true, "Alternative", true, "Diff", true) ...
    };
end

table = rephrase.Table( ...
    "Summary table", tableDates ...
    , "DateFormat", "YY"  ...
    , "NumDecimals", 2 ...
    , extras{:} ...
);


%% Create grid of charts for global variables 

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
grid = rephrase.Grid(heading, numRows, numColumns, "DisplayTitle", true);

% Add dividing heading to table
table < rephrase.Heading(heading);

% Loop over time series 
for n = reshape(globalSeries, 1, [])
    series = s.(n);
    grid = locallySeriesToChart(grid, "", series, startDate, endDate, legends, func);
    table = locallySeriesToTable(table, "", series, legends, func);
end

report < grid;


%% Create grid of charts for each area 

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
    "mq"
    "^nfa_to_ngdp"
];


% Loop over areas
for a = reshape(areas, 1, [])

    heading = "Area " + upper(a);
    grid = rephrase.Grid(heading, numRows, numColumns, "DisplayTitle", true);
    table < rephrase.Heading(heading);

    % Loop over time series 
    for n = reshape(areaSeries, 1, [])
        thisFunc = func;
        name = n;
        if startsWith(n, "^")
            name = extractAfter(name, 1);
            thisFunc = altFunc;
        end
        name = utils.resolveArea(a, "prefix") + name;
        series = s.(name);
        grid = locallySeriesToChart(grid, upper(a), series, startDate, endDate, legends, thisFunc);
        table = locallySeriesToTable(table, "", series, legends, thisFunc);
    end

    report < grid;

end

%% Add table to report 

report < table;


%% Create HTML file 

build( ...
    report, fileName, [] ...
    , "source", "bundle" ...
    , "userStyle", fullfile(thisDir, "basic-extra.css") ...
);

end%

%
% Local functions
%

function grid = locallySeriesToChart(grid, area, series, startDate, endDate, legends, func)

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
    grid < rephrase.Chart.fromSeries( ...
        {title, startDate, endDate, "DateFormat", "YY"}, {legends, series} ...
    );

end%


function table = locallySeriesToTable(table, area, series, legends, func)

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
        table < rephrase.Series(title(1), series);
    elseif size(series, 2)==2
        table < rephrase.DiffSeries(title(1), series{:, 1}, series{:, 2});
    else
        table < rephrase.Series.fromMultivariate(title+legends, series);
    end

end%

