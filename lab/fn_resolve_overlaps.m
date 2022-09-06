function [set1,set2,nu1,nu2,changed] = fn_resolve_overlaps(atoms1,atoms2,nu1,nu2)
%%
com1 = mean(atoms1);
com2 = mean(atoms2);
[nat1,o] = size(atoms1);
[nat2,o] = size(atoms2);

% Merge Groups II
overlap = []; idents = []; aleph1 = [];
for m1 = 1:nat1
    temp = atoms1(m1,:);
    aleph1(m1) = fn_angle_btwn_AB(com2,temp);
    if aleph1(m1) <= nu2
        overlap = [overlap; temp];
        idents  = [idents, m1];
    end
end
[Nover,o] = size(overlap);
changed = 0;
if Nover > 0
    changed = 1;
    if Nover >= .99*nat2
         .5*nat2
         Nover
        disp('Merging Groups')
        set1 = [atoms1;atoms2];
        set2 = [];
    else
        % RESOLVE OVERLAPS
        % Set 1 gives up the overlaps, until resolved.
        set1 = atoms1; set2 = atoms2;
        set1(idents,:) = [];
        nat1 = nat1 - numel(idents);
        for ov = 1:Nover
            temp = overlap(ov,:);
            ang1 = fn_angle_btwn_AB(com1,temp);
            ang2 = fn_angle_btwn_AB(com2,temp);
            if ang1 <= ang2
                set1 = [set1; temp];
            else
                set2 = [set2; temp];
            end
        end
        com1 = mean(set1);
        com2 = mean(set2);
        [nset1,o] = size(set1); 
        [nset2,o] = size(set2);
        
        clear theta
        for m = 1:nset1
            temp = set1(m,:);
            theta(m) = fn_angle_btwn_AB(temp,com1);
        end
        nu1 = max(theta);
        clear theta
        for m = 1:nset2
            temp = set2(m,:);
            theta(m) = fn_angle_btwn_AB(temp,com2);
        end
        nu2 = max(theta); 
    end
else
    set1 = atoms1; set2 = atoms2;
end
