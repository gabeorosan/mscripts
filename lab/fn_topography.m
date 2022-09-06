function [group_au,group,com_all,Rcom,Rmax_all,Natoms_all,nu_all,Rsurf,Rcom_back] = fn_topography(atoms,seglist,mkplots,min_atoms)

usextra = 1; % uses Neighboring AU areas, I need to "speed it up" to only include relevant areas.
%% Determine the Surface Radius via Phi/Psi Map ALL ATOMS
% Create a 1/60th section of the full capsid.
atoms_au = fn_section_au_vdb(atoms'); atoms_au = atoms_au';
Rave = calc_radii(mean(atoms_au));
r_atoms_au  = calc_radii(atoms_au); natoms_au  = numel(r_atoms_au);
maxR_atoms_au = max(r_atoms_au);
% Separate Off the Top Half of the 1/60th section.
top = [];
for m = 1:natoms_au
    if r_atoms_au(m) > Rave
        top = [top; atoms_au(m,:)];
    end
end
rtop = calc_radii(top); 
ntop = numel(rtop);

% Define angular wedges criteria
mu = 0.0480; % Mean of angular differences between gauge points not on symm axes.
%min_atoms = 10; % Min number of atoms for a wedge to be considered. (NOW
%INPUT).
for m = 1:ntop
    x = top(m,1); y = top(m,2); z = top(m,3); 
    theta = atan(x/z); phi = asin(y/rtop(m)); 
    au_angle(m,1) = rtop(m);
    au_angle(m,2) = phi;
    au_angle(m,3) = theta;
end
% These values are not the triangular wedge, but the proximity to it.
% %CBI: use plane's values
minPhi = min(au_angle(:,2)); maxPhi = max(au_angle(:,2));
minTheta = min(au_angle(:,3)); maxTheta = max(au_angle(:,3));
phi_range = maxPhi - minPhi; theta_range = maxTheta - minTheta;

ss = 1; 
QQmax = ceil(max(phi_range,theta_range)/mu);
clear Rsurf_sweep Rsurf_swmin atspercell QQotro QQotro
% Spherical Mesh/wedges on Capsid
for QQ = (QQmax-4):1:QQmax
    binP = QQ; binT = QQ; %beta(1) = minPhi;
    phi_bin   = minPhi:(phi_range/binP):maxPhi;
    theta_bin = minTheta:(theta_range/binT):maxTheta;
    clear bloc bin
    for m = 1:binP
        for n = 1:binT
            bloc(m,n).list = [];
        end
    end
    for m = 1:ntop
        for n = 1:binP
            for p = 1:binT
                if ((au_angle(m,2) >= phi_bin(n)) && (au_angle(m,2) <= phi_bin(n+1)))
                    if ((au_angle(m,3) >= theta_bin(p)) && (au_angle(m,3) <= theta_bin(p+1)))
                        temp = bloc(n,p).list;
                        bloc(n,p).list = [temp,m];
                    end
                end
            end
        end
    end
    q = 1; clear alpha gamma nabla Natcell H J 
    for n = 1:binP
        for p = 1:binT
            temp = bloc(n,p).list;
            if numel(temp) ~= 0 && numel(temp) >= min_atoms;
                rcell_temp = au_angle(temp,1);
                meanR      = mean(rcell_temp);
                thickness  = max(rcell_temp) - min(rcell_temp);
                height     = max(rcell_temp) - mean(rcell_temp);
                rcell      = max(rcell_temp);
                phi_temp   = au_angle(temp,2);
                phi_cell   = mean(phi_temp);
                theta_temp = au_angle(temp,3);
                theta_cell = mean(theta_temp);
                y = rcell*sin(phi_cell);
                z = rcell*cos(phi_cell)*cos(theta_cell);
                x = rcell*cos(phi_cell)*sin(theta_cell);
                H(q) = max(rcell_temp);
                J(q) = mean(rcell_temp);
                alpha(q,1:3) = [theta_cell,phi_cell,H(q)];
                gamma(q,1:3) = [theta_cell,phi_cell,numel(bloc(n,p).list)];
                nabla(q,1:3) = [theta_cell,phi_cell,J(q)];
                Natcell(q)   = numel(bloc(n,p).list);
                q = q + 1;
            end
        end
    end
    Rsurf_ave(ss)   = mean(J);
    Rsurf_sweep(ss) = mean(H);
    Rstd_sweep(ss)  = std(H);
    Rsurf_swmin(ss) = min(H);
    atspercell(ss)  = mean(Natcell);
    QQotro(ss).a    = sort(H);
    QQotro(ss).b    = sort(J);
    ss = ss + 1;
end
Rsurf   = mean(Rsurf_sweep);

% % Spherical Coords for AU
% for m = 1:nau
%     x = au(m,1); y = au(m,2); z = au(m,3);
%     au_ang(m,1) = r_au(m);
%     au_ang(m,2) = asin(y/r_au(m)); %PHI
%     au_ang(m,3) = atan(x/z); % THETA
% end

if mkplots == 1
% Plot 1: AU-Section
    figure; 
    subplot(1,2,1);
    plot3d(atoms_au,'k:'); 
    hold on; 
    plot3d(top,'b.')
%     plot3d(au,'k-'); 
    fn_add2plot_auvol(Rave)
    grid on
    title('AU-Section')

% Plot 2: AU section with Angular Sections
    subplot(1,2,2);
    plot3d(alpha,'r*')
    hold on
    %plot3(au_ang(:,3),au_ang(:,2),au_ang(:,1),'k:')
    %plot3d(nabla,'bs')
    plot3(au_angle(:,3),au_angle(:,2),au_angle(:,1),'g.')
    %axis([-.45 .45 0 0.55 minR_au maxR_au])
    grid on
end
%% Make Groups
top_surf = [];
for m = 1:natoms_au
    if r_atoms_au(m) > Rsurf
        top_surf = [top_surf; atoms_au(m,:)];
    end
end
top_surf_keep = top_surf;
% Extra Atoms

if usextra == 1
    top_extra = fn_apply_icos3d_rots(top_surf,seglist);
    top_surf = top_extra;
    r_top_surf = calc_radii(top_surf);
    nts = numel(r_top_surf);
end
if nts/natoms_au < 0.01
    disp('Not enough atoms above cutoff?')
end

nu = 0.0748; %nu = 0.1449
%SymAxes = [5,2,31,32];
cutlow = (maxR_atoms_au + Rsurf)/2 %%%% REMOVE -1 %%%%

peak_surface = fn_section_au_vdb(top_extra');
peak_surface = peak_surface';
r_peak_surface = calc_radii(peak_surface);
%[npeaks,o] = size(peak_surface);

%[peak,sym] = fn_get_peak(npeaks,r_peak_surface,peak_surface,cutlow);
[val,id] = max(r_peak_surface);
peak = peak_surface(id,:);
nu_max = .15;

j = 1; 
otroR = calc_radii(peak);
others = top_surf;
%
while otroR > cutlow
    [keep,nts_clusta,com_keep,others,nts_others,nu_com] = fn_cluster_angle(nu,nu_max,peak,others);
    rkeep = calc_radii(keep);
%     com_keep = mean(keep);       % New Definition
%     [nts_clusta,o] = size(keep); % New Definition
    if nts_clusta < min_atoms
        r_others = calc_radii(others);
        [otroR,ind] = max(r_others);
        peak = others(ind,:);
        continue
    end    
    group(j).atoms = keep;
    group(j).peak  = peak;
    group(j).nu    = nu_com;
    group(j).nts   = nts_clusta;
    group(j).com   = com_keep;
    group(j).Rcom  = calc_radii(com_keep);
    group(j).Rmax  = max(rkeep);
    group(j).Rmin  = min(rkeep);

    % GET NEW PEAK
    if numel(others) == 0
        break
    end

    peak_others = fn_section_au_vdb(others'); peak_others = peak_others';
    if numel(peak_others) == 0
        break
    end
    r_others = calc_radii(peak_others);
    [otroR,ind] = max(r_others);
    peak = others(ind,:);
    %sym_angles  = fn_det_near_sym_axis(peak);
    %[theta,sym] = min(sym_angles);
    %temp = SymAxes(sym);
    j = j + 1;
    if otroR < cutlow
        break
    end
end
Ng = j - 1;
if mkplots == 1
    figure
    subplot(2,2,1);
    hold all
    for j = 1:Ng
        plot3d(group(j).atoms,'.')
    end
    fn_add2plot_auvol(Rsurf)
    axis equal
end
back_group = group;
%% Resolve Conflicts
group = back_group; Ng = max(size(group));
verboten =[];
for m = 1:Ng
    for n = (m+1):Ng
        if ismember(n,verboten)
            continue
        end        
        set1 = group(m).atoms; nu1 = group(m).nu; 
        set2 = group(n).atoms; nu2 = group(n).nu; 
        [set1,set2,nu1,nu2,changed] = fn_resolve_overlaps(set1,set2,nu1,nu2);
        if changed == 0
            continue
        end
        p = 1;
        while changed == 1 && numel(set2) ~= 0
            [set1,set2,nu1,nu2,changed] = fn_resolve_overlaps(set1,set2,nu1,nu2);
            if numel(set2) == 0 || (p > 10)
                break
            end            
            p  = p + 1;
        end
        N = max(size(set1));
        group(m).atoms = set1;
        group(m).peak = group(m).peak;
        group(m).nu = nu1;
        group(m).nts = N;
        group(m).com = mean(set1);
        group(m).Rcom = calc_radii(group(m).com);

        if numel(set2) == 0
            disp('merged')
            verboten = [verboten;n];
            break
        else
            N = max(size(set2));
            group(n).atoms = set2;
            group(n).peak = group(n).peak;
            group(n).nu = nu2;
            group(n).nts = N;
            group(n).com = mean(set2);
            group(n).Rcom = calc_radii(group(n).com);
        end
    end
end
Ng = Ng - numel(verboten);  
group(verboten) = [];

if mkplots == 1
    subplot(2,2,2);
    hold all
    for j = 1:Ng
        plot3d(group(j).atoms,'.')
    end
    fn_add2plot_auvol(Rsurf)
    axis equal
end

% Trim Groups
if mkplots == 1
    subplot(2,2,3);
    hold all
end
for j = 1:Ng
    % "Trim" groups AFTER merging them
    keep = group(j).atoms;
    if mkplots == 1
        plot3d(keep,'.')
    end
    [keep,drop1,cutoff_ang] = fn_break_off_angle(keep,nu_max);    
    [nu_com] = fn_compute_nu(keep);
    [keep,drop2,cutoff_rad] = fn_break_off_stem(keep);
    %[keep,drop2,cutoff_ang] = fn_break_off_angle(keep,nu_max);
    if numel(drop2) > 0
        rdrop2 = calc_radii(drop2');
    else
        rdrop2 = 0;
    end
    com_keep = mean(keep);
    
    if numel(drop1) > 0 && mkplots == 1
       plot3d(drop1','ms')
    end
    if numel(drop2) > 0 && mkplots == 1
       plot3d(drop2','ks')
    end
    N = max(size(keep));
    nu_com = fn_compute_nu(keep);
    group(j).atoms = keep;
    group(j).peak = group(j).peak;
    group(j).nu = nu_com;
    group(j).nts = N;
    group(j).com = com_keep;
    group(j).Rcom = calc_radii(com_keep);
    group(j).drop_ang = drop1;
    group(j).drop_stm = drop2;
    group(j).Rdrop2 = max(rdrop2);
    
    Rcom_all(j) = group(j).Rcom;
    com_all(j,:) = com_keep;
end
if mkplots == 1
    fn_add2plot_auvol(Rsurf)
    axis equal
end

kick = [];
for j = 1:Ng
    if group(j).nts <= min_atoms
        kick = [kick,j];
    end
end
group(kick) = [];
Ng = Ng - numel(kick);

%% Keep ONLY AUS
A = fn_dist2planes(com_all');
p = 1;
kick = [];
if mkplots == 1
    subplot(2,2,4); 
    hold all
end
for m = 1:Ng
    if A(m,1) < -.10 || A(m,2) < -.10 || A(m,3) < -.10
        kick(p) = m;
        p = p + 1;
    else
        if mkplots == 1
            plot3d(group(m).atoms,'.')
            plot3d(group(m).com,'r*')
        end
    end
end
kick
clear com_all
if mkplots == 1
    fn_add2plot_auvol(Rsurf)
    axis equal
end
group_au = group; group_au(kick) = [];
% BUILD AT END

[o,Ng] = size(group_au);

for j = 1:Ng
    com_all(j,:)  = group_au(j).com;
    Rcom(j)       = group_au(j).Rcom;
    Rmax_all(j)   = group_au(j).Rmax;
    Natoms_all(j) = group_au(j).nts;
    nu_all(j)     = group_au(j).nu;
end
Rcom_back = Rcom;
Rcutz = (max(Rcom) + Rsurf)/2;

kick = [];
for j = 1:Ng
    if Rcom(j) < Rcutz
        disp(['Dropped feature, group = ',int2str(j)])
        kick = [kick,j];
    end
end
kick
group_au(kick) = [];
com_all(kick,:) = [];
Rcom(kick) = [];
Rmax_all(kick) = [];
[o,Ng] = size(group_au);
if mkplots == 1
    figure
    subplot(1,2,1);
    plot3d(top_surf_keep,'.')
    hold all
    for j = 1:Ng
        plot3d(group_au(j).atoms,'o')
        plot3d(group_au(j).com,'k*')
        plot3d(group_au(j).com,'cs')
    end
%    fn_add2plot_auvol(Rsurf)
    %axis equal
    subplot(1,2,2)
    hold all
    for j = 1:Ng        
        plot3d(group_au(j).atoms,'.')
        plot3d(group_au(j).com,'g*')
        if numel(group_au(j).drop_ang) ~= 0
            plot3d(group_au(j).drop_ang','rx')
        end
        if numel(group_au(j).drop_stm) ~= 0
            plot3d(group_au(j).drop_stm','kv')
        end
        %axis equal
    end
end


