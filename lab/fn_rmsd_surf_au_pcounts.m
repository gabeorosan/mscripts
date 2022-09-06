function [rmsd_surf,div] = fn_rmsd_surf_au_pcounts(vpa_d2p_sort,pcount,vmult,use_pmult,vdw,ntpa)
%%
% Determine number of Radial Levels to be used, min of 2.
% p = 0;
% for m = 1:numel(vpa_radii)
%     if vpa_radii(m) >= radial_cutoff
%         p = p + 1;
%     end
% end
% % How many levels must be included in RMSD, not sure if it's relevant any more
% % given the exclusions based on Gauge Points: 12 March 2013.
% if p < NP
%     p = NP;
% end

% Protein Multiplicity
if use_pmult == 0
    vmult(1:p) = 1;
end

rmsd_fail = 0;
for m = 1:ntpa
    clear temp_dist
    temp_dist = vpa_d2p_sort(m,1:pcount(m)) - vdw;
    for n = 1:numel(temp_dist)
        if temp_dist(n) < 0
            temp_dist(n) = 999; % can be reworked to "speed up"
            rmsd_fail = 1;
        end
    end
    partial(m) = sum(temp_dist.^2)*vmult(m);
    udist(m)   = temp_dist(1);
end
div = sum(pcount(1:ntpa)*vmult(1:ntpa)');
if rmsd_fail == 1
    rmsd_surf = 999;
else
    rmsd_surf = sqrt(sum(partial)/div);
end