function y = gpm_aggregate_with_nans(x, ws, ccc, trgcc, tsname, printRes)
% Aggregate columns in timeseries x corresponding to country codes ccc
% with weights ws
%
% All NaNs in x will be ignored in aggregation, so that effective weighing
% would change ruling out these NaNs, however trend for this point will
% be taken into account only for the trend of resulting y
%
%
% x         timeseries with multiple columns of additive nature as we take
%           linear trends
% ws        columns vector of weights corresponding to the columns of x
% ccc       country codes corresponding to the columns of x, useful for
%           messaging only 
% trgcc     country code of the target aggregate
% tsname    name of the time series, useful for messaging only
% printRes  logical, print results of aggregation on screen

  % make sure ws adds up to 1
  ws = ws/sum(ws);
  
  % get range
  ds = get(x,'start');
  de = get(x,'end');
  
  % first check whether there are some columns with all NaNs
  ii = find(all(isnan(x(:)),1));
  if ~isempty(ii)
    for i = ii
      disp(['aggregate ' tsname '_' ccc{i} ': all NaN, ignored']);
    end
    ii = setdiff(1:size(x,2), ii);
    if isempty(ii)
      y = x;
      return;
    end
    x   = Series(ds:de,x(:,ii));    
    ws  = ws(ii);
    ccc = ccc(ii);
  end
  
  % calculate trends for all columns
  xtnd = zeros(size(x));
  for i = 1:size(x,2)
    rn = find(~isnan(x{:,i}));
    X = [ones(numel(rn),1), rn-ds];
    bet = X\x(rn,i);
    xtnd(:,i) = bet(1) + bet(2)*[0:de-ds]';
  end
  xtnd = Series(ds:de, xtnd);
  
  % calculate gaps and report the missing items
  xgap = x - xtnd;
  
  % calculate resulting trend
  ytnd = xtnd*ws;
  
  % aggregate gaps in xgap
  wss = repmat(ws',de-ds+1,1);
  xg = xgap(:);
  jj = isnan(xg);
  xg(jj) = 0;
  wss(jj) = 0;
  wssnorm = diag(1./sum(wss,2))*wss;
  yg = sum(xg.*wss, 2);
  ygap = Series(ds:de, yg);
  
  % resulting y
  y = ytnd + ygap;

  if printRes == true
    % print out the missing items and effective weights
    n = size(x,2);
    if n > 1
      %- intersection of the non-ignored
      jj = find(sum(~isnan(x(:)),2) == n);
      if ~isempty(jj)
        dsin = ds+min(jj)-1;
        dein = ds+max(jj)-1;
        disp(['aggregate ' tsname '_' trgcc ...
          ': intersection of non-ignored ' ...
          dat2char(dsin) '--' dat2char(dein)]);
      else
        disp(['aggregate ' tsname '_' trgcc ...
          ': intersection of non-ignored is empty']);
      end
      
      %- print observations of the last four periods
      %-- header
      disp(['aggregate ' tsname '_' trgcc ': latest observations of '...
        num2str(n) ' non-ignored']);
      disp(['DATE     N    W' sprintf('  %s', ccc{:})]);
      for dt = de-3:de
        s = dat2char(dt, 'dateformat','YYYYFPP');
        s = [s, sprintf(' %2d', sum(~isnan(x(dt,:))))];
        s = [s, sprintf(' %4.3g', 100*sum(wss(dt-ds+1,:)))];
        for i = 1:length(ccc)
          if isnan(x(dt, i))
            s = [s, '    '];
          else
            s = [s, '  **'];
          end
        end
        disp(s);
      end
    end
  end

  % check aggregation for RC countries 
  % if the last value of aggregate is composed from subset of observations below the treshold (80%) then it is ignored
  if strcmp(trgcc,'RC')
      agg_w_bench = 100*sum(wss(de-3-ds+1,:)); % benchmark sum of the weights (as some series for aggregation are not available for all countries)
      agg_w_last  = 100*sum(wss(de-ds+1,:));   % sum of the weights for last observation of aggregate
      % treshold (lower for UNR, higher for CPIs)
      if strcmp(tsname,'UNR')
          crit = 50;
      elseif startsWith(tsname,{'L_CPI','L_CPIXFE','L_CPIF','L_CPIE'})
          crit = 90;
      else
          crit = 80;                        
      end
      
      if agg_w_last < (agg_w_bench*crit/100)
          y(de) = NaN;
          msgbox(['The aggregate ' [tsname '_' trgcc] ' in period ' dat2char(de) ... 
          ' is ignored as it is composed from less than ' num2str(crit) '% of available observations.'],'Aggregation','warn');     
      end
  end

  
end
