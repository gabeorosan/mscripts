function [nu] = fn_compute_nu(atoms)
%
com = mean(atoms);
[natoms,o] = size(atoms);
for m = 1:natoms
    temp = atoms(m,:);
    ang(m) = fn_angle_btwn_AB(com,temp);
end
nu = max(ang);