function [ipp] = fn_buildipp(app,Tnum,nprot)
p = 1;
for m = 1:nprot
    z = mod(m,numel(app));
    if z == 0
        z = Tnum;
    end
    ipp(m,1) = p; p = p + app(z);
    ipp(m,2) = ipp(m,1) + app(z) - 1;
end