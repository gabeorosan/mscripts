function fn_add2plot_auvol(R)
digits = 1E3;
[u1, u2, u3, u4, u5, u6, u7, u8, u9, u10, u11, u12, u13, u14, u15, u16, u17, u18, u19, u20, u21, u22, u23, u24, u25, u26, u27, u28, u29, u30, U] = load_verts_idd_vdb();
[v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, V] = load_verts_dod_vdb();
[w1, w2, w3, w4, w5, w6, w7, w8, w9, w10, w11, w12, W] = load_verts_ico_vdb();
rw1 = norm(w1);
rv2 = norm(v2);
rv3 = norm(v3);
f1.vertices = [0,0,0;R/rw1*w1';R/rv2*v2';R/rv3*v3'];
f1.faces = [1,2,3];
f2.vertices = f1.vertices;
f2.faces = [1,2,4];
f3.vertices = f1.vertices;
f3.faces = [1,3,4];

hold on
patch(f1,'facecolor',[0 0 1],'EdgeColor','black');
alpha(0.4)
hold on
patch(f2,'facecolor',[1 1 0],'EdgeColor','black');
alpha(0.4)
patch(f3,'facecolor',[1 1 0],'EdgeColor','black');
alpha(0.4)
xlabel('x')
ylabel('y')
zlabel('z')
