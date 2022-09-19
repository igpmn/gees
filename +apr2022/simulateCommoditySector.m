
%% Simulate commodity supply scenarios

m2 = model.symmetric2A.create();


m2 = alter(m2, 2);
m2.aa_lambda(2) = 0.90;
m2.bb_lambda(2) = 0.10;

m2 = steady(m2);

checkSteady(m2);
m2 = solve(m2);


%% Prepare chartpack

ch = databank.Chartpack();
ch.Range = 0:20;
ch.Round = 8;
ch.Transform = @(x) 100*(x-1);
ch.Expansion = {"?", ["aa", "bb"]};

ch < ["Real global commodity price: gg_pq_to_pxx", "Commodity demand and supply: [gg_q, gg_qq]"];
ch < ["Consumption: ?_ch", "Investment: ?_ih", "CPI inflation: ?_roc_pc"];
ch < ["Exchange rate: ?_e", "Policy rate: ?_r", "NFA to GDP: ^ 100*?_nfa_to_ngdp"];


%% Simulate global commodity price shock

d = steadydb(m2, 1:20);
d.gg_shk_pq(1, :) = log(1.10);

s = simulate( ...
    m2, d, 1:20 ...
    , "prependInput", true ...
    , "method", "stacked" ...
);

smc = databank.minusControl(m2, s, d);

draw(ch, smc);

visual.hlegend( ...
    "bottom" ...
    , "AA symmetric" ...
    , "AA 0.90" ...
    , "BB symmetric" ...
    , "BB 0.10" ...
);

visual.heading("Global commodity price shock");


%% Simulate reductions in global commodity supply: Low response in prices

d = steadydb(m2, 1:20);
d.gg_shk_qq(1, :) = log(0.90);

s = simulate( ...
    m2, d, 1:20 ...
    , "prependInput", true ...
    , "method", "stacked" ...
);

smc = databank.minusControl(m2, s, d);

draw(ch, smc);

visual.hlegend( ...
    "bottom" ...
    , "AA symmetric" ...
    , "AA 0.90" ...
    , "BB symmetric" ...
    , "BB 0.10" ...
);

visual.heading("Global commodity supply side shock - Low response in prices");


%% Simulate reductions in global commodity supply: High response in prices

m2.gg_iota_1 = 2;
checkSteady(m2);
m2 = solve(m2);

d = steadydb(m2, 1:20);
d.gg_shk_qq(1, :) = log(0.90);

s = simulate( ...
    m2, d, 1:20 ...
    , "prependInput", true ...
    , "method", "stacked" ...
);

smc = databank.minusControl(m2, s, d);

draw(ch, smc);

visual.hlegend( ...
    "bottom" ...
    , "AA symmetric" ...
    , "AA 0.90" ...
    , "BB symmetric" ...
    , "BB 0.10" ...
);

visual.heading("Global commodity supply side shock - High response in prices");



%% Simulate reductions in global commodity supply: High response in prices

m2.gg_iota_1 = 2;
checkSteady(m2);
m2 = solve(m2);

d = steadydb(m2, 1:20);
d.gg_shk_qq(3, :) = log(0.90); % - 1i*log(0.90);

s = simulate( ...
    m2, d, 1:20 ...
    , "prependInput", true ...
    , "method", "stacked" ...
);

smc = databank.minusControl(m2, s, d);

ch.Highlight = 3;

draw(ch, smc);

visual.hlegend( ...
    "bottom" ...
    , "AA symmetric" ...
    , "AA 0.90" ...
    , "BB symmetric" ...
    , "BB 0.10" ...
);

visual.heading("Global commodity supply side shock - High response in prices");











