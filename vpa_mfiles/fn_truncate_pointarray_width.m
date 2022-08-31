function [tpa,ntpa] = fn_truncate_pointarray_width(minR_au,maxR_au,vpa_au)
%width_base = maxR_au - minR_au + 2*vdw;

cutoff = minR_au;
r_test = calc_radii(vpa_au*maxR_au);

p = 1;
r_keep = []; tpa = [];
for m = 1:numel(r_test)
    if r_test(m) >= cutoff
        r_keep(p) = r_test(m);
        tpa(1:3,p) = vpa_au(1:3,m);
        p = p + 1;
    end
end
ntpa = p - 1;