function [vpa_d2p,vpa_d2p_sort,pcount,pn_index,vpa_i2a] = fn_min_dist2prot(atoms,natoms_prot,nprot,vpa_sc,nvpa,pcutoff)
%% %how many proteins?
for m = 1:nprot
    a = natoms_prot(m,1);
    b = natoms_prot(m,2);
    %a = (m-1)*natoms_prot + 1;
    %b =     m*natoms_prot;
    prot = atoms(a:b,1:3);
    dist = fn_distanceA2B(vpa_sc,prot'); % distances from entire VPA to a protein.
    [prot_dist,atom_num] = min(dist,[],2);
    vpa_d2p(1:nvpa,m) = prot_dist;
    vpa_i2a(1:nvpa,m) = atom_num + natoms_prot(m,1) -1;%(m-1)*natoms_prot;
end

for m = 1:nvpa
    count = 1;
    [A(m,:),pn_index(m,:)] = sort(vpa_d2p(m,:));
    vpa_i2a(m,:) = vpa_i2a(m,pn_index(m,:));

    for n = 2:nprot
        if A(m,n) <= A(m,1) + 0.5 || A(m,n) <= pcutoff;
            count = count + 1;
        end
    end
    pcount(m) = count;
end
vpa_d2p_sort = A;
%vpa_d2p,vpa_i2a, A% A = sorted distance to proteins.
