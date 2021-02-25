% loads data downloaded from BIS website
% source: https://www.bis.org/statistics/full_data_sets.htm
clearvars
close all
clc

mkdir('matfiles')

%% Load BIS credit gap data:
tic
disp('Loading credit gap data...')
t_cred_gap  = readtable('datafiles/WEBSTATS_CREDIT_GAP_DATAFLOW_csv_col.csv');
db_cred_gap = struct();
nRow = size(t_cred_gap,1);
varNames = t_cred_gap.Properties.VariableNames;
dates    = varNames(startsWith(varNames,'x'));
fst      = qq(str2num(dates{1}(2:5)),   str2num(dates{1}(end)));
lst      = qq(str2num(dates{end}(2:5)), str2num(dates{end}(end)));
startIndex = find(startsWith(varNames,'x'),1);
for iter = 1:3:nRow
  % total
  tsName = [t_cred_gap.BORROWERS_CTY{iter} '_cred_to_GDP'];
  db_cred_gap.(tsName) = Series(fst:lst,t_cred_gap{iter,startIndex:end});
  
  % trend
  tsName = [t_cred_gap.BORROWERS_CTY{iter+1} '_cred_to_GDP_tnd'];
  db_cred_gap.(tsName) = Series(fst:lst,t_cred_gap{iter+1,startIndex:end});
  
  % gap
  tsName = [t_cred_gap.BORROWERS_CTY{iter+2} '_cred_to_GDP_gap'];
  db_cred_gap.(tsName) = Series(fst:lst,t_cred_gap{iter+2,startIndex:end});  
end
save matfiles/credit_gap.mat t_cred_gap db_cred_gap
toc
disp('... done')
clearvars

%% Load BIS consolidated banking statistics - table only, the Series would take about 2.5 hrs to convert all
tic
disp('Loading CBS data...')
t_cbs  = readtable('datafiles/WEBSTATS_CBS_DATAFLOW_csv_col.csv');
% db_cbs = struct();
% varNames = t_cbs.Properties.VariableNames;
% dates    = varNames(startsWith(varNames,'x'));
% fst      = qq(2000,1); % pre-2000 data reported biannually
% lst      = qq(str2num(dates{end}(2:5)), str2num(dates{end}(end)));
% startIndex = find(strcmp(varNames, 'x2000_Q1'));
% for iter = 1:size(t_cbs,1)
%   tsName = ['ts_' num2str(iter)];
%   db_cbs.(tsName) = Series(fst:lst,t_cbs{iter,startIndex:end});  
% end
% save matfiles/cbs.mat t_cbs db_cbs
save matfiles/cbs.mat t_cbs
disp('... done')
toc
clearvars

%% BIS locational banking statistics
tic;
disp('Loading LBS data...')
t_lbs = readtable('datafiles/WEBSTATS_LBS_D_PUB_DATAFLOW_csv_col.csv');
% db_lbs = struct();
% varNames = t_lbs.Properties.VariableNames;
% dates    = varNames(startsWith(varNames,'x'));
% fst      = qq(str2num(dates{1}(2:5)),   str2num(dates{1}(end)));
% lst      = qq(str2num(dates{end}(2:5)), str2num(dates{end}(end)));
% startIndex = find(startsWith(varNames,'x'),1);
% for iter = 1:size(t_lbs,1)
%   tsName = ['ts_' num2str(iter)];
%   db_lbs.(tsName) = Series(fst:lst,t_lbs{iter,startIndex:end});  
% end
% save matfiles/lbs.mat t_lbs db_lbs
save matfiles/lbs.mat t_lbs
disp('... done')
toc
clearvars
%% BIS debt secturities statistics
tic;
disp('Loading Debt Secturities data...')
t_debtsec = readtable('datafiles/WEBSTATS_DEBTSEC_DATAFLOW_csv_col.csv');
% db_debtsec = struct();
% varNames = t_debtsec.Properties.VariableNames;
% dates    = varNames(startsWith(varNames,'x'));
% fst      = qq(str2num(dates{1}(2:5)),   str2num(dates{1}(end)));
% lst      = qq(str2num(dates{end}(2:5)), str2num(dates{end}(end)));
% startIndex = find(startsWith(varNames,'x'),1);
% for iter = 1:size(t_debtsec,1)
%   tsName = ['ts_' num2str(iter)];
%   db_debtsec.(tsName) = Series(fst:lst,t_debtsec{iter,startIndex:end});  
% end
% save matfiles/debtsec.mat t_debtsec db_debtsec
save matfiles/debtsec.mat t_debtsec
disp('... done')
toc
clearvars

%% BIS total credit to non-financial sector data
tic;
disp('Loading total credit to non-financial sector data...')
t_totcred = readtable('datafiles/WEBSTATS_TOTAL_CREDIT_DATAFLOW_csv_col.csv');
db_totcred = struct();
varNames = t_totcred.Properties.VariableNames;
dates    = varNames(startsWith(varNames,'x'));
fst      = qq(str2num(dates{1}(2:5)),   str2num(dates{1}(end)));
lst      = qq(str2num(dates{end}(2:5)), str2num(dates{end}(end)));
startIndex = find(startsWith(varNames,'x'),1);
for iter = 1:size(t_totcred,1)
  tsName = ['ts_' num2str(iter)];
  db_totcred.(tsName) = Series(fst:lst,t_totcred{iter,startIndex:end});  
end
save matfiles/debtsec.mat t_totcred db_totcred
disp('... done')
toc
clearvars

