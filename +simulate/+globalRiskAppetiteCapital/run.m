%% Permanent change in global risk appetite for capital 

function [s, smc, d, modelAfter] = run(model, range, target, stamp)

htmlFileNameTemplate = "global-risk-appetite-$(stamp)";
reportTitleTemplate = "Global change in risk appetite for capital";
legend = string(target);

area = "";
thisDir = string(fileparts(mfilename("fullpath")));
allAreas = accessUserData(model, "areas");
allPrefixes = utils.resolveArea(allAreas, "prefix");


%
% Create initial steady state databank
%

d = steadydb(model, range);


%
% Create model with a new level of risk appetite for capital
%

modelAfter = model;
modelAfter.gg_ss_zk = target;

modelAfter = steady( ...
    modelAfter ...
    , "fix", ["gg_nt", "gg_a", allPrefixes+"pc"] ...
    , "blocks", false ...
);

checkSteady(modelAfter);
modelAfter = solve(modelAfter);


%
% Simulate dynamic response to a permanent change in risk appetite
%

d0 = d;

s = simulate( ...
    modelAfter, d, range ...
    , "prependInput", true ...
    , "method", "stacked" ...
    , "blocks", false ...
);

smc = databank.minusControl(model, s, d0);


%
% Generate HTML report 
%

reportTitle = reportTitleTemplate;
reportTitle = replace(reportTitle, "$(area)", upper(area));

htmlFileName = htmlFileNameTemplate;
htmlFileName = replace(htmlFileName, "$(area)", upper(area));
htmlFileName = replace(htmlFileName, "$(stamp)", stamp);
htmlFileName = fullfile(thisDir, htmlFileName);

report.basic(model, smc, range, reportTitle, legend, htmlFileName);

end%

