%% Set of dynamic simulations of steady state transitions

clear
close all
rehash path


%% Create different versions of the model
%
% * ma - an autarky economy
% * m2 - a symmetric two-area economy
% * m4 - a global four-area economy
%

ma = model.autarky.create();
m2 = model.symmetric2A.create();
m4 = model.global4A.create();
 

%% Permanent increase in global productivity
%
% Dynamic simulation HTML report is in 
% +simulate/+globalProductivity

[s, smc] = simulate.globalProductivity.run(m4, 1:10, 0.10, "G4");


%% Permanent increase in global productivity - anticipation assumptions 
%
% Illustrate the simulation design of productivity shocks with different
% information sets/anticipation assumptions
%

% Anticipated future improvements

d1 = steadydb(m4, 1:10);
d1.gg_shk_a(4) = log(1.10);

s1 = simulate( ...
    m4, d1, 1:10 ...
    , "prependInput", true ...
    , "method", "stacked" ... 
);

smc1 = databank.minusControl(m4, s1, d1);


% Unanticipated future improvements

d2 = steadydb(m4, 1:10);
d2.gg_shk_a(4) = 1i*log(1.10);

s2 = simulate( ...
    m4, d2, 1:10 ...
    , "prependInput", true ...
    , "method", "stacked" ... 
);

smc2 = databank.minusControl(m4, s2, d2);


% Half-anticipated future improvements

d3 = steadydb(m4, 1:10);
d3.gg_shk_a(4) = log(1.049) + 1i*log(1.049);

s3 = simulate( ...
    m4, d3, 1:10 ...
    , "prependInput", true ...
    , "method", "stacked" ... 
);

smc3 = databank.minusControl(m4, s3, d3);


% Anticipated future improvements but disappointment in the end

d4 = steadydb(m4, 1:10);
d4.gg_shk_a(4) = log(1.10) - 1i*log(1.10);

s4 = simulate( ...
    m4, d4, 1:10 ...
    , "prependInput", true ...
    , "method", "stacked" ... 
);

smc4 = databank.minusControl(m4, s4, d4);


% Quick chartpack

ch = databank.Chartpack();
ch.Range = 0:10;
ch.Transform = @(x) 100*(x-1);
ch.Highlight = {1, 4};

ch < ["gg_a", "cn_ch", "us_ch", "cn_roc_pc", "us_pk/us_pc"];

draw(ch, databank.merge("horzcat", smc1, smc2, smc3, smc4));



%% Permanent increase in area productivity

initials = access(m4, "initials");
transpose(initials)


m4a = m4;
m4a.cn_ss_ar = m4a.cn_ss_ar * 1.10;
m4a = steady(m4a);
checkSteady(m4a);
m4a = solve(m4a);


% Productivity improvements start right away

d1 = steadydb(m4, 1:10);

z1 = simulate( ...
    m4a, d1, 1:10 ...
    , "prependInput", true ...
    , "method", "stacked" ...
);

zmc1 = databank.minusControl(m4a, z1, d1);


% Productivity improvements start in year 4 (and everyone knows)

d2 = steadydb(m4, 1:10);

p2 = Plan.forModel(m4a, 1:10);
p2 = swap(p2, 1:3, ["cn_ar", "cn_shk_ar"]);

% d2.cn_ar(1:3) = ...

z2 = simulate( ...
    m4a, d2, 1:10 ...
    , "prependInput", true ...
    , "method", "stacked" ...
    , "plan", p2 ...
);

zmc2 = databank.minusControl(m4a, z2, d2);


d3 = steadydb(m4, 1:10);

p3 = Plan.forModel(m4a, 1:10);
p3 = anticipate(p3, false, ["cn_ar", "cn_shk_ar"]);
p3 = swap(p3, 1:3, ["cn_ar", "cn_shk_ar"]);

