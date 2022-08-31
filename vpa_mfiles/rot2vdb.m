function [vpa_rot] = rot2vdb(vpa,digits)
test = exist('digits','var');
if test == 0
    digits = 1E4;
else
    digits = 10^digits;
end
[m,n] = size(vpa);
Y = [0,0,-1; 0,1,0; 1,0,0]; %transpose = inverse.
nvpa = n;
if m ~= 3
    vpa = vpa';
    nvpa = m;
end
for i = 1:nvpa
    vpa_rot(1:3,i) = Y*vpa(1:3,i);
end
vpa_rot = round(vpa_rot*digits)/digits;