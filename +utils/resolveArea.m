function area = resolveArea(area, where)

arguments
    area (1, :) string
    where (1, 1) string {mustBeMember(where, ["prefix", "suffix"])} 
end


area = textual.stringify(area);
inxEmpty = strlength(area)==0;

if where=="prefix"
    area(~inxEmpty) = area(~inxEmpty) + "_";
else
    area(~inxEmpty) = "_" + area(~inxEmpty);
end

end%