z3 = simulate( ...
    m4a, d3, 1:10 ...
    , "prependInput", true ...
    , "method", "stacked" ...
    , "plan", p3 ...
);

zmc3 = databank.minusControl(m4a, z3, d3);


ch = databank.Chartpack();
ch.Range = 0:10;
ch.Transform = @(x) 100*(x-1);

ch < ["cn_ar", "cn_ch", "us_ch", "cn_roc_pc"];


chartDb = databank.merge("horzcat", zmc1, zmc2, zmc3);

% draw(ch, chartDb);

legends = ["Immediate", "Delayed expected", "Delayed unexpected"];
report.basic(m4a, chartDb, 1:10, "CH Relative prod imp", legends, "./xxx")


%% Global increase in risk appetite

[s, smc] = simulate.globalRiskAppetiteCapital.run(m4, 1:10, 0.95, "G4");



%% Global productivity and area specific leverage


d = steadydb(m4, 1:10);

d1 = d;
d1.gg_shk_a(4) = log(1.15);

s1 = simulate( ...
    m4, d1, 1:10 ...
    , "prependInput", true ...
    , "method", "stacked" ...
);


m4.cn_rho_zh_aut = 1;
m4 = solve(m4);


d2 = d1;
d2.cn_shk_zh_aut(1) = -0.02;

s2 = simulate( ...
    m4, d2, 1:10 ...
    , "prependInput", true ...
    , "method", "stacked" ...
);


d3 = s2;
d3.gg_shk_a(4) = 0;

s3 = simulate( ...
    m4, d3, 4:10 ...
    , "prependInput", true ...
    , "method", "stacked" ...
);


d4 = s2;
d4.gg_shk_a(4) = 0;
d4.cn_shk_zh_aut(4) = +0.02;

s4 = simulate( ...
    m4, d4, 4:10 ...
    , "prependInput", true ...
    , "method", "stacked" ...
);


smc1 = databank.minusControl(m4, s1, d);
smc2 = databank.minusControl(m4, s2, d);
smc3 = databank.minusControl(m4, s3, d);
smc4 = databank.minusControl(m4, s4, d);

reportDb = databank.merge("horzcat", smc1 & smc2 & smc3 & smc4);

legends = [ 
    "Actual productivity" ...
    , "Actual productivity with China" ...
    , "No productivity, China remains" ...
    , "No productivity, No China" ...
];

report.basic( ...
    m4, reportDb, 1:10 ...
    , "Global productivity and leverage" ...
    , legends ...
    , "+july2021/xxx.html" ...
);





%% China's access to world finance - different expectations assumptions


d = steadydb(m4, 1:10);


m4a = m4;
m4a.cn_rho_zh_aut = 1;
m4a = solve(m4a);

d1 = d;
d1.cn_shk_zh_aut(1) = -0.02;

s1 = simulate( ...
    m4a, d1, 1:10 ...
    , "prependInput", true ...
    , "method", "stacked" ...
);




d2 = d;

p2 = Plan.forModel(m4a, 1:10);
p2 = anticipate(p2, false, ["cn_zh_aut", "cn_shk_zh_aut"]);
p2 = swap(p2, 1:10, ["cn_zh_aut", "cn_shk_zh_aut"]);

d2.cn_zh_aut(1:10) = d2.cn_zh_aut(1:10) - 0.02; 

s2 = simulate( ...
    m4, d2, 1:10 ...
    , "prependInput", true ...
    , "method", "stacked" ...
    , "plan", p2 ...
);


smc1 = databank.minusControl(m4, s1, d);
smc2 = databank.minusControl(m4, s2, d);


reportDb = databank.merge("horzcat", smc1, smc2);

legends = [ 
    "Easy access expected and actual" ...
    "Easy access not expected but actual" ...
];

report.basic( ...
    m4, reportDb, 1:10 ...
    , "China's access to world finance" ...
    , legends ...
    , "+july2021/yyy.html" ...
);



