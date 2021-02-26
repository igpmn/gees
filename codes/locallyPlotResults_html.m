function [grid,layout] = locallyPlotResults_html(dbase, varList, plotrange, gridTitle, label)
%% This function makes Grid object for reporting
% as well as layout string to include all charts into report

% Works like dbplot for list of variables (varList), supports up to 2
% databases

% Number of columns specified manually
grid_col = 7;
grid_row = ceil(length(varList)/grid_col);

grid = rephrase.Grid(gridTitle, grid_row, grid_col, 'DateFormat', 'YY', "DisplayTitle", true);
    for j = 1:length(varList)
        if length(dbase)==1
          assignin ( 'caller', "chart" + num2str(j), ...
             rephrase.Chart(get(dbase{1}.(varList(j)),'comment'),plotrange(1),plotrange(end)) ...
                < rephrase.Series(label, dbase{1}.(varList(j))) ...
          );
        elseif length(dbase)==2
          assignin ( 'caller', "chart" + num2str(j), ...
             rephrase.Chart(get(dbase{1}.(varList(j)),'comment'),plotrange(1),plotrange(end)) ...
                < rephrase.Series(label(1), dbase{1}.(varList(j))) ...
                < rephrase.Series(label(2), dbase{2}.(varList(j))) ...
          );
            
        else
            warning('Only up to 2 databases are currently supported')'
        end
    end
    
   layout = "rep < rephrase.Pagebreak( ) < (grid";
          for j = 1:length(varList)
            layout = strcat(layout, "< chart",num2str(j));
          end
   layout = strcat(layout,");");
    
end