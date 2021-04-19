% Animate module. This module animates the system under study
% Contibutors: Deepak Raina @IIT Delhi
function [] = animate()
load timevar.dat;
load statevar.dat;
T=timevar;
Y=statevar;
figure('Name','Animation Window','NumberTitle','off');

[dof m1 m2 l1 a2 g b th a alp]=inputs();
[y0, t_initial, t_final, incr, rtol, atol, eepi, ctrl_type]=initials();

%xy limits
len_sum=sum(l1+a2);
xmin=-len_sum;
xmax=len_sum;
ymin=-len_sum;
ymax=len_sum;
zmin=-len_sum;
zmax=len_sum;

th1=Y(:,1);
b2=Y(:,3);
for i=1:length(T)
    t=T(i);
    %Link Centres
    O0x=0; O0y=0; O0z=0;
    ht=fwd_kine([th1(i), b2(i)]);
    O1x = ht(1,4,1); O1y = ht(2,4,1); O1z = ht(3,4,1);
    O2x = ht(1,4,2); O2y = ht(2,4,2); O2z = ht(3,4,2);
    L1X=[O0x, O1x];
    L1Y=[O0y, O1y];
    L1Z=[O1z-l1, O1z];
    L2X=[O1x, O2x];
    L2Y=[O1y, O2y];
    L2Z=[O1z, O2z];
    plot(L1X,L1Z,L2X,L2Z,'linewidth',2);
    
%     if ctrl_type==4
%         % stiffnes-control
%         pe=[0.35; 0];
%         ve=[-0.05; 0];
%         pec= pe + ve*(t);
%     elseif ctrl_type==5
%         % Impedence-control
%         pe=[0.35; 0];
%         ae=[-0.2; 0];
%         pec = pe + 0.5*ae*t*t;
%     elseif ctrl_type==6 || ctrl_type==7
%         % Admittance-control
%         pe=[0.35; 0];
%         ve=[-0.01; 0];
%         pec = pe + ve*(t);
%     end
%     if ctrl_type<4
%         plot(L1X,L1Y,L2X,L2Y,'linewidth',2);
%     else
%         W1X= [pec(1), pec(1)];
%         W1Y= [1, -1];
%         plot(L1X,L1Y,L2X,L2Y,W1X, W1Y,'linewidth',2);
%     end
    axis([xmin xmax ymin ymax zmin zmax]);
    set (gca,'fontsize',10,'fontweight','normal','fontname','times new romans','linewidth',0.5,'Box', 'off','TickDir','out' );
    xlabel('Z (m)','fontweight','n','fontsize',10);
    ylabel('Y (m)','fontweight','n','fontsize',10);
    zlabel('X (m)','fontweight','n','fontsize',10);
    t=num2str(t);
    title(['Current time t=',t],'fontweight','normal','fontsize',10);
    grid on;
%     hold off;
%     pause(0.01)
    drawnow;
end

