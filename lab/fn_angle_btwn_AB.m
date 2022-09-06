function [angle] = fn_angle_btwn_AB(vecA,vecB,digits)
if exist('digits','var') == 0
    digits = 1e5;
end
vecA = round(digits*vecA)/digits;
vecB = round(digits*vecB)/digits;
angle = acos(dot(vecA,vecB)/(norm(vecA)*norm(vecB)));
angle = round(digits*angle)/digits;