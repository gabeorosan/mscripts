function [clusta,nts_clusta,com_clusta,others,nts_others,nu_com] = fn_cluster_angle(nu,nu_max,peak,top_surf)
%%
clear clusta
p = 1;
[nts,o] = size(top_surf);
for m = 1:nts
    temp  = top_surf(m,:);
    theta = acos(dot(temp,peak)/(norm(peak)*norm(temp)));
    if(theta <= nu)
        clusta(p,:) = top_surf(m,:);
        members(p) = m;
        p = p + 1;
    end
end
com = mean(clusta);
others = top_surf;
others(members,:) = [];
[nts_clusta,o] = size(clusta);
[nts_others,o] = size(others);
if nts ~= nts_others
    more = 0;
else
    more = 1;
end
% figure
% plot3d(clusta,'ro')
% hold on
% plot3d(others,'g.')

nu_temp = nu;
% Grow Cluster
flag = 0;
while more == 0    
    clear theta
    n_temp = nts_others;
    members = [];
    pp = 1;
    for m = 1:nts_others
        temp = others(m,:);
        theta = acos(dot(temp,com)/(norm(temp)*norm(com)));
        if(theta <= nu_temp)
            clusta(p,:) = others(m,:);
            members(pp) = m;
            p  = p + 1;
            pp = pp + 1;
        end
    end
    r_clusta = calc_radii(clusta);
    com = mean(clusta);
    others(members,:) = []; %% HERE
    [nts_clusta,o] = size(clusta);
    [nts_others,o] = size(others);
    clear angles
    for m = 1:nts_clusta
        temp = clusta(m,:);
        angles(m) = fn_angle_btwn_AB(com,temp);
    end
    maxA = max(angles);
    nu_temp = ceil(100*max(nu,maxA))/100;
    %nu_temp = max(nu,maxA);
    if nu_temp > nu_max
        nu_temp = nu_max;
        flag = 1;
    end
    if n_temp ~= nts_others
        more = 0;
    else
        more = 1;
    end
%     figure
%     plot3d(clusta,'ro')
%     hold on
%     plot3d(others,'g.')
%     axis equal
end
if flag == 1
    clusta = []; members = []; nu_temp2 = [];
    for m = 1:nts
        temp  = top_surf(m,:);
        theta = acos(dot(temp,com)/(norm(com)*norm(temp)));
        if(theta <= nu_max)
            clusta = [clusta; top_surf(m,:)];
            members = [members;m];
            nu_temp2 = [nu_temp2;theta];
        end
    end
    others = top_surf;
    others(members,:) = [];
    com =  mean(clusta);
    [nts_clusta,o] = size(clusta);
    [nts_others,o] = size(others);
    nu_temp = max(nu_temp2);
end
    
com_clusta = com;
nu_com = nu_temp;