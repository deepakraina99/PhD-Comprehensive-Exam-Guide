function[]= plot_acc_tor()

load statevar.dat;
load timevar.dat;
Y=statevar;T=timevar;
[n, y0, ti, tf, incr, rtol, atol, int_type] = initials();
for i= 1:length(T)
    y=Y(i,:);
    t=T(i);
    [acc(i,:), tau_d(i,:)] =sys_ode(t,y,n,tf);
end
fh1=figure('Name','Joint accelerations and torques','NumberTitle','off');
subplot(1,2,2)
set(fh1, 'color', 'white'); % sets the color to white
plot(T,tau_d);
set (gca,'fontsize',10,'fontweight','n','fontname','times new romans','linewidth',0.5,'Box', 'off','TickDir','out' );
% xlim([0 2.8])
xlabel('time (s)','FontSize',10);
ylabel('Joint Torques (N.m)/ Forces (N)','FontSize',10);
% h=legend('Total');
% set(h,'Orientation','horizontal','Color', 'none','Box', 'off','Location','northoutside','fontsize',10,'fontweight','n','fontname','times new romans','linewidth',0.5)
subplot(1,2,1)
set(fh1, 'color', 'white'); % sets the color to white
plot(T,acc(:,n+1:2*n));
set (gca,'fontsize',10,'fontweight','n','fontname','times new romans','linewidth',0.5,'Box', 'off','TickDir','out' );
% xlim([0 2.8])
xlabel('time (s)','FontSize',10);
ylabel('Joint accelerations (rad/s^2 or m/s^2)','FontSize',10);
