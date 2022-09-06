function [v1vdb, v2vdb, v3vdb, v4vdb, v5vdb, v6vdb, v7vdb, v8vdb, v9vdb, v10vdb, v11vdb, v12vdb, v13vdb, v14vdb, v15vdb, v16vdb, v17vdb, v18vdb, v19vdb, v20vdb, Vvdb] = load_verts_dod_vdb()

plotmenow = 0;
[v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, V] = load_verts_dod_twa();
for m = 1:12
    Vvdb =rot2vdb(V);
end
v1vdb  = Vvdb(1:3,1);
v2vdb  = Vvdb(1:3,2);
v3vdb  = Vvdb(1:3,3);
v4vdb  = Vvdb(1:3,4);
v5vdb  = Vvdb(1:3,5);
v6vdb  = Vvdb(1:3,6);
v7vdb  = Vvdb(1:3,7);
v8vdb  = Vvdb(1:3,8);
v9vdb  = Vvdb(1:3,9);
v10vdb = Vvdb(1:3,10);
v11vdb = Vvdb(1:3,11);
v12vdb = Vvdb(1:3,12);
v13vdb = Vvdb(1:3,13);
v14vdb = Vvdb(1:3,14);
v15vdb = Vvdb(1:3,15);
v16vdb = Vvdb(1:3,16);
v17vdb = Vvdb(1:3,17);
v18vdb = Vvdb(1:3,18);
v19vdb = Vvdb(1:3,19);
v20vdb = Vvdb(1:3,20);
Vvdb = [v1vdb, v2vdb, v3vdb, v4vdb, v5vdb, v6vdb, v7vdb, v8vdb, v9vdb, v10vdb, v11vdb, v12vdb, v13vdb, v14vdb, v15vdb, v16vdb, v17vdb, v18vdb, v19vdb, v20vdb];

if plotmenow == 1
    NV = calc_adj(V);
    NVvdb = calc_adj(Vvdb);
    figure
    %plot3d(V,'g.')
    hold on
    plot3d(Vvdb,'b.')
    %gplot3(NV,V,'g')
    gplot3(NVvdb,Vvdb,'b')
    xlabel('x')
    ylabel('y')
    zlabel('z')
    grid on
end