% 태아심장모델 by 11개 foward
clc; clear all; close all
global T TS TauS TauD;
%% 초기값 및 변수 설정
A = zeros(11,11);

% time
T = 1/150;
TS = T * 0.59;
dt = 0.01*T;
TauS = T * 0.39; %CRV
TauD = T * 0.41; %CRV
t0 = 0;
t1 = 100*T/dt;

% Resistance
R1 = 0.053;
R2 = 0.0091;
R3 = 0.0355;
R4 = 0.00204;
R5 = 0.08134;%
R6 = 0.125;
R7 = 0.017;
R8 = 0.0029;
R9 = 0.04;
R10 = 0.00357;
R11 = 0.05511;%
R12 = 0.0067;
R13 = 0.004;
R14 = 0.144;
R15 = 0.0208;

% Pressure mmHg
P1(1) = 20; 
P2(1) = 15.1;
P3(1) = 5.1;
P4(1) = 4.2;
P5(1) = 3.6;
P6(1) = 49.4;
P7(1) = 10.1;
P8(1) = 5.1;
P9(1) = 51.6;
P10(1) = 48.5;
P11(1) = 10;

% Complinance ml/mmHg
C1 = 1.4;
C2 = 0.3;
C3 = 0.2;
% C4 = 1;
% C5 = 1;
C6 = 0.07;
C7 = 0.9;
C8 = 0.1;
C9 = 0.25;
C10 = 0.14;
C11 = 1.4;

C4min = 3 * 0.2/50;
C4Max = 3 * 36.5/50;
C5min = 3 * 0.03/50;
C5Max = 3 * 14.6/50;
C4(1) = C_fun(t0,C4min,C4Max);
C5(1) = C_fun(t0,C5min,C5Max);

V1_0 = 32;
V2_0 = 10.5;
V3_0 = 39;
V4_0 = 6;
V5_0 = 6;
V6_0 = 11.5;
V7_0 = 16;
V8_0 = 19.5;
V9_0 = 4;
V10_0 = 23.14;
V11_0 = 26;

%%
time(1) = t0;
for i = 1 : t1
    time(i+1) = time(i) + dt;
    
    C4(i) = C_fun(time(i),C4min,C4Max);
    C5(i) = C_fun(time(i),C5min,C5Max);
    
    S1(i) = (P3(i) > P5(i));
    S2(i) = (P4(i) > P9(i));
    S3(i) = (P5(i) > P6(i));
    S4(i) = (P8(i) > P5(i));
    
    P1(i+1) = P1(i) + dt * ((P10(i) - P1(i))/R1 - (P1(i) - P2(i))/R2)/C1;
    
    P2(i+1) = P2(i) + dt * ((P1(i) - P2(i))/R2 - (P2(i) - P3(i))/R3)/C2;
    
    P3(i+1) = P3(i) + dt * ((P2(i) - P3(i))/R3 - (P3(i) - P4(i))/R4 - S1(i) * (P3(i) - P5(i))/R10)/C3;
    
    P4(i+1) = P4(i) + dt * ((P3(i) - P4(i))/R4 + (P8(i) - P4(i))/R8 - S2(i) * (P4(i) - P9(i))/R11)/C4(i);    
    
    P5(i+1) = P5(i) + dt * (S1(i) * (P3(i) - P5(i))/R10 + S4(i) * (P8(i) - P5(i))/R9 - S3(i) * (P5(i) - P6(i))/R5)/C5(i);
    
    P6(i+1) = P6(i) + dt * (S3(i) * (P5(i) - P6(i))/R3 - (P6(i) - P7(i))/R6 + (P6(i) - P10(i))/R12)/C6;
    
    P7(i+1) = P7(i) + dt * ((P6(i) - P7(i))/R6 - (P7(i) - P8(i))/R7)/C7;
    
    P8(i+1) = P8(i) + dt * ((P7(i) - P8(i))/R7 - S4(i) * (P8(i) - P5(i))/R9 - (P8(i) - P4(i))/R8)/C8;
    
    P9(i+1) = P9(i) + dt * (S2(i) * (P4(i) - P9(i))/R11 - (P9(i) - P10(i))/R13)/C9;
    
    P10(i+1) = P10(i) + dt * ((P9(i) - P10(i))/R13 - (P10(i) - P11(i))/R14 - (P10(i) - P1(i))/R1)/C10;
    
    P11(i+1) = P11(i) + dt * ((P10(i) - P11(i))/R14 - (P11(i) - P3(i))/R15)/C11;
    
    V1(i) = V1_0 + C1 * P1(i);
    V2(i) = V2_0 + C2 * P2(i);
    V3(i) = V3_0 + C3 * P3(i);
    V4(i) = V4_0 + C4(i) * P4(i);
    V5(i) = V5_0 + C5(i) * P5(i);
    V6(i) = V6_0 + C6 * P6(i);
    V7(i) = V7_0 + C7 * P7(i);
    V8(i) = V8_0 + C8 * P8(i);
    V9(i) = V9_0 + C9 * P9(i);
    V10(i) = V10_0 + C10 * P10(i);
    V11(i) = V11_0 + C11 * P11(i);
end

%% figure
figure
plot(time, P1,time, P2,time, P3,time, P4,time, P5,time, P8,'-.',time, P9,'-.',time,P10,'-.',time,P11,'linewidth',1.5)
legend('1','2','3','4','5','8','9','10','11')
% figure
% plot(time, V1,time, V2,time, V3,time, V4,time, V5,time, V6,time, V7,time, V8,time, V9,time,V10)
% legend('1','2','3','4','5','6','7','8','9')