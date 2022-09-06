function [vpa_au] = fn_section_au_vdb(vpa3N)
%%
[m,nvpa3N] = (size(vpa3N));
%[m,n] = size(vpa3N);
if m ~= 3
    vpa3N = vpa3N';
    [m,nvpa3N] = (size(vpa3N));
end
vpa_au = [];
[u1, u2, u3, u4, u5, u6, u7, u8, u9, u10, u11, u12, u13, u14, u15, u16, u17, u18, u19, u20, u21, u22, u23, u24, u25, u26, u27, u28, u29, u30, U] = load_verts_idd_vdb();
[v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, V] = load_verts_dod_vdb();
[w1, w2, w3, w4, w5, w6, w7, w8, w9, w10, w11, w12, W] = load_verts_ico_vdb();

N2   = -[ (v2(2)*w1(3)-v2(3)*w1(2));
          (v2(3)*w1(1)-v2(1)*w1(3));
          (v2(1)*w1(2)-v2(2)*w1(1))];
N3   =  [ (v3(2)*w1(3)-v3(3)*w1(2));
          (v3(3)*w1(1)-v3(1)*w1(3));
          (v3(1)*w1(2)-v3(2)*w1(1))];
threshold = -0.05;
vpa = vpa3N'; % vpa is 3 x N
i = 1; 
[nvpa,x] = size(vpa);
for m = 1:nvpa
    d1(m) = vpa(m,2);
    d2(m) = (N2(1)*vpa(m,1) + N2(2)*vpa(m,2) + N2(3)*vpa(m,3))/sqrt(N2(1)^2+N2(2)^2+N2(3)^2);  
    d3(m) = (N3(1)*vpa(m,1) + N3(2)*vpa(m,2) + N3(3)*vpa(m,3))/sqrt(N3(1)^2+N3(2)^2+N3(3)^2);
    if ( d1(m) >= threshold && d2(m) >= threshold && d3(m) >= threshold )   
        vpa_au(i,1:3) = vpa(m,1:3);
        i = i + 1;
    end
end 
vpa_au = vpa_au';