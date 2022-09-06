function [u1vdb, u2vdb, u3vdb, u4vdb, u5vdb, u6vdb, u7vdb, u8vdb, u9vdb, u10vdb, u11vdb, u12vdb, u13vdb, u14vdb, u15vdb, u16vdb, u17vdb, u18vdb, u19vdb, u20vdb, u21vdb, u22vdb, u23vdb, u24vdb, u25vdb, u26vdb, u27vdb, u28vdb, u29vdb, u30vdb, Uvdb] = load_verts_idd_vdb()
%%
plotmenow = 0;
[u1, u2, u3, u4, u5, u6 u7, u8, u9, u10, u11, u12, u13, u14, u15, u16, u17, u18, u19, u20, u21, u22, u23, u24, u25, u26, u27, u28, u29, u30, U] = load_verts_idd_twa();
for m = 1:12
    Uvdb = rot2vdb(U);
end
u1vdb  = Uvdb(1:3,1);
u2vdb  = Uvdb(1:3,2);
u3vdb  = Uvdb(1:3,3);
u4vdb  = Uvdb(1:3,4);
u5vdb  = Uvdb(1:3,5);
u6vdb  = Uvdb(1:3,6);
u7vdb  = Uvdb(1:3,7);
u8vdb  = Uvdb(1:3,8);
u9vdb  = Uvdb(1:3,9);
u10vdb = Uvdb(1:3,10);
u11vdb = Uvdb(1:3,11);
u12vdb = Uvdb(1:3,12);
u13vdb = Uvdb(1:3,13);
u14vdb = Uvdb(1:3,14);
u15vdb = Uvdb(1:3,15);
u16vdb = Uvdb(1:3,16);
u17vdb = Uvdb(1:3,17);
u18vdb = Uvdb(1:3,18);
u19vdb = Uvdb(1:3,19);
u20vdb = Uvdb(1:3,20);
u21vdb = Uvdb(1:3,21);
u22vdb = Uvdb(1:3,22);
u23vdb = Uvdb(1:3,23);
u24vdb = Uvdb(1:3,24);
u25vdb = Uvdb(1:3,25);
u26vdb = Uvdb(1:3,26);
u27vdb = Uvdb(1:3,27);
u28vdb = Uvdb(1:3,28);
u29vdb = Uvdb(1:3,29);
u30vdb = Uvdb(1:3,30);

Uvdb = [u1vdb, u2vdb, u3vdb, u4vdb, u5vdb, u6vdb, u7vdb, u8vdb, u9vdb, u10vdb, u11vdb, u12vdb, u13vdb, u14vdb, u15vdb, u16vdb, u17vdb, u18vdb, u19vdb, u20vdb, u21vdb, u22vdb, u23vdb, u24vdb, u25vdb, u26vdb, u27vdb, u28vdb, u29vdb, u30vdb];
if plotmenow == 1
    NU = calc_adj(U);
    NUvdb = calc_adj(Uvdb);
    figure
    plot3d(U,'g.')
    hold on
    plot3d(Uvdb,'b.')
    gplot3(NU,U,'g')
    gplot3(NUvdb,Uvdb,'b')
    xlabel('x')
    ylabel('y')
    zlabel('z')
    grid on
end