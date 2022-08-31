function [au,au_save,centered] = fn_centre_au(au,ipp,Tnum)
%%
locN3 = fn_centre_proteins(au,ipp,Tnum);
d2ps = fn_dist2planes(locN3');
centered = 0;
au_mod = au;
au_save = au;
for m = 1:Tnum
    for n = 1:3
        if d2ps(m,n) < 0
            temp = au(ipp(m,1):ipp(m,2),1:3);
            A = fn_apply_icos3d_rots(temp,5);
            au_mod(ipp(m,1):ipp(m,2),:) = A;
            locN3 = fn_centre_proteins(au_mod,ipp,Tnum);
            d2ps  = fn_dist2planes(locN3');
            centered = 1;
            break
        end
    end
end

locN3 = fn_centre_proteins(au_mod,ipp,Tnum);
d2ps = fn_dist2planes(locN3');
for m = 1:Tnum
    for n = 1:3
        if d2ps(m,n) < 0
            disp('damn it')
        end
    end
end

au = au_mod;
if centered == 1 disp('au centered'), end