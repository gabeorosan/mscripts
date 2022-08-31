function [w1, w2, w3, w4, w5, w6, w7, w8, w9, w10, w11, w12, W] = load_verts_ico_twa()
% 12 Vertices of the Icosahedron 
Q = 0.5*(1 + sqrt(5));
w1 = [ Q; 1; 0];
w2 = [ 0; Q; 1];
w3 = [ 1; 0; Q];
w4 = [ Q;-1; 0];
w5 = [ 1; 0;-Q];
w6 = [ 0; Q;-1];
w7 = -w4;
w8 = -w5;
w9 = -w6;
w10 = -w2;
w11 = -w3;
w12 = -w1;

W = [w1, w2, w3, w4, w5, w6, w7, w8, w9, w10, w11, w12];