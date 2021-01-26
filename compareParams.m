%%%%%%%%%%%%%

function compareParams(m1, m2)

p1 = access(m1, "parameterValues");
p2 = access(m2, "parameterValues");

k1 = keys(p1);
k2 = keys(p2);
k = union(k1, k2, "stable");

for n = reshape(k, 1, [])
    if ismember(n, k1) && ismember(n, k2) 
        if p1.(n)~=p2.(n)
            fprintf("%s %g vs %g \n", n, p1.(n), p2.(n));
        end
        continue
    end
    fprintf("%s missing from ", n);
    if ~ismember(n, k1)
        fprintf("first\n");
    else
        fprintf("second\n");
    end
end

end%

