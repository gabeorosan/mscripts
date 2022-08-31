function [allprots,dmat,prot_nums] = fn_all_proteins_included(d2p_sort,ipp,ntpa,nprot,pcount,Tnum,vpa_i2a)

for m = 1:ntpa
    dmat(m,1:pcount(m)) = d2p_sort(m,1:pcount(m));
    temp = vpa_i2a(m,1:pcount(m));
    for n = 1:numel(temp)
        for p = 1:nprot
            if (temp(n) > ipp(p,1) && temp(n) < ipp(p,2))
                prot_mat(m,1:pcount(m)) = p;
            end
        end
    end
end

prot_nums = unique(prot_mat);
if prot_nums(1) == 0
    prot_nums(1) = [];
end

temp_prot = mod(prot_nums,Tnum);
for m = 1:numel(temp_prot)
    if temp_prot(m) == 0
        temp_prot(m) = Tnum;
    end
end
allprots = 0;

if numel(unique(temp_prot)) == Tnum
    allprots = 1;
end
prot_nums = temp_prot;