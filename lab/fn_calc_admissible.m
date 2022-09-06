function [temp_admin,dist_admin,ang_gp_centre,dist_gp_centre] = fn_calc_admissible(centre,nu_cut,top_hulls,j,ang_gp_centre,dist_gp_centre)
temp_admin = [];
dist_admin = [];
for k = 1:21
    [o,N] = size(top_hulls(k).gaugepoints);
    for m = 1:N
        gvec = top_hulls(k).gaugepoints(:,m);
        ang(m) = fn_angle_btwn_AB(centre,gvec);
        dist(m) = fn_distanceA2B(centre',gvec);
    end
    ang_gp_centre(j,k) = min(ang); ang = [];
    dist_gp_centre(j,k) = min(dist); dist = [];
    if ang_gp_centre(j,k) <= nu_cut
        temp_admin = [temp_admin,k];
        dist_admin = [dist_admin,dist_gp_centre(j,k)];
    end
end