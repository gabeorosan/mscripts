function [w1vdb, w2vdb, w3vdb, w4vdb, w5vdb, w6vdb, w7vdb, w8vdb, w9vdb, w10vdb, w11vdb, w12vdb, Wvdb] = load_verts_ico_vdb()
%%
plotmenow = 0;

[w1, w2, w3, w4, w5, w6, w7, w8, w9, w10, w11, w12, W] = load_verts_ico_twa();

Wvdb = rot2vdb(W);

w1vdb  = Wvdb(1:3,1);
w2vdb  = Wvdb(1:3,2);
w3vdb  = Wvdb(1:3,3);
w4vdb  = Wvdb(1:3,4);
w5vdb  = Wvdb(1:3,5);
w6vdb  = Wvdb(1:3,6);
w7vdb  = Wvdb(1:3,7);
w8vdb  = Wvdb(1:3,8);
w9vdb  = Wvdb(1:3,9);
w10vdb = Wvdb(1:3,10);
w11vdb = Wvdb(1:3,11);
w12vdb = Wvdb(1:3,12);

Wvdb = [w1vdb, w2vdb, w3vdb, w4vdb, w5vdb, w6vdb, w7vdb, w8vdb, w9vdb, w10vdb, w11vdb, w12vdb];
if plotmenow == 1
    NW = calc_adj(W);
    NWvdb = calc_adj(Wvdb);
    figure
    plot3d(W,'g.')
    hold on
    plot3d(Wvdb,'b.')
    gplot3(NW,W,'g')
    gplot3(NWvdb,Wvdb,'b')
    xlabel('x')
    ylabel('y')
    zlabel('z')
    grid on
end

