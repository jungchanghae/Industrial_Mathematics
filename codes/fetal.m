% 태아심장모델 by 기본 9개
clc; clear all; close all;
global T TS TauS TauD;
%% 초기값 및 변수 설정
A = zeros(9,9);

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
R5 = 0.0813;
R6 = 0.1303; 
%0.1156 0.1009  0.1303
R7 = 0.0029;
R8 = 0.0551;
R9 = 0.004;
R10 = 0.00357;
R11 = 0.04;
R12 = 0.0067;

% Pressure mmHg
P1(1) = 20.0; 
P2(1) = 15.1;
P3(1) = 5.1;
P4(1) = 4.2;
P5(1) = 3.6;
P6(1) = 49.4;
P7(1) = 5.1;
P8(1) = 51.6;
P9(1) = 48.5;

% Complinance ml/mmHg
C1 = 1.5;
C2 = 0.3;
C3 = 0.6;
C4min = 3 * 0.02/70;
C4Max = 3 * 36.5/70;
C5min = 3 * 0.03/70;
C5Max = 3 * 14.6/70;


C6 = 0.05;
C7 = 1;
C8 = 0.08;
C9 = 0.14;

C4(1) = C_fun(0,C4min,C4Max);
C5(1) = C_fun(0,C5min,C5Max);

V1_0 = 32;
V2_0 = 10.5;
V3_0 = 39;
V4_0 = 6;
V5_0 = 6;
V6_0 = 11.5;
V7_0 = 19.5;
V8_0 = 4;
V9_0 = 23.14;

