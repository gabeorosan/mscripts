%% STMV (T = 1) % There's a seeming problem with the number of atoms here  
clear all; clc; close all
Tnum = 1; app = [2263]; pdbid = '1a34'
% capsid_name = 'xyz.1a34.vdb';
%% DODECA ADENO (T = 1) Dodecahedron adenovirus Ad3 from Serotype 3        
clear all; clc; close all
Tnum = 1; app = [3724]; pdbid = '4aqq'
%capsid_name = 'xyz.4aqq.vdb'
%% DODECA ADENO (T = 1) Dodecahedron adenovirus Ad3 from Serotype 2 
clear all; clc; close all
Tnum = 1; app = [3724]; pdbid = '4ar2'
% capsid_name = 'xyz.4ar2.vdb'
%% Infectuous Bursal Virus Derived T=1 Particles (2gsy) (T=1) Avibirnavirus PAPER/POSTER
clear all; clc; close all
Tnum = 1; app = [3209]; apr = []; pdbid = '2gsy'
%% Hepatisis E VLPD [T = 1] (3HAG) Hepevirus PAPER/POSTER
clear all; clc; close all
Tnum = 1; app = [3589]; apr = []; pdbid = '3hag'
%% LA Virus T = 2                                                          
clear all; clc; close all
Tnum = 2; app = [5151 5151]; pdbid = '1m1c'
% capsid_name = 'xyz.1m1c.vdb'
%% Infectious Bursal Disease Virus VP2 Sub Particle                        
clear all; clc; close all
Tnum = 1; app = [3162]; pdbid = '2df7'
%capsid_name = 'xyz.2df7.pdb';
%% Hepatitis E Virus-like Particle                                         
clear all; clc; close all
Tnum = 1; app = [3589]; pdbid = '3hag'
% capsid_name = 'xyz.3hag.pdb';
%% Human Adenovirus 2 Penton Base % (T=1) XX Failed, not sure why                
clear all; clc; close all
Tnum = 1; app = [3632];  pdbid = '1x9p'
% capsid_name = 'xyz.1x9p.pdb';
%% DODECA ADENO (T = 1) Dodecahedron adenovirus Ad3 from Serotype 2        
clear all; clc; close all
Tnum = 1; app = [3724]; pdbid = '4ar2'
% capsid_name = 'xyz.4ar2.vdb'
%% PENICILLIUM CHRYSOGENUM VIRUS (PCV) CAPSID STRUCTURE T = 1              
clear all; clc; close all
Tnum = 1; app = [7515]; apr = []; pdbid = '3j3i'
% capsid_name = 'xyz.3j3i.vdb'
%% Tobacco Necrosis Virus (1c8n) T3
clear all; clc; close all
Tnum = 3; app = [1435 1439 1653]; apr = []; pdbid = '1c8n'
%% CCMV native (T=3)                                                       
clear all; clc; close all
Tnum = 3; app = [1122 1226 1226]; pdbid = '1cwp'
% capsid_name = 'xyz.1cwp.vdb'
%% CCMV swollen (T=3)                                                          
clear all; clc; close all
Tnum = 3; app = [1122 1226 1226]; pdbid = 'ccmv_swln_1'
% capsid_name = 'xyz.ccmv_swln_1.vdb'
%% CCMV swollen (redownloaded)  T=3                                                        
clear all; clc; close all
Tnum = 3; app = [1122 1226 1226]; apr = []; pdbid = 'ccmvswln1'
%% PaV (T=3)                                                                    
clear all; clc; close all
Tnum = 3; app = [2912 2544 2529]; pdbid = '1f8v'
%capsid_name = 'xyz.1f8v.vdb'
%% MS2 (T=1)                                                               
clear all; clc; close all
Tnum = 1; app = [951]; pdbid = '4zor'
capsid_name = strcat('xyz.',pdbid,'.pdb');
%% MS2 (T=3)                                                               
clear all; clc; close all
Tnum = 3; app = [965 965 965]; pdbid = '2ms2'
% capsid_name = 'xyz.2ms2.vdb'
%% New Virus (T=??)                                                               
clear all; clc; close all
Tnum = 3; app = [965 965 965]; pdbid = '2ms2'
% capsid_name = 'xyz.2ms2.vdb'
%% GA  (T=3)                                                                    
clear all; clc; close all
Tnum = 3; app = [963 963 963]; pdbid = '1gav'
% capsid_name = 'xyz.1gav.vdb'
%% TBSV (T=3)                                                                 
clear all; clc; close all
Tnum = 3; app = [2136 2130 2376]; pdbid = '2tbv'
%capsid_name = 'xyz.2tbv.vdb'
%% Seneca Valley   (pT3)                                                         
clear all; clc; close all
Tnum = 4; app = [2015 1855 2105 278]; pdbid = '3cji'
%capsid_name = 'xyz.3cji.vdb' 
%% Cowpea Mosaic Virus (CPMV pT3)                                                
clear all; clc; close all
Tnum = 3; app = [1477 1465 1401]; pdbid = '1ny7'
%capsid_name = 'xyz.1ny7.pdb'
%% NwV  (T=4)                                                              
clear all; clc; close all
Tnum = 4; app = [4135 4188 4520 4492]; pdbid = '1ohf'
%capsid_name = 'xyz.1ohf.vdb'
%% HASV (T=4)                                                               
clear all; clc; close all
Tnum = 4; app = [4117 4124 4168 5493]; pdbid = '3s6p'
%capsid_name = 'xyz.3s6p.vdb'
%% HEP B HBCAG                                                             
clear all; clc; close all
Tnum = 4; app = [1136 1144 1136 1144]; pdbid = '1qgt'
%capsid_name = 'xyz.1qgt.vdb'
%% HBCAG - AGYW                                                            
clear all; clc; close all
Tnum = 4; app = [1164 1167 1167 1160]; pdbid = '2g33'
%capsid_name = 'xyz.2g33.vdb'
%% SV40 *7d*                                                               
clear all; clc; close all
Tnum = 6; app = [2707 2707 2658 2560 2700 2651]; pdbid = '1sva'
%capsid_name = 'xyz.1sva.vdb'
%% BPV Type 1 *7d*                                                         
clear all; clc; close all
Tnum = 6; app = [3803 3701 3803 3803 3803 3701]; pdbid = '3iyj'
%capsid_name = 'xyz.3iyj.vdb'
%% HK97 Prohead II                                                         
clear all; clc; close all
Tnum = 7; app = [1978 1934 1918 1961 1970 1918 1911]; pdbid = '3e8k'
%capsid_name = 'xyz.3e8k.vdb'
%% HK97 Head II                                                            
clear all; clc; close all
Tnum = 7; app = [2151 2151 2151 2151 2151 2001 2021]; pdbid = '2ft1'
%capsid_name = 'xyz.2ft1.vdb'
%% P22 Mature Virion                                                       
clear all; clc; close all
Tnum = 7; app = [3285 3285 3285 3285 3285 3285 3285]; pdbid = '5uu5'
%capsid_name = 'xyz.5uu5.pdb'
%% Thermophilic Bacteriophage P74-26 capsid (T=14)
clear all; clc; close all
Tnum = 14; app = [3303 3303 3303 3303 3303 3303 3299 1153 1153 1153 1153 1153 1153 1153]; apr = []; pdbid = '6o3h'
%xyz.6o3h.pdb
%% PHI 6 T=2 part of T=13 capsid
clear all; clc; close all
Tnum = 2; app = [5920 5920]; apr = []; pdbid = '4btg'