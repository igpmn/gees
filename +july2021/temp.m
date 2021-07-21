%% Set of comparative static excercises

clear
close all
rehash path


%% Create a 4A version of the model

ma = model.autarky.create();
m2 = model.symmetric2A.create();
m4 = model.global4A.create();



%% Increase in global productivity

temp = compareSteady.globalProductivity.run(m4, 0.10, "G4");


%% Increase in govt debt globally (all areas)

[t4, m4_] = compareSteady.globalGovtDebt.run(m4, 0.20, "G4");
[t2, m2_] = compareSteady.globalGovtDebt.run(m2, 0.20, "S2");
[ta, ma_] = compareSteady.globalGovtDebt.run(ma, 0.20, "A");


%% Increase in area govt debt

t4_us = compareSteady.areaGovtDebt.run(m4, "us", 0.20, "G4");
t4_cn = compareSteady.areaGovtDebt.run(m4, "cn", 0.20, "G4");

%%

ma_ = ma;
ma_.chi_curr = 0.7;
ma_ = steady(ma_);
checkSteady(ma_);
ma_ = solve(ma_);

%%

% m4_ = m4;
% m4_.us_chi_curr = 0.7;
% m4_.ea_chi_curr = 0.7;
% m4_.cn_chi_curr = 0.7;
% m4_.rw_chi_curr = 0.7;
% m4_ = steady(m4_);
% checkSteady(m4_);
% m4_ = solve(m4_);

% m4_ = m4;
% 
% m4_.us_theta_2 = 0.5*m4_.us_theta_1;
% m4_.ea_theta_2 = 0.5*m4_.ea_theta_1;
% m4_.cn_theta_2 = 0.5*m4_.cn_theta_1;
% m4_.rw_theta_2 = 0.5*m4_.rw_theta_1;
% m4_ = steady(m4_);
% checkSteady(m4_);
% m4_ = solve(m4_);

[s,smc,~,n] = simulate.areaGovtDebt.run(m4,"us",1:20,0.10,"xx");

[s1,smc1,~,n1] = simulate.globalGovtDebt.run(m4,1:10,0.10,"xx");

[s2,smc2] = simulate.globalProductivity.run(m4,1:10,0.10,"xx");

%%

%{
l2 = access(m2, "steady-level");
c2 = access(m2, "steady-change");

la = access(ma, "steady-level");
ca = access(ma, "steady-change");

l2_ = access(m2_, "steady-level");
c2_ = access(m2_, "steady-change");

la_ = access(ma_, "steady-level");
ca_ = access(ma_, "steady-change");

pa = access(ma, "parameter-values");
p2 = access(m2, "parameter-values");

for na = databank.fieldNames(pa)
	if startsWith(na, "gg_")
		n2 = na;
	else
		n2 = "aa_" + na;
	end
	if isfield(l2, n2) && pa.(na)==p2.(n2)
		continue
	end
	disp(na)
end

xa = ma;

for na = access(ma, "transition-variables")
	if startsWith(na, "gg_")
		continue
	end
	xa.(na) = m2.("aa_"+na);
end

xa.gg_qq = xa.mq;
xa.gg_q = xa.mq;
xa.gg_ngdp = xa.ngdp;
%}




