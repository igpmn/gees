function area = resolveArea(area, where)

area = textual.stringify(area);
where = string(where);
inxEmpty = strlength(area)==0;

if where=="prefix"
    area(~inxEmpty) = area(~inxEmpty) + "_";
else
    area(~inxEmpty) = "_" + area(~inxEmpty);
end

end%