%%
time(1) = t0;
for i = 1 : t1
    time(i+1) = time(i) + dt;
    
    C4(i+1) = C_fun(time(i+1),C4min,C4Max);
    C5(i+1) = C_fun(time(i+1),C5min,C5Max);
    
    S1(i) = (P5(i) > P6(i));
    S2(i) = (P4(i) > P8(i));
    S3(i) = (P5(i) < P7(i));
    S4(i) = (P5(i) < P3(i));
    S1_temp = S1(i); S2_temp = S2(i); S3_temp = S3(i); S4_temp = S4(i);
    
    ok = 0;
    while ok ~= 20
        ok = ok+1;
        
        % dP1/dt
        A(1,1) = C1 + dt * (1/R1 + 1/R2);
        A(1,2) = -dt/R2;
        A(1,3) = 0;
        A(1,4) = 0;
        A(1,5) = 0;
        A(1,6) = 0;
        A(1,7) = 0;
        A(1,8) = 0;
        A(1,9) = -dt/R1;
        
        % dP2/dt
        A(2,1) = -dt/R2;
        A(2,2) = C2 + dt/R2 + dt/R3;
        A(2,3) = -dt/R3;
        A(2,4) = 0;
        A(2,5) = 0;
        A(2,6) = 0;
        A(2,7) = 0;
        A(2,8) = 0;
        A(2,9) = 0;
        
        % dP3/dt
        A(3,1) = 0;
        A(3,2) = -dt/R3;
        A(3,3) = C3 + dt * (1/R3 + 1/R4 + S4_temp/R10);
        A(3,4) = -dt/R4;
        A(3,5) = S4_temp * (-dt/R10);
        A(3,6) = 0;
        A(3,7) = 0;
        A(3,8) = 0;
        A(3,9) = 0;
        
        % dP4/dt
        A(4,1) = 0;
        A(4,2) = 0;
        A(4,3) = -dt/R4;
        A(4,4) = C4(i+1) + dt/R4 + S2_temp * dt / R8;
        A(4,5) = 0;
        A(4,6) = 0;
        A(4,7) = 0;
        A(4,8) = -S2_temp * dt/R8;
        A(4,9) = 0;
        
        % dP5/dt
        A(5,1) = 0;
        A(5,2) = 0;
        A(5,3) = S4_temp * (-dt/R10);
        A(5,4) = 0;
        A(5,5) = C5(i+1) + dt * (S4_temp/R10 + S3_temp/R11 + S1_temp/R5);
        A(5,6) = S1_temp * (-dt/R5);
        A(5,7) = S3_temp *(-dt/R11);
        A(5,8) = 0;
        A(5,9) = 0;
        
        % dP6/dt
        A(6,1) = 0;
        A(6,2) = 0;
        A(6,3) = 0;
        A(6,4) = 0;
        A(6,5) = S1_temp * (-dt/R5);
        A(6,6) = C6 + S1_temp * dt/R5 + dt/R6 + dt/R12;
        A(6,7) = -dt/R6;
        A(6,8) = 0;
        A(6,9) = -dt/R12;
        
        % dP7/dt
        A(7,1) = 0;
        A(7,2) = 0;
        A(7,3) = 0;
        A(7,4) = -dt/R7;
        A(7,5) = S3_temp * (-dt/R11);
        A(7,6) = -dt/R6;
        A(7,7) = C7 + dt * (1/R6 + S3_temp/R11 + 1/R7);
        A(7,8) = 0;
        A(7,9) = 0;
        
        % dP8/dt
        A(8,1) = 0;
        A(8,2) = 0;
        A(8,3) = 0;
        A(8,4) = -S2_temp * dt /R8;
        A(8,5) = 0;
        A(8,6) = 0;
        A(8,7) = 0;
        A(8,8) = C9 + S2_temp * dt/R8 + dt/R9;
        A(8,9) = (-dt/R9);
        
        % dP9/dt
        A(9,1) = -dt/R1;
        A(9,2) = 0;
        A(9,3) = 0;
        A(9,4) = 0;
        A(9,5) = 0;
        A(9,6) = -dt/R12;
        A(9,7) = 0;
        A(9,8) = -dt/R9;
        A(9,9) =  C9 + dt * (1/R12 + 1/R1 + 1/R9);
        
        B = [C1*P1(i), C2*P2(i), C3*P3(i), C4(i+1)*P4(i), C5(i+1)*P5(i), C6*P6(i), C7*P7(i), C8*P8(i), C9*P9(i)];  
        X = A\B';
        
        P1(i+1) = X(1);
        P2(i+1) = X(2);
        P3(i+1) = X(3);
        P4(i+1) = X(4);
        P5(i+1) = X(5);
        P6(i+1) = X(6);
        P7(i+1) = X(7);
        P8(i+1) = X(8);
        P9(i+1) = X(9);
        
        V1(i+1) = V1_0 + C1 * P1(i+1);
        V2(i+1) = V2_0 + C2 * P2(i+1);
        V3(i+1) = V3_0 + C3 * P3(i+1);
        V4(i+1) = V4_0 + C4(i+1) * P4(i+1);
        V5(i+1) = V5_0 + C5(i+1) * P5(i+1);
        V6(i+1) = V6_0 + C6 * P6(i+1);
        V7(i+1) = V7_0 + C7 * P7(i+1);
        V8(i+1) = V8_0 + C8 * P8(i+1);
        V9(i+1) = V9_0 + C9 * P9(i+1);
        
        
        S1(i+1) = (P5(i+1) > P6(i+1));
        S2(i+1) = (P4(i+1) > P8(i+1));
        S3(i+1) = (P5(i+1) < P7(i+1));
        S4(i+1) = (P5(i+1) < P3(i+1));
        
        if S1_temp == S1(i+1) && S2_temp == S2(i+1) && S3_temp == S3(i+1) && S4_temp == S4(i+1)
            ok = 20;
        else
            if ok == 1
                S1_temp = 0; S2_temp = 0; S3_temp = 0; S4_temp = 0;
                
            elseif ok == 2
                S1_temp = 0; S2_temp = 0; S3_temp = 0; S4_temp = 1;
            elseif ok == 3
                S1_temp = 0; S2_temp = 0; S3_temp = 1; S4_temp = 0;
            elseif ok == 4
                S1_temp = 0; S2_temp = 0; S3_temp = 1; S4_temp = 1;
            elseif ok == 5
                S1_temp = 0; S2_temp = 1; S3_temp = 0; S4_temp = 0;
            elseif ok == 6
                S1_temp = 0; S2_temp = 1; S3_temp = 0; S4_temp = 1;
            elseif ok == 7
                S1_temp = 0; S2_temp = 1; S3_temp = 1; S4_temp = 0;
            elseif ok == 8
                S1_temp = 0; S2_temp = 1; S3_temp = 1; S4_temp = 1;
            elseif ok == 9
                S1_temp = 1; S2_temp = 0; S3_temp = 0; S4_temp = 0;
            elseif ok == 10
                S1_temp = 1; S2_temp = 0; S3_temp = 0; S4_temp = 1;
            elseif ok == 11
                S1_temp = 1; S2_temp = 0; S3_temp = 1; S4_temp = 0;
            elseif ok == 12
                S1_temp = 1; S2_temp = 0; S3_temp = 1; S4_temp = 1;
            elseif ok == 13
                S1_temp = 1; S2_temp = 1; S3_temp = 0; S4_temp = 0;
            elseif ok == 14
                S1_temp = 1; S2_temp = 1; S3_temp = 0; S4_temp = 1;
            elseif ok == 15
                S1_temp = 1; S2_temp = 1; S3_temp = 1; S4_temp = 0;
            elseif ok == 16
                S1_temp = 1; S2_temp = 1; S3_temp = 1; S4_temp = 1;
            end
        end 
    end
end

%% figure
figure
plot(time, P1,time, P2,time, P3,time, P4,time, P5,time, P6,time, P7,time, P8,'-.',time, P9,'-.','linewidth',1.5)
legend('1','2','3','4','5','6','7','8','9')
figure
plot(time, V1,time, V2,time, V3,time, V4,time, V5,time, V6,time, V7,time, V8,time, V9)
legend('1','2','3','4','5','6','7','8','9')
%%
figure
plot(time,C4,time,C5)
legend('4','5')