function C=C_fun(t,Cmin,CMax)
%filename: CV_now.m
global T TS TauS TauD
tc=rem(t,T);

if(tc<TS)
  e=(1-exp(-tc/TauS))/(1-exp(-TS/TauS));
  C=CMax*(Cmin/CMax)^e;
else
  e=(1-exp(-(tc-TS)/TauD))/(1-exp(-(T-TS)/TauD));
  C=Cmin*(CMax/Cmin)^e;
end
