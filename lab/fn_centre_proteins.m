function [loc] = fn_centre_proteins(au,ipp,Tnum)
for m = 1:Tnum
    test = au(ipp(m,1):ipp(m,2),:);
    loc(m,1:3) = mean(test);
end