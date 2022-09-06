function [dist_surf,nearest,length_all] = fn_dock2capsid(atoms,maxR_atoms,maxR_vpa,natoms_prot,nprot,nvpa_hull,offset,pcutoff,vdw,vpa_hull)
tidbit = 0.01; % make input controlled.
% Prepare the outermost VPA hull for initial docking.
length = maxR_atoms + offset;
scale = length/maxR_vpa;
vpa_sc = scale*vpa_hull;

% Calculate distance from VPA to all atoms
% Determine min D and to which atom
% Compute the distane from the VPA hull element to the viral capsid.
m = 1;
[vpa_d2p,vpa_d2p_sort,pcount,pn_index,vpa_i2a] = fn_min_dist2prot(atoms,natoms_prot,nprot,vpa_sc,nvpa_hull,pcutoff);
[dist_surf(m),mrX] = min(vpa_d2p_sort(1:nvpa_hull,1) - vdw*ones(nvpa_hull,1));
atom_id_new = vpa_i2a(mrX,1);
nearest(m) = atom_id_new;
length_all(m) = length;
% Rescale VPA to min d of atom_id
vecA   = atoms(atom_id_new,1:3)'; normA  = norm(vecA);
vecV   = vpa_sc(1:3,mrX)'; normV  = norm(vecV); 
dotAV  = dot(vecA,vecV); ratio  = dotAV/(normA*normV);
theta = acos(ratio);
d_til = sin(theta)*normA;
if d_til < vdw % if moving atom would put it in the vdw radius, don't, put it so it is vdw away.
    length = normA*cos(theta) + sqrt(vdw^2 - (normA^2)*sin(theta)^2);
else
    length = normA*ratio; % new scale
end
scale  = length/maxR_vpa;
vpa_sc = scale*vpa_hull;
% Calc Distance to all atoms again.
m = m + 1;
[vpa_d2p,vpa_d2p_sort,pcount,pn_index,vpa_i2a] = fn_min_dist2prot(atoms,natoms_prot,nprot,vpa_sc,nvpa_hull,pcutoff);
[dist_surf(m),mrX] = min(vpa_d2p_sort(1:nvpa_hull,1) - vdw*ones(nvpa_hull,1));
atom_id_old = atom_id_new;
atom_id_new = vpa_i2a(mrX,1);
nearest(m) = atom_id_new;
length_all(m) = length;

% Move Outer Shell nearer Atomic Surface until a step
while (dist_surf(m) >= 0 && atom_id_old ~= atom_id_new)
    vecA   = atoms(atom_id_new,1:3)'; normA  = norm(vecA);
    vecV   = vpa_sc(1:3,mrX)'; normV  = norm(vecV); 
    dotAV  = dot(vecA,vecV); ratio = dotAV/(normA*normV);
    theta  = acos(ratio);
    d_til  = sin(theta)*normA;
    if d_til < vdw % if moving atom would put it in the vdw radius, don't, put it so it is vdw away.
        length = normA*cos(theta) + sqrt(vdw^2 - (normA^2)*sin(theta)^2);
    else
        length = normA*ratio; % new scale
    end
    % new scale
    scale  = length/maxR_vpa;
    vpa_sc = scale*vpa_hull;   
    m = m + 1;
    [vpa_d2p,vpa_d2p_sort,pcount,pn_index,vpa_i2a] = fn_min_dist2prot(atoms,natoms_prot,nprot,vpa_sc,nvpa_hull,pcutoff);
    [dist_surf(m),mrX] = min(vpa_d2p_sort(1:nvpa_hull,1) - vdw*ones(nvpa_hull,1));
    atom_id_old = atom_id_new;
    atom_id_new = vpa_i2a(mrX,1);
    nearest(m)  = atom_id_new;
    length_all(m) = length;
    if length >= .99*length_all(m)  % SHOULD BE INPUT CONTROLLED (.99)
        break
    end
end

% Next
while (dist_surf(m) < 0)
    lift   = abs(dist_surf(m));
    length = length + lift + tidbit;
    scale  = length/maxR_vpa;
    vpa_sc = scale*vpa_hull;   
    m = m + 1;
    [vpa_d2p,vpa_d2p_sort,pcount,pn_index,vpa_i2a] = fn_min_dist2prot(atoms,natoms_prot,nprot,vpa_sc,nvpa_hull,pcutoff);
    [dist_surf(m),mrX] = min(vpa_d2p_sort(1:nvpa_hull,1) - vdw*ones(nvpa_hull,1));
    atom_id_old = atom_id_new;
    atom_id_new = vpa_i2a(mrX,1);
    nearest(m) = atom_id_new;
    length_all(m) = length;
end

% Next
while dist_surf(m) > 0.1
    length = length_all(m) - dist_surf(m) - .05;
    scale = length/maxR_vpa;
    vpa_sc = scale*vpa_hull;
    m = m + 1;
    [vpa_d2p,vpa_d2p_sort,pcount,pn_index,vpa_i2a] = fn_min_dist2prot(atoms,natoms_prot,nprot,vpa_sc,nvpa_hull,pcutoff);
    [dist_surf(m),mrX] = min(vpa_d2p_sort(1:nvpa_hull,1) - vdw*ones(nvpa_hull,1));
    atom_id_new = vpa_i2a(mrX,1);
    nearest(m) = atom_id_new;
    length_all(m) = length;
    if dist_surf(m) > dist_surf(m-1)
        nearest(m) = [];
        length_all(m) = [];
        dist_surf(m) = [];
        break
    end
    if dist_surf(m) < 0
        nearest(m) = [];
        length_all(m) = [];
        dist_surf(m) = [];
        break
    end
end
        