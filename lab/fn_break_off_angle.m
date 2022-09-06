function [keep,drop,cutoff] = fn_break_off_angle(atoms,nu_max)
%
com = mean(atoms);
[natoms,o] = size(atoms);

for m = 1:natoms
    temp = atoms(m,:);
    ang(m) = fn_angle_btwn_AB(com,temp);
end
ave_ang = mean(ang);
std_ang = std(ang);

r_atoms = calc_radii(atoms);
Rmean = mean(r_atoms);

cutoff = ave_ang + 1.645*std_ang; % Keeping 95%
cutoff = min(cutoff,nu_max);
keep = []; drop = [];
for m = 1:natoms
    temp = atoms(m,:);
    rtemp = calc_radii(temp);
    if (ang(m) >= cutoff) && (rtemp <= Rmean)
        drop = [drop; temp];
    else
        keep = [keep; temp]; 
    end
end
cutoff = fn_compute_nu(keep);