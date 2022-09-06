function [Qt] = fn_apply_icos3d_rots(vecsN3,list)
%
M3    = build_icos3d();
Nrots = numel(list);
Qt = [];
for m = 1:Nrots
    x   = list(m);
    rot = M3(:,:,x);
    Q   = rot*vecsN3';
    Qt  = [Qt,Q];
end
Qt = Qt';