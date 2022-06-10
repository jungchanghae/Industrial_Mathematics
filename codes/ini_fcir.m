% filename : ini_fcir
%% index
FPL = 1; 1
Uv = 2; 2 
IVC = 3; 3
RA = 4; 4 
LA = 5; 5 
AA = 6; 6 
BR = 7; 9
UB = 8; 7
SVC = 9; 10
PA = 10; 11
PV = 11; 12
LB = 12; 15
IN = 13; 14
DA = 14; 13
MY = 15; 8
HE = 16; 16


%% zeros

A = zeros(n,n);
P = zeros(n,1);
P_o = zeros(n,1);

C = zeros(n,1);
C_o = zeros(n,1);

V = zeros(n,1);

%% time
t0 = 0;
t1 = 500;
dt = 0.01;
time(1) = t0;

%% Resistance
R1 = 0.053;
R2 = 0.0091;
R3 = 0.0355;
R4 = 0.00204;
R5 = 0.0813;
R6 = 0.1303; 
%0.1156 0.1009 0.1303
R7 = 0.0029;
R8 = 0.0551;
R9 = 0.004;
R10 = 0.00357;
R11 = 0.04;
R12 = 0.0067;

%% Pressure mmHg
% systolic pressure = 105
% diastolic pressure = 60
P(FPL) = 20.0 ; 
P(Uv) = 15.1;
P(IVC) = 5.1;
P(RA) = 4.2;
P(LA) = 3.6;
P(AA) = 49.4;
P(SVC) = 5.1;
P(Pa) = 51.6;
P(Da) = 48.5;

%% Compliance ml/mmHg
C(FPL) = 1.4;
C(Uv) = 0.3;
C(IVC) = 0.2;
C(RA) = 1.0;
C(LA) = 1.0;
C(AA) = 0.07;
C(SVC) = 0.1;
C(Pa) = 0.25;
C(Da) = 0.14;

%% V

V(FPL) = 60;
V(Uv) = 15;
V(IVC) = 40;
V(RA) = 10.2;
V(LA) = 9.6;
V(AA) = 15;
V(SVC) = 20;
V(Pa) = 16.9;
V(Da) = 29.9;

