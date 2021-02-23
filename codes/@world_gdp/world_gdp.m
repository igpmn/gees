classdef world_gdp

  properties
    % nominal GDP of countries keyed by ISO 3 letter codes
    ngdp = struct();
    % shares on world in PPP
    ppps = struct();
  end
  
  methods
    % Construct the object
    %
    % fname    filename of the weo database; if fname is empty than
    %          default data/weo_nominal_gdp.xls is used
    % year     string for which year we want GDP
    function self = world_gdp(fname_gdp, fname_ppp, year)
      year = str2num(year);
      %- get default fname if empty
      if isempty(fname_gdp)
        fname_gdp = world_gdp.get_default_gdp_fname();
      end
      %- parse nominal GDP
      self.ngdp = world_gdp.parse_data_for_year(fname_gdp,'Nominal GDP',year);
      %- get default fname if empty
      if isempty(fname_ppp)
        fname_ppp = world_gdp.get_default_ppp_fname();
      end
      %- parse PPP shares
      self.ppps = world_gdp.parse_data_for_year(fname_ppp,'PPP share',year);
    end
  end
  
  methods (Static)
    % get default fname for the data: that is
    % ../data/weo_nominal_gdp.xls relative to location of this file
    function fname = get_default_gdp_fname()
      a = which('world_gdp');
      fname = fullfile(fileparts(fileparts(a)),'data','weo_nominal_gdp.xls');
    end
    
    % get default fname for the data: that is
    % ../data/weo_ppp_share.xls relative to location of this file
    function fname = get_default_ppp_fname()
      a = which('world_gdp');
      fname = fullfile(fileparts(fileparts(a)),'data','weo_ppp_share.xls');
    end
    
    % parses given sheet in the given filename and takes the given year
    function s = parse_data_for_year(fname, sheet, year)
      [num, txt, ~] = xlsread(fname, sheet, '', 'basic');
      jj = find(year == num(1,:));
      if isempty(jj)
        error(['Cannot find the required year ' num2str(year) ' in weo data']);
      end
      cc = txt(2:end,1);
      aa = num(2:end,jj);
      aa = mat2cell(aa, repmat(1,numel(aa),1));
      s = cell2struct(aa, cc, 1);
    end
  end
end
  