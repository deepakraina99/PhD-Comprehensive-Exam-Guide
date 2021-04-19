% Tp=5;
% t=0:0.1:Tp;

m0=100; m1=10; m2=10; m3=10;
a0=0.895; a1=1.152; a2=1.152; a3=0.38;
d1x=a1/2; d2x=a2/2; d3x=a3/2;
I0z=83.61; I1z=1.05; I2z=1.05; I3z=1.05;
mom=[]; mo=0;
for i=1:length(T)
x0=Y(i,1); y0=Y(i,2); ph0=Y(i,3); th1=Y(i,4); th2=Y(i,5); th3=Y(i,6);
dx0=Y(i,7); dy0=Y(i,8); dph0=Y(i,9); dth1=Y(i,10); dth2=Y(i,11); dth3=Y(i,12);

tb=[dx0; dy0; dph0];
dph1=[dth1; dth2];
dph2=dth3;

% GIM
%Row1
hb11 = m0 + m1 + m2 + m3;
hb12 = 0;
hb13 =  - (a0*m1*sin(ph0))/2 - (a0*m2*sin(ph0))/2 - d2x*m2*sin(ph0 + th1 + th2) - a1*m2*sin(ph0 + th1) - d1x*m1*sin(ph0 + th1) + ((a0*m3*sin(ph0))/2 + d3x*m3*sin(ph0 + th3));
 
hbm14 = - d2x*m2*sin(ph0 + th1 + th2) - a1*m2*sin(ph0 + th1) - d1x*m1*sin(ph0 + th1);
hbm15 = - d2x*m2*sin(ph0 + th1 + th2);
hbm16 =   d3x*m3*sin(ph0 + th3);

%Row2
hb21 = 0;
hb22 = m0 + m1 + m2 + m3;
hb23 = (a0*m1*cos(ph0))/2 + (a0*m2*cos(ph0))/2 + d2x*m2*cos(ph0 + th1 + th2) + a1*m2*cos(ph0 + th1) + d1x*m1*cos(ph0 + th1) - ((a0*m3*cos(ph0))/2 + d3x*m3*cos(ph0 + th3)) ;       

hbm24 = d2x*m2*cos(ph0 + th1 + th2) + a1*m2*cos(ph0 + th1) + d1x*m1*cos(ph0 + th1);
hbm25 = d2x*m2*cos(ph0 + th1 + th2);
hbm26 = -d3x*m3*cos(ph0 + th3);

%Row3
hb31 = -(a0*m1*sin(ph0))/2 - (a0*m2*sin(ph0))/2 - d2x*m2*sin(ph0 + th1 + th2) - a1*m2*sin(ph0 + th1) - d1x*m1*sin(ph0 + th1) + ((a0*m3*sin(ph0))/2 + d3x*m3*sin(ph0 + th3));
hb32 =  (a0*m1*cos(ph0))/2 + (a0*m2*cos(ph0))/2 + d2x*m2*cos(ph0 + th1 + th2) + a1*m2*cos(ph0 + th1) + d1x*m1*cos(ph0 + th1) - ((a0*m3*cos(ph0))/2 + d3x*m3*cos(ph0 + th3));
hb33 = I0z + I1z + I2z + (a0^2*m1)/4 + (a0^2*m2)/4 + a1^2*m2 + d1x^2*m1 + d2x^2*m2 + a0*d2x*m2*cos(th1 + th2) + a0*a1*m2*cos(th1) + a0*d1x*m1*cos(th1) + 2*a1*d2x*m2*cos(th2) + (I3z + d3x^2*m3 + a0*d3x*m3*cos(th3)); 

hbm34 = m2*a1^2 + 2*m2*cos(th2)*a1*d2x + (a0*m2*cos(th1)*a1)/2 + m1*d1x^2 + (a0*m1*cos(th1)*d1x)/2 + m2*d2x^2 + (a0*m2*cos(th1 + th2)*d2x)/2 + I1z + I2z;
hbm35 = I2z + d2x^2*m2 + (a0*d2x*m2*cos(th1 + th2))/2 + a1*d2x*m2*cos(th2);
hbm36 = m3*d3x^2 + (a0*m3*cos(th3)*d3x)/2 +  I3z;

% Row4
hm44 = m2*a1^2 + 2*m2*cos(th2)*a1*d2x + m1*d1x^2 + m2*d2x^2 + I1z + I2z;
hm45 = m2*d2x^2 + a1*m2*cos(th2)*d2x+ I2z;
hm46 = 0;

% Row5
hm54 = m2*d2x^2 + a1*m2*cos(th2)*d2x + I2z;
hm55 = m2*d2x^2 + I2z;
hm56 = 0;

% Row 6
hm64 = 0;
hm65 = 0;
hm66 = m3*d3x^2 + I3z;

%GIM
Ib = [hb11 hb12 hb13
      hb21 hb22 hb23
      hb31 hb32 hb33];
 
Ibm = [hbm14 hbm15 hbm16
       hbm24 hbm25 hbm26    
       hbm34 hbm35 hbm36];

Ibm1 = [hbm14 hbm15
        hbm25 hbm25    
        hbm34 hbm35];
   
Ibm2 = [hbm16
        hbm26    
        hbm36];

% Momentum Equation
Mo=Ib*tb + Ibm1*dph1 + Ibm2*dph2;
mom(i,:)=Mo';
end

% Plot
figure(5)
subplot(2,1,1);
plot(T,mom(:,1),T,mom(:,2))
title('Linear Momentum')
legend('Px','Py')
subplot(2,1,2);
plot(T,mom(:,3))
title('Angular Momentum')
legend('Lz')
