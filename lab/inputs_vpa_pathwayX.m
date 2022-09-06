function [convex,beads,shells,pcutoff,vdw,tol,digits,top_per,use_pmult,X2,outer_topo_only,Xfrac,NP] = inputs_vpa_pathwayX(Tnum)
%% Build Different Sets of Inputs per type of run.
Xfrac = 0.025;
% input settings
beads = 29; 
convex = 0;
digits = 1E4; 
outer_topo_only = 1;
pcutoff = 5.0; 
NP = 2; % NUMBER OF LEVELS TO INCLUDE * CONSIDER REMOVING *

shells = 1:55;
tol = 0.05;
top_per = 0.05;

use_pmult = 1; 
vdw = 1.5; % Reduced from C radius.
X2 = 1; % 1 means minR, 0.90 means 90% and above
%shells = [7,14,22,23,34,35];
