function [d,df] = gpm_model_data(dq, attribs)

  % get cclink and comvars
  
  cclink = attribs.cclink(:,1:2);
  comvars = attribs.comvars;

  %- and initialize to avoid warnings in the smoother
  d = initialize_obsdb(cclink,comvars);

  %- get ppp weights (for world aggregation)
  p = struct();
  p = gpm_get_ppp_weights(p,cclink);

  %- and remove eurozone from the cclink as we have data directly
  ii = find(strcmp(cclink(:,2),'EZ'));
  ii = setdiff(1:size(cclink,1), ii);
  cclink = cclink(ii, :);
  cclink(end+1,:) = {'EZ','EZ'};
  
  %- and add empty Series for non-existent as we will evaluate with
  %- dbeval
  dq = ensure_existing_tseries(dq, cclink);

  % ppp shares
  wgdp = world_gdp('','','2015');
  ppps = wgdp.ppps;
  %- add mock eurozone
  ppps.XEZ = 1;

  % iso-2 translate to iso-3
  iso_two2three = trade_matrix.iso_two2three();
  iso_two2three.EZ = 'XEZ';

  % make aggregations
  outcc = unique(sort(cclink(:,2)));
  for ic = 1:length(outcc)
    cc = outcc{ic};
    jj = strmatch(cc, cclink(:,2), 'exact');
    ccc = cclink(jj,1);

    % make template for concatenating time series from this bloc
    % get vector of ppp weights
    tmpl = '';
    pppws = [];
    for j = 1:length(jj)
      if j > 1, tmpl = [tmpl ',']; end
      cciso2 = cclink{jj(j), 1};
      cciso3 = iso_two2three.(cciso2);
      tmpl = [tmpl 'XXX_' cciso2];
      pppws = [pppws, ppps.(cciso3)];
    end
    tmpl = ['[' tmpl ']'];
    %- normalize pppws
    pppws = pppws'/sum(pppws);

    % LGDP
    tmpl1 = strrep(tmpl, 'XXX', 'L_GDP');
    d.(['OBS_L_GDP_' cc]) = gpm_aggregate_with_nans(dbeval(dq, tmpl1), pppws, ...
                                                ccc, cc, 'L_GDP', true);

    % LS & S
    if ~strcmp(cc, 'US')
      tmpl1 = strrep(tmpl, 'XXX', 'L_S');
      ls = gpm_aggregate_with_nans(dbeval(dq, tmpl1), pppws, ccc, cc, 'L_S', true);
      d.(['OBS_S_' cc]) = exp(ls/100);
    end

    % LCPI
    tmpl1 = strrep(tmpl, 'XXX', 'L_CPI');
    d.(['OBS_L_CPI_' cc]) = gpm_aggregate_with_nans(dbeval(dq, tmpl1), pppws, ...
                                                ccc, cc, 'L_CPI', true);

    % LCPIXFE
    tmpl1 = strrep(tmpl, 'XXX', 'L_CPIXFE');
    d.(['OBS_L_CPIXFE_' cc]) = gpm_aggregate_with_nans(dbeval(dq, tmpl1), pppws,...
                                                   ccc, cc, 'L_CPIXFE', true);

    % LCPIF
    tmpl1 = strrep(tmpl, 'XXX', 'L_CPIF');
    d.(['OBS_L_CPIF_' cc]) = gpm_aggregate_with_nans(dbeval(dq, tmpl1), pppws, ...
                                                 ccc, cc, 'L_CPIF', true);

    % LCPIE
    tmpl1 = strrep(tmpl, 'XXX', 'L_CPIE');
    d.(['OBS_L_CPIE_' cc]) = gpm_aggregate_with_nans(dbeval(dq, tmpl1), pppws, ...
                                                 ccc, cc, 'L_CPIE', true);

    % RS
    tmpl1 = strrep(tmpl, 'XXX', 'RS');
    d.(['OBS_RS_' cc]) = gpm_aggregate_with_nans(dbeval(dq, tmpl1), pppws,...
                                             ccc, cc, 'RS', true);

    % UNR
    tmpl1 = strrep(tmpl, 'XXX', 'UNR');
    d.(['OBS_UNR_' cc]) = gpm_aggregate_with_nans(dbeval(dq, tmpl1), pppws,...
                                              ccc, cc, 'UNR', true);

    % BLT
    if ~isempty(strmatch(cc, {'US','EZ','JP'}))
      tmpl1 = strrep(tmpl, 'XXX', 'BLT');
      d.(['OBS_BLT_' cc]) = gpm_aggregate_with_nans(dbeval(dq, tmpl1), pppws,...
                                                ccc, cc, 'BLT', true);
    end
  end

  % aggregation for WORLD observables (GDP and CPI)
  d = gpm_aggregate_world(d,p,cclink);

  % aggregation of EZ government yields
  ccc = {'DE','IT','ES','FR'};
  cc  = {'EZ'};
  d.OBS_NC_RSG40_EZ = gpm_aggregate_with_nans(...
    dbeval(dq, '[NC_RSG40_DE,NC_RSG40_IT,NC_RSG40_ES,NC_RSG40_FR]'),...
    [ppps.DEU, ppps.ITA, ppps.ESP, ppps.FRA]',ccc, cc{:}, 'NC_RSG_40', true);
  
  % individual variables
  d.OBS_L_OIL_US      = dq.L_OIL_US ;
  d.OBS_L_FOOD_US     = dq.L_FOOD_US;
  d.OBS_L_GOLD_US     = dq.L_GOLD_US ;
  d.OBS_L_COAL_US     = dq.L_COAL_US;
  d.OBS_L_COBALT_US   = dq.L_COBALT_US;
  d.OBS_L_COPPER_US   = dq.L_COPPER_US;
  d.OBS_L_IRON_US     = dq.L_IRON_US;
  d.OBS_L_COCOA_US    = dq.L_COCOA_US;
  d.OBS_NC_RSG40_US   = dq.NC_RSG40_US;
  d.OBS_RS_3LIB_US    = dq.RS_3LIB_US;
  d.OBS_RS_6LIB_US    = dq.RS_6LIB_US;
  d.OBS_RS_3EUR_EZ    = dq.RS_3EUR_EZ;
  d.OBS_RS_6EUR_EZ    = dq.RS_6EUR_EZ;
  d.OBS_NC_RSG40_BR   = dq.NC_RSG40_BR;
  d.OBS_NC_RSG40_GB   = dq.NC_RSG40_GB;
  d.OBS_NC_RSG40_JP   = dq.NC_RSG40_JP;

  df = d;

end

function d = initialize_obsdb(cclink,comvars)

  d = struct();
  % commodities
  for ic = 1:length(comvars)
    cmdty = comvars{ic};
    d.(['OBS_L_' cmdty '_US'])        = Series();
    d.(['OBS_L_Q' cmdty '_BAR_US'])   = Series();
    d.(['OBS_L_Q' cmdty '_GAP_US'])   = Series();
    d.(['OBS_DLA_Q' cmdty '_BAR_US']) = Series();
    d.(['OBS_G_Q' cmdty '_BAR_US'])   = Series();
  end

  % rates
  d.OBS_RSG40_US      = Series();
  d.OBS_TPREM40_US    = Series();
  d.OBS_RSG40_EZ      = Series();
  d.OBS_TPREM40_EZ    = Series();
  d.OBS_RSG40_GB      = Series();
  d.OBS_TPREM40_GB    = Series();
  d.OBS_RSG40_JP      = Series();
  d.OBS_TPREM40_JP    = Series();
  d.OBS_RSG40_BR      = Series();
  d.OBS_TPREM40_BR    = Series();
  d.OBS_D_RR_BAR_US   = Series();
  d.OBS_RS_3LIB_US    = Series();
  d.OBS_RS_6LIB_US    = Series();
  d.OBS_RS_3EUR_EZ    = Series();
  d.OBS_RS_6EUR_EZ    = Series();
  d.OBS_PREM_3LIB_US  = Series();
  d.OBS_PREM_6LIB_US  = Series();
  d.OBS_PREM_3EUR_EZ  = Series();
  d.OBS_PREM_6EUR_EZ  = Series();

  % country variables
  outcc = unique(sort(cclink(:,2)));
  for ic = 1:length(outcc)
    cc = outcc{ic};
    if ~strcmp(cc,'US')
      d.(['OBS_S_' cc])           = Series();
    end
    d.(['OBS_L_GDP_' cc])         = Series();
    d.(['OBS_L_CPI_' cc])         = Series();
    d.(['OBS_L_CPIXFE_' cc])      = Series();
    d.(['OBS_L_CPIE_' cc])        = Series();
    d.(['OBS_L_CPIF_' cc])        = Series();
    d.(['OBS_RS_' cc])            = Series();
    d.(['OBS_UNR_' cc])           = Series();
    d.(['OBS_S_' cc])             = Series();
    d.(['OBS_D4L_CPI_TAR_' cc])   = Series();
    d.(['OBS_BLT_' cc])           = Series();
    d.(['OBS_L_GDP_GAP_' cc])     = Series();
    d.(['OBS_L_RP_GAP_' cc])      = Series();
    d.(['OBS_L_Z_GAP_' cc])       = Series();
    d.(['OBS_DLA_Z_BAR_' cc])     = Series();
    d.(['OBS_G_Z_BAR_' cc])       = Series();
    d.(['OBS_NAIRU_' cc])         = Series();
    d.(['OBS_CTYPREM_' cc])       = Series();
    d.(['OBS_DLA_GDP_BAR_' cc])   = Series();
    d.(['OBS_G_GDP_BAR_' cc])     = Series();
    d.(['OBS_D_NAIRU_' cc])       = Series();
    d.(['OBS_RR_BAR_' cc])        = Series();
 end
end

function dq = ensure_existing_tseries(dq, cclink)
  ccc = cclink(:,1);
  tslist = {'L_GDP','L_CPI','L_CPIXFE','L_CPIE','L_CPIF','RS','UNR'};
  for ic = 1:length(ccc)
    cc = ccc{ic};
    if ~strcmp(cc,'US')
      if ~isfield(dq, ['S_' cc])
        dq.(['S_' cc]) = Series();
      end
    end
    for i = 1:length(tslist)
      tsname = [tslist{i} '_' cc];
      if ~isfield(dq, tsname)
        dq.(tsname) = Series();
      end
    end
  end
end


% Makes aggregation for world time series using ppp weights
% d       database with observed data
% p       structure of parameters (including PPP weights)
% cclink  cell array with two columns: first column are 2-letter iso
%         codes of actual countries, the second column are 2-letter codes
%         of countries/blocs in the model. Each i-th row says that
%         cclink{i,1} country belongs to cclink{i,2} bloc. The first
%         column must be unique, the second column does not, as multiple
%         countries can be in one bloc

function d = gpm_aggregate_world(d,p,cclink)

  % make aggregations for big countries/blocks
  outcc = unique(sort(cclink(:,2)));

  % make template for concatenating block time series
  tmpl = '';
  for ic = 1:length(outcc)
      cc = outcc{ic};
      tmpl = [tmpl 'XXX_' cc ','];
  end
  tmpl = tmpl(1:end-1); % remove last comma
  tmpl = ['[' tmpl ']'];

  %- make aggregation for OBS_L_GDP
  tmpl1 = strrep(tmpl, 'XXX', 'OBS_L_GDP');
  d.('OBS_L_GDP_WO') = gpm_aggregate_with_nans(dbeval(d, tmpl1), p.pppws_block_norm, ...
    outcc, 'WO', 'OBS_L_GDP', true);

  %- make aggregation for OBS_L_CPI
  tmpl1 = strrep(tmpl, 'XXX', 'OBS_L_CPI');
  d.('OBS_L_CPI_WO') = gpm_aggregate_with_nans(dbeval(d, tmpl1), p.pppws_block_norm, ...
    outcc, 'WO', 'OBS_L_CPI', true);

end
