
close all
clear

load +feb2024/mat/wpp2022_data.mat wpp
load +feb2024/mat/ilolfs.mat lfs
load +feb2024/mat/global4a.mat m4

db = databank.merge("error", wpp, lfs);

sl4 = access(m4, "steady-level");

areas = ["gg", "us", "ea", "cn", "rw"];
other_countries = ["az", "id", "eg", "za", "ma", "ph"];

c = [
         0    0.4470    0.7410
    0.8500    0.3250    0.0980
    0.9290    0.6940    0.1250
    0.4940    0.1840    0.5560
    0.4660    0.6740    0.1880
];
colors = struct();
for aa = areas
    colors.(aa) = c(1, :);
    c = circshift(c, 1);
end

c2 = [
         0    0.4470    0.7410
    0.8500    0.3250    0.0980
    0.9290    0.6940    0.1250
    0.4940    0.1840    0.5560
    0.4660    0.6740    0.1880
    0.30      0.4540    0.10
];
colors2 = struct();
for aa = other_countries
    colors2.(aa) = c2(1, :);
    c2 = circshift(c2, 1);
end

plotRange = db.startHist : db.endProj;
projRange = db.startProj : db.endProj;

plotFunc = @(func, expression, varargin) func(plotRange, databank.eval(db, expression), varargin{:});

figure();
hold on;
hs = [];
for aa = areas
    hs(end+1) = plot(plotRange, pct([db.(aa + "_nn")]),'LineWidth',3);
end
plot(plotRange, Series(plotRange, 100*(sl4.gg_ss_roc_nt-1)), "--", "color", "black",'LineWidth',3);
title("Rate of change in total population - model areas");
legend(hs, upper(areas));
visual.highlight(projRange);

figure();
hold on;
hs = [];
for aa = other_countries
    hs(end+1) = plot(plotRange, pct([db.(aa + "_nn")]),'LineWidth',3);
end
title("Rate of change in total population - other countries");
legend(hs, upper(other_countries));
visual.highlight(projRange);

figure();
hold on;
hs = [];
for aa = areas
    try
        data = 100*db.(aa + "_nw_to_nn");
    catch
        data = Series();
    end
    try
        modelss = 100*Series(plotRange, sl4.(aa + "_ss_nw_to_nn"));
    catch
        modelss = Series();
    end
    hs(end+1) = plot(plotRange, data, "color", colors.(aa), "marker", "s", 'LineWidth',3);
    plot(plotRange, modelss, "--", "color", colors.(aa), 'LineWidth',3);
end
visual.highlight(projRange);
legend(hs, upper(areas));
title("Working age to total population - model areas");

figure();
hold on;
hs = [];
for aa = other_countries
    try
        data = 100*db.(aa + "_nw_to_nn");
    catch
        data = Series();
    end
    hs(end+1) = plot(plotRange, data, "color", colors2.(aa), "marker", "s", 'LineWidth',3);
end
visual.highlight(projRange);
legend(hs, upper(other_countries));
title("Working age to total population - other countries");

figure();
hold on;
hs = [];
for aa = areas
    try
        data = 100*db.(aa + "_nf_to_nw");
    catch
        data = Series();
    end
    try
        modelss = 100*Series(plotRange, sl4.(aa + "_ss_nf_to_nw"));
    catch
        modelss = Series();
    end
    hs(end+1) = plot(plotRange, data, "color", colors.(aa) ,'LineWidth',3);
    plot(plotRange, modelss, "--", "color", colors.(aa), 'LineWidth',3);
end
legend(hs, upper(areas));
visual.highlight(projRange);
title("Labor force participation rate - model areas");

figure();
hold on;
hs = [];
for aa = other_countries
    try
        data = 100*db.(aa + "_nf_to_nw");
    catch
        data = Series();
    end
    hs(end+1) = plot(plotRange, data, "color", colors2.(aa) ,'LineWidth',3);
end
legend(hs, upper(other_countries));
visual.highlight(projRange);
title("Labor force participation rate - other countries");


figure();
tiledlayout( ...
    "flow" ...
    , "tileSpacing", "compact" ...
    , "padding", "compact" ...
);
for aa = areas
    nexttile();
    expression = replace("100*[?_n14, ?_nw, ?_n65] / ?_nn", "?", aa);
    data = databank.eval(db, expression);
    area(plotRange, data);
    visual.highlight(projRange);
    title(upper(aa) + ": Demographic distribution");
    legend("0-14", "Working age", "65+");
end

figure();
tiledlayout( ...
    "flow" ...
    , "tileSpacing", "compact" ...
    , "padding", "compact" ...
);
for aa = other_countries
    nexttile();
    expression = replace("100*[?_n14, ?_nw, ?_n65] / ?_nn", "?", aa);
    data = databank.eval(db, expression);
    area(plotRange, data);
    visual.highlight(projRange);
    title(upper(aa) + ": Demographic distribution");
    legend("0-14", "Working age", "65+");
end

