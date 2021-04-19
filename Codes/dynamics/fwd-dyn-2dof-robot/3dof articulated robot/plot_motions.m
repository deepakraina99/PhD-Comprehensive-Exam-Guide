function[]=plot_motion()
disp('------------------------------------------------------------------');
disp('Generating plots for joint motions');

load statevar.dat;
load timevar.dat;
Y=statevar;T=timevar;
clear statevar;
clear timevar;

[y0, ti, tf]=initials();
[dof]=inputs();

% for i= 1:length(T)
%     y=Y(i,:);
%     t=T(i);
%     q=[y(1), y(3)];
%     dq=[y(2), y(3)];
%     tm=fwd_kine(q);
%     eep(i,1)=tm(1,4); eep(i,2)=tm(2,4);
%     [tau_d, we, pe, ve] = torque(t,tf,dof,q,dq);
%     fe(i,1)=sqrt(sum(we.^2));
% end

% % plot end-effector position
% set(0,'DefaultLineLineWidth',1.5)
% fh1=figure('Name','End effector Motions','NumberTitle','off');
% set(fh1, 'color', 'white'); % sets the color to white 
% plot(T,eep(:,1),T,eep(:,2));
% set (gca,'fontsize',12,'fontweight','n','fontname','times new romans','linewidth',0.5,'Box', 'off','TickDir','out' );
% l1=legend('x_e','y_e');
% set(l1,'Orientation','h','Location','northoutside','Color', 'none','Box', 'off','FontAngle','italic','fontsize',14,'fontweight','normal','fontname','times new romans','linewidth',0.5)
% xlabel('time(s)','FontSize',12);
% ylabel('End-effector position (m)','FontSize',12);
% 
% % plot end-effector forces
% set(0,'DefaultLineLineWidth',1.5)
% fh1=figure('Name','End effector Forces','NumberTitle','off');
% set(fh1, 'color', 'white'); % sets the color to white 
% plot(T,fe(:,1));
% set (gca,'fontsize',12,'fontweight','n','fontname','times new romans','linewidth',0.5,'Box', 'off','TickDir','out' );
% l1=legend('x_e','y_e');
% set(l1,'Orientation','h','Location','northoutside','Color', 'none','Box', 'off','FontAngle','italic','fontsize',14,'fontweight','normal','fontname','times new romans','linewidth',0.5)
% xlabel('time(s)','FontSize',12);
% ylabel('End-effector forces (N)','FontSize',12);

% plot joint motions
set(0,'DefaultLineLineWidth',1.5)
fh1=figure('Name','Joint Motions','NumberTitle','off');
set(fh1, 'color', 'white'); % sets the color to white 
subplot(1,2,1)
plot(T,Y(:,1),T,Y(:,2),T,Y(:,3));
set (gca,'fontsize',12,'fontweight','n','fontname','times new romans','linewidth',0.5,'Box', 'off','TickDir','out' );
l1=legend('\theta_1','\theta_2','\theta_3');
set(l1,'Orientation','h','Location','northoutside','Color', 'none','Box', 'off','FontAngle','italic','fontsize',14,'fontweight','normal','fontname','times new romans','linewidth',0.5)
xlabel('time(s)','FontSize',12);
ylabel('Joint angle (rad)','FontSize',12);
subplot(1,2,2)
plot(T,Y(:,4),T,Y(:,5),T,Y(:,6))
set (gca,'fontsize',12,'fontweight','n','fontname','times new romans','linewidth',0.5,'Box', 'off','TickDir','out');
l1=legend('$\dot{\theta_1}$','$\dot{\theta_2}$','$\dot{\theta_3}$');
set(l1,'interpreter','latex','Orientation','h','Location','northoutside','Color', 'none','Box', 'off','FontAngle','italic','fontsize',14,'fontweight','normal','fontname','times new romans','linewidth',0.5)
xlabel('time(s)','FontSize',12);
ylabel('Rates of joint angle (rad/s)','FontSize',12);

% % plot phase plots
% set(0,'DefaultLineLineWidth',1.5)
% fh2=figure('Name','Phase plots','NumberTitle','off');
% set(fh2, 'color', 'white'); % sets the color to white 
% subplot(1,2,1)
% plot(Y(:,1),Y(:,2));
% set (gca,'fontsize',12,'fontweight','n','fontname','times new romans','linewidth',0.5,'Box', 'off','TickDir','out' );
% l1=legend('Joint 1');
% set(l1,'interpreter','latex','Orientation','h','Location','northoutside','Color', 'none','Box', 'off','FontAngle','italic','fontsize',12,'fontweight','normal','fontname','times new romans','linewidth',0.5)
% xlabel('$\theta_1$','Interpreter','latex','FontSize',16);
% ylabel('$\dot{\theta_1}$','Interpreter','latex','FontSize',16);
% subplot(1,2,2)
% plot(Y(:,3),Y(:,4))
% set (gca,'fontsize',12,'fontweight','n','fontname','times new romans','linewidth',0.5,'Box', 'off','TickDir','out');
% l1=legend('Joint 2');
% set(l1,'interpreter','latex','Orientation','h','Location','northoutside','Color', 'none','Box', 'off','FontAngle','italic','fontsize',12,'fontweight','normal','fontname','times new romans','linewidth',0.5)
% xlabel('$b_2$','Interpreter','latex','FontSize',16);
% ylabel('$\dot{b_2}$','Interpreter','latex','FontSize',16);