%% BIS Debt service ratios
tic;
disp('Loading debt service ratios data...')
t_dsr = readtable('datafiles/WEBSTATS_DSR_DATAFLOW_csv_col.csv');
db_dsr = struct();
varNames = t_dsr.Properties.VariableNames;
dates    = varNames(startsWith(varNames,'x'));
fst      = qq(str2num(dates{1}(2:5)),   str2num(dates{1}(end)));
lst      = qq(str2num(dates{end}(2:5)), str2num(dates{end}(end)));
startIndex = find(startsWith(varNames,'x'),1);
for iter = 1:size(t_dsr,1)
  tsName = ['ts_' num2str(iter)];
  db_dsr.(tsName) = Series(fst:lst,t_dsr{iter,startIndex:end});  
end
save matfiles/dsr.mat t_dsr db_dsr
disp('... done')
toc
clearvars

%% BIS Global liquidity indicators
tic;
disp('Loading Global liquidity indicators data...')
t_gli = readtable('datafiles/WEBSTATS_GLI_DATAFLOW_csv_col.csv');
db_gli = struct();
varNames = t_gli.Properties.VariableNames;
dates    = varNames(startsWith(varNames,'x'));
fst      = qq(str2num(dates{1}(2:5)),   str2num(dates{1}(end)));
lst      = qq(str2num(dates{end}(2:5)), str2num(dates{end}(end)));
startIndex = find(startsWith(varNames,'x'),1);
for iter = 1:size(t_gli,1)
  tsName = ['ts_' num2str(iter)];
  db_gli.(tsName) = Series(fst:lst,t_gli{iter,startIndex:end});  
end
save matfiles/gli.mat t_gli db_gli
disp('... done')
toc
clearvars

%% BIS Exchange traded derivatives
tic;
disp('Loading Exchange traded derivatives data...')
t_xtd = readtable('datafiles/WEBSTATS_XTD_DATAFLOW_csv_col.csv','ReadVariableNames',true);
db_xtd = struct();
varNames = t_xtd.Properties.VariableNames;
dates    = varNames(startsWith(varNames,'x'));
dates    = dates(any([endsWith(dates,'Q1')' endsWith(dates,'Q2')' endsWith(dates,'Q3')' endsWith(dates,'Q4')']')); % only quarterly
fst      = qq(str2num(dates{1}(2:5)),   str2num(dates{1}(end)));
lst      = qq(str2num(dates{end}(2:5)), str2num(dates{end}(end)));
startIndex = find(strcmp(varNames,dates{1}));
endIndex   = find(strcmp(varNames,dates{end}));
for iter = 1:size(t_xtd,1)
  tsName = ['ts_' num2str(iter)];
  db_xtd.(tsName) = Series(fst:lst,t_xtd{iter,startIndex:endIndex});  
end
save matfiles/xtd.mat t_xtd db_xtd
disp('... done')
toc
clearvars

%% BIS OTC derivatives - reported bi-annually, turned off for now
% tic;
% disp('Loading OTC derivatives data...')
% t_otcd = readtable('datafiles/WEBSTATS_OTC_DATAFLOW_csv_col.csv');
% db_otcd = struct();
% varNames = t_otcd.Properties.VariableNames;
% dates    = varNames(startsWith(varNames,'x'));
% fst      = qq(str2num(dates{1}(2:5)),   str2num(dates{1}(end)));
% lst      = qq(str2num(dates{end}(2:5)), str2num(dates{end}(end)));
% startIndex = find(startsWith(varNames,'x'),1);
% for iter = 1:size(t_otcd,1)
%   tsName = ['ts_' num2str(iter)];
%   db_otcd.(tsName) = Series(fst:lst,t_otcd{iter,startIndex:end});  
% end
% save matfiles/otcd.mat t_otcd db_otcd
% disp('... done')
% toc
% clearvars

%% BIS selected property prices
tic;
disp('Loading selected property prices data...')
t_spp  = readtable('datafiles/WEBSTATS_SELECTED_PP_DATAFLOW_csv_col.csv');
db_spp = struct();
varNames = t_spp.Properties.VariableNames;
dates    = varNames(startsWith(varNames,'x'));
fst      = qq(str2num(dates{1}(2:5)),   str2num(dates{1}(end)));
lst      = qq(str2num(dates{end}(2:5)), str2num(dates{end}(end)));
startIndex = find(startsWith(varNames,'x'),1);
for iter = 1:size(t_spp,1)
  tsName = ['ts_' num2str(iter)];
  db_spp.(tsName) = Series(fst:lst,t_spp{iter,startIndex:end});  
end
save matfiles/spp.mat t_spp db_spp
disp('... done')
toc
clearvars

%% BIS selected property prices
tic;
disp('Loading long property prices data...')
t_lpp  = readtable('datafiles/WEBSTATS_LONG_PP_DATAFLOW_csv_col.csv');
db_lpp = struct();
varNames = t_lpp.Properties.VariableNames;
dates    = varNames(startsWith(varNames,'x'));
fst      = qq(str2num(dates{1}(2:5)),   str2num(dates{1}(end)));
lst      = qq(str2num(dates{end}(2:5)), str2num(dates{end}(end)));
startIndex = find(startsWith(varNames,'x'),1);
for iter = 1:size(t_lpp,1)
  tsName = ['ts_' num2str(iter)];
  db_lpp.(tsName) = Series(fst:lst,t_lpp{iter,startIndex:end});  
end
save matfiles/lpp.mat t_lpp db_lpp
disp('... done')
toc
clearvars
