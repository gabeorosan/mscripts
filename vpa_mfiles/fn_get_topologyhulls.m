function [topid, top_hulls] = fn_get_topologyhulls(Mvpa)
[x,narrays] = size(Mvpa);
[top_hulls] = fn_build_topologies(Mvpa);
for m = 1:narrays
    clear z
    test = Mvpa(m).vpa_sec_out;
    r = max(calc_radii(test));
    test = test/r;
    for n = 1:21
        clear A
        topo = top_hulls(n).top;
        A = fn_distanceA2B(test,topo);
        z(n) = min(min(A,[],2));
    end
    z = round(1e4*z)/1e4;
    [a,b] = min(z);
    topid(m) = b;
    numid(m) = a;
end
   