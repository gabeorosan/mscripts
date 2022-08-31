function [W,adjW] =fn_load_ICO()
% Verified by hand Aug 19 2019
q = .5*(sqrt(5)+1);
w1  = [ 0, 1, q]';
w2  = [ 0,-1, q]';
w3  = [ q, 0, 1]';
w4  = [-q, 0, 1]';
w5  = [ 1, q, 0]';%b*w4
w6  = [-1,-q, 0]';%-w5;
w7  = [ 1,-q, 0]';% b*w5;
w8  = [-1, q, 0]';%a*w7;
w9  = [ q, 0,-1]';%b*w8;
w10 = [-q, 0,-1]';%a*w9;
w11 = [ 0, 1,-q]';% b*w10
w12 = [ 0,-1,-q]';% a*w11
W = [w1';w2';w3';w4';w5';w6';w7';w8';w9';w10';w11';w12'];
adjW = calc_adj(W);
