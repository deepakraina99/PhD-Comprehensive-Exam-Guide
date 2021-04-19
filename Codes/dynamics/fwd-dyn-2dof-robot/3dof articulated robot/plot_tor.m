% ReDySim plot_tor module. This module plots joint torque
% Contibutors: Dr. Suril Shah and Prof S. K. Saha @IIT Delhi

function [] = plot_tor()
disp('------------------------------------------------------------------');
disp('Plots the Input Joint Torques');

load statevar.dat;
load timevar.dat;
Y=statevar;T=timevar;
let=length(T);
[dof m1 m2 m3 l1 l2 l3 g b th a alp]=inputs();
[y0, ti, tf]=initials();
for k =1:let
    th=[Y(k,1); Y(k,2); Y(k,3)];
    dth=[Y(k,4); Y(k,5); Y(k,6)];
    t=T(k);
    Tp=tf;
    %Joint Torque
    [tu_th] = torque(t,tf,dof,th,dth);
    jtor(k,:)=tu_th;
end
fh1=figure('Name','Input joint torques','NumberTitle','off');
set(fh1, 'color', 'white'); % sets the color to white
plot(T,jtor);
set (gca,'fontsize',14,'fontweight','n','fontname','times new romans','linewidth',0.5,'Box', 'off','TickDir','out' );
l1=legend('\tau_1','\tau_2','\tau_3');
set(l1,'Orientation','h','Location','northoutside','Color', 'none','Box', 'off','FontAngle','italic','fontsize',14,'fontweight','normal','fontname','times new romans','linewidth',0.5)
xlabel('time(s)','FontSize',14);
ylabel('Joint torques (N.m)','FontSize',14);
end

