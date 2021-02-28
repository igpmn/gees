function dbp = dbint2time(dbase, varlist, simrange)
dbp = struct();
    for i=1:numel(varlist)
        dbp.(varlist(i)) = tseries(yy(simrange(1)-1):yy(simrange(end)),...
                                dbase.(varlist(i))(simrange(1)-1:end));
        dbp.(varlist(i)) = ...
            comment(dbp.(varlist(i)), get( dbase.(varlist(i)), 'comment'));
    end  
end
