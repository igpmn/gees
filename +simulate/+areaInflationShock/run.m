%% Simulate temporary inflation shock 

function [s, smc, d, modelAfter] = areaInflationShock(model, area, range, size, htmlFileName)

    %htmlFileNameTemplate = "area-inflation-shock-$(area)-$(stamp)";
    reportTitleTemplate = "Area $(area) inflation shock";
    legend = upper(area) + "@" + string(100*size) + "%";

    thisDir = string(fileparts(mfilename("fullpath")));
    areaPrefix = utils.resolveArea(area, "prefix");
    allAreas = accessUserData(model, "areas");
    allPrefixes = utils.resolveArea(allAreas, "prefix");


    %
    % Create initial steady state databank
    %

    steadyDb = databank.forModel(model, range);


    %
    % Create an economy with a new level of govt debt
    %

    modelAfter = model;


    %
    % Simulate shock
    %

    d = steadyDb;
    d.(areaPrefix+"shk_py")(range(1)) = size;

    s = simulate( ...
        modelAfter, d, range ...
        , "prependInput", true ...
        , "method", "stacked" ...
    );

    smc = databank.minusControl(model, s, steadyDb, "range", range);
    zeroDb = databank.forModel(model, range, "deviation", true);


    %
    % Generate HTML reports
    %

    reportTitle = reportTitleTemplate;
    reportTitle = replace(reportTitle, "$(area)", upper(area));

    % htmlFileName = htmlFileNameTemplate;
    htmlFileName = replace(htmlFileName, "$(area)", upper(area));
    % htmlFileName = replace(htmlFileName, "$(stamp)", stamp);
    % htmlFileName = fullfile(thisDir, htmlFileName);

    report.basicWithSteady(model, smc, zeroDb, range, reportTitle, legend, htmlFileName);

end%

