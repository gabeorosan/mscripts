function [namelist] = fn_namelist_matrix()
%%
clear namelist
p = 1;
t5list = [11,12,13,27,28,29,30,50,51,52,53,54,55];
N5 = numel(t5list);
for m = 1:N5
    for n = (m+1):N5
        namelist(p,1:2) = [t5list(m) t5list(n)];
        p = p + 1;
    end
end

t3list = [7,8,9,10,22,23,24,25,26,42,43,44,45,46,47,48,49];
N3 = numel(t3list);

for m = 1:N3
    for n = (m+1):N3
        namelist(p,1:2) = [t3list(m) t3list(n)];
        p = p + 1;
    end
end

t2list = [1,2,3,4,5,6,14,15,16,17,18,19,20,21,31,32,33,34,35,36,37,38,39,40,41];
N2 = numel(t2list);

for m = 1:N2
    for n = (m+1):N2
        namelist(p,1:2) = [t2list(m) t2list(n)];
        p = p + 1;
    end
end