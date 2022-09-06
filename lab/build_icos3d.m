function [M] = build_icos3d()
digits = 1e40;
%% Generating the 3d Icosahedral Group Rotations for the AU
% 3d Vertices of the Icosahedron.               
%clear; clc; close all;
t = 0.5*(sqrt(5) + 1);
u = 1/sqrt(t^2-2*t+2);
v = u*(t-1);
vec = 0:.25:1;
% Hexagon from notes
v1 = [ v; 0; u]; v2 = [-v; 0; u]; v3 = [ 0; u; v]; v4 = [ u; v; 0];
v5 = [ u;-v; 0]; v6 = [ 0;-u; v]; 
% Remaining vertices.
v7  = [-u; v; 0]; v8  = [ 0; u;-v]; v9 = [ v; 0;-u]; v10 = [ 0;-u;-v];
v11 = [-u;-v; 0]; v12 = [-v; 0;-u];
A = (v1 + v2 + v6)/norm(v1 + v2 + v3); 
B = (v1 + v2 + v3)/norm(v1 + v2 + v3);
C = (v1 + v5 + v6)/norm(v1 + v2 + v3);
%% Rotate V1 and V2 from XZ plane to YZ plane per Viperdb Convention (3fold in YZ plane to XZ plane)
% Intitially v1 and v2 are oriented in the XZ plane.  We rotate them such
% that they are now in the YZ plane to align v1 and v2 with the viperdb
% orientation.  The v1 vector is the 5-fold axis of the AU.
theta = pi/2;
rotA = [cos(theta), -sin(theta), 0; sin(theta), cos(theta),0; 0,0,1];
v1_a = rotA*v1; v2_a = rotA*v2; v3_a = rotA*v3; v4_a = rotA*v4;
v5_a = rotA*v5; v6_a = rotA*v6; v7_a = rotA*v7; v8_a = rotA*v8;
v9_a = rotA*v9; v10_a = rotA*v10; v11_a = rotA*v11; v12_a = rotA*v12;
A_a = (v1_a + v2_a + v6_a)/norm(v1_a + v2_a + v3_a);
B_a = (v1_a + v2_a + v3_a)/norm(v1_a + v2_a + v3_a);
C_a = (v1_a + v5_a + v6_a)/norm(v1_a + v2_a + v3_a);
%% Rotate 3fold in XZ plane to align with Z-axis.
% Rotate theta2 about the Y axis.
theta2 = acos((A_a)'*[0;0;1]);
rotB = [cos(theta2), 0, -sin(theta2); 
                  0, 1,           0;
        sin(theta2), 0,  cos(theta2)];
A_b = rotB*A_a;
v1z = rotB*v1_a;  v2z = rotB*v2_a; v3z = rotB*v3_a; v4z = rotB*v4_a;
v5z = rotB*v5_a;  v6z = rotB*v6_a; v7z = rotB*v7_a; v8z = rotB*v8_a;
v9z = rotB*v9_a; v10z = rotB*v10_a; v11z = rotB*v11_a; v12z = rotB*v12_a;
%% Rotate 2pi/3 about the Z axis.
theta3 = -2*pi/3;
rotC = [cos(theta3), -sin(theta3), 0;
        sin(theta3),  cos(theta3), 0;
                  0,            0, 1];
              
Ab  = rotC*A_b;
v1b = rotC*v1z;  v2b = rotC*v2z;   v3b = rotC*v3z;   v4b = rotC*v4z;
v5b = rotC*v5z;  v6b = rotC*v6z;   v7b = rotC*v7z;   v8b = rotC*v8z;
v9b = rotC*v9z; v10b = rotC*v10z; v11b = rotC*v11z; v12b = rotC*v12z;
%% Generators (a and b)
a = [ -1, 0, 0; 0, -1, 0; 0, 0, 1];
b = (rotB')*rotC*rotB;
%% ALL 3d Icosahedral Matrices.
% P001:  1, 6,15,26, 9
M(:,:,1)  = a*a;                     % 1)  
M(:,:,2)  = b*a;                     % 6)
M(:,:,3)  = b*a*b*a;                 %15)
M(:,:,4)  = a*b*b*a*b*b;             %26)
M(:,:,5)  = a*b*b;                   % 9)
% P002:  3, 7,22,36,14
M(:,:,6)  = b;                       % 3)
M(:,:,7)  = b*b*a;                   % 7)
M(:,:,8)  = b*b*a*b*a;               %22)
M(:,:,9)  = b*a*b*b*a*b*b;           %36)
M(:,:,10) = b*a*b*b;                 %14)
% P003:  5, 2, 8,16,17
M(:,:,11) = b*b;                     % 5)
M(:,:,12) = a;                       % 2)
M(:,:,13) = a*b*a;                   % 8)
M(:,:,14) = a*b*a*b*a;               %16)
M(:,:,15) = b*b*a*b*b;               %17)
% P004:  4,13,29,39,18
M(:,:,16) = a*b;                     % 4)
M(:,:,17) = a*b*b*a;                 %13)
M(:,:,18) = a*b*b*a*b*a;             %29)
M(:,:,19) = a*b*a*b*b*a*b*b;         %39)
M(:,:,20) = a*b*a*b*b;               %18)
% P005: 19,20,34,48,40
M(:,:,21) = a*b*b*a*b;               %19)
M(:,:,22) = b*a*b*a*b;               %20)
M(:,:,23) = b*a*b*a*b*b*a;           %34)
M(:,:,24) = b*a*b*a*b*b*a*b*a;       %48)
M(:,:,25) = a*b*b*a*b*a*b*b;         %40)
% P006: 10,21,35,50,27
M(:,:,26) = b*a*b;                   %10)
M(:,:,27) = b*a*b*b*a;               %21)
M(:,:,28) = b*a*b*b*a*b*a;           %35)
M(:,:,29) = b*a*b*b*a*b*a*b*a;       %50)
M(:,:,30) = b*a*b*a*b*b;             %27)
% P007: 28,24,37,55,49 
M(:,:,31) = b*a*b*b*a*b;             %28)
M(:,:,32) = b*b*a*b*a*b;             %24)
M(:,:,33) = b*b*a*b*a*b*b*a;         %37)
M(:,:,34) = b*b*a*b*a*b*b*a*b*a;     %55)
M(:,:,35) = b*a*b*b*a*b*a*b*b;       %49)
% P008: 12,23,38,56,33 
M(:,:,36) = b*b*a*b;                 %12) 
M(:,:,37) = b*b*a*b*b*a;             %23) 
M(:,:,38) = b*b*a*b*b*a*b*a;         %38)
M(:,:,39) = a*b*a*b*a*b*b*a*b*a;     %56) 
M(:,:,40) = b*b*a*b*a*b*b;           %33) 
% P009: 11,25,43,51,30 
M(:,:,41) = a*b*a*b;                 %11)
M(:,:,42) = a*b*a*b*b*a;             %25)
M(:,:,43) = a*b*a*b*b*a*b*a;         %43)
M(:,:,44) = a*b*a*b*b*a*b*a*b*a;     %51)
M(:,:,45) = a*b*a*b*a*b*b;           %30)
% P010: 32,47,58,52,31
M(:,:,46) = a*b*b*a*b*a*b;           %32)
M(:,:,47) = a*b*b*a*b*a*b*b*a;       %47)
M(:,:,48) = a*b*b*a*b*a*b*b*a*b*a;   %58)
M(:,:,49) = a*b*a*b*b*a*b*a*b*b;     %52)
M(:,:,50) = a*b*a*b*b*a*b;           %31)
% P011: 41,54,60,53,42 
M(:,:,51) = b*a*b*b*a*b*a*b;         %41)
M(:,:,52) = b*a*b*b*a*b*a*b*b*a;     %54)
M(:,:,53) = a*b*a*b*b*a*b*a*b*b*a*b; %60)
M(:,:,54) = a*b*b*a*b*a*b*b*a*b;     %53)
M(:,:,55) = b*a*b*a*b*b*a*b;         %42)
% P012: 45,57,59,46,44 
M(:,:,56) = a*b*a*b*b*a*b*a*b;       %45)
M(:,:,57) = a*b*a*b*b*a*b*a*b*b*a;   %57)
M(:,:,58) = b*a*b*b*a*b*a*b*b*a*b;   %59)
M(:,:,59) = b*b*a*b*a*b*b*a*b;       %46)
M(:,:,60) = a*b*a*b*a*b*b*a*b;       %44)
M = round(M*digits)/digits;
%%% Print out the rotation matrices 
%fid = fopen('rot60_dw.txt','w');    
%for i = 1:60
%    fprintf(fid,'%c \n', '#');    
%   fprintf(fid,'  % 8.5f  % 8.5f  % 8.5f \n', [M(1,:,i);]);     
%    fprintf(fid,'  % 8.5f  % 8.5f  % 8.5f \n', [M(2,:,i);]);     
%    fprintf(fid,'  % 8.5f  % 8.5f  % 8.5f \n', [M(3,:,i);]);     
%    fprintf(fid,'  % 8.5f  % 8.5f  % 8.5f \n', [0,0,0]);     
%end