% Calculated PPP weights for model countires/blocks 
% p       structure of parameters input/output
% cclink  cell array with two columns: first column are 2-letter iso
%         codes of actual countries, the second column are 2-letter codes
%         of countries/blocs in the model. Each i-th row says that
%         cclink{i,1} country belongs to cclink{i,2} bloc. The first
%         column must be unique, the second column does not, as multiple
%         countries can be in one bloc  

function p = gpm_get_ppp_weights(p,cclink)
 
  % ppp shares
  wgdp = world_gdp('','','2015');
  ppps = wgdp.ppps;
  
  % iso-2 translate to iso-3
  iso_two2three = trade_matrix.iso_two2three();
    
  % take model countries/blocks
  outcc = unique(sort(cclink(:,2)));
  % get vector of ppp weights for model countries/blocks
  pppws_block = [];
  
  for ic = 1:length(outcc)
     cc  = outcc{ic};
     jj  = strmatch(cc, cclink(:,2), 'exact');
     
     % get vector of ppp weights for countries in the block (e.g. RC)
     pppws = [];
     
     for j = 1:length(jj)
       cciso2 = cclink{jj(j), 1};
       cciso3 = iso_two2three.(cciso2);
       pppws = [pppws, ppps.(cciso3)];
     end
     
     pppws_block = [pppws_block, sum(pppws)];
  end
  
  % normalize ppp weights
   p.pppws_block_norm = pppws_block'/sum(pppws_block);
   
  % assign weights to model parameters
   for j = 1:length(outcc)
      cc = outcc{j};
      p.(['weight_PPP_' cc])   = p.pppws_block_norm(j);
   end


end