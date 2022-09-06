function [rmsd_shunt,step] = fn_detect_pocket(rmsd_sweep)
%%
N = numel(rmsd_sweep);
pocket = zeros(1,N);
for m = 1:N
    if rmsd_sweep(m) == 999
        pocket(m) = 1;
    end
end
backpocket = pocket;
p = 1;
clear poss rmsd
for m = 2:(N-1)
    range = (m-1):(m+1);
    test = pocket(range);
    if sum(test) == 0
        rmsd(p) = rmsd_sweep(m);
        poss(p) = m;
        p = p + 1;
    end
end   
% for m = 1:N
%     if m == 1
%         range = (m):(m+4);
%     elseif m == 2
%         range = (m-1):(m+3);
%     elseif ( m > 2 && m < (N-1) )
%         range = (m-2):(m+2);
%     elseif m == (N-1)
%         range = (m-3):(m+1);
%     elseif m == N
%         range = (m-4):m;
%     else
%         disp('oop')
%     end
%     test = pocket(range);
%     if sum(test) == 0
%         rmsd(p) = rmsd_sweep(m);
%         poss(p) = m;
%         p = p + 1;
%     end
% end   
if exist('rmsd','var') == 1
    [rmsd_shunt,stepx] = min(rmsd);
    step = poss(stepx);
else
    rmsd_shunt = 999;
    step = 1;
    disp('dead array')
end
% figure
% plot(rmsd_sweep,'.')
% hold on
% plot(poss,rmsd_sweep(poss),'ro')
% axis([0 100 0 10])