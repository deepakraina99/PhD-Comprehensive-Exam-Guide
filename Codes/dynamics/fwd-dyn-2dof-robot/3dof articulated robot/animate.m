% Animate module. This module animates the system under study
% Contibutors: Deepak Raina @IIT Delhi
function [] = animate()
load timevar.dat;
load statevar.dat;
T=timevar;
Y=statevar;
figure('Name','Animation Window','NumberTitle','off');

[dof m1 m2 m3 l1 l2 l3 g b th a alp]=inputs();
[y0, t_initial, t_final, incr, rtol, atol, eepi, ctrl_type]=initials();

%xy limits
len_sum=sum(l1+l2+l3);
xmin=-len_sum;
xmax=len_sum;
ymin=-len_sum;
ymax=len_sum;
zmin=-len_sum;
zmax=len_sum;

th1=Y(:,1);
th2=Y(:,2);
th3=Y(:,3);

for i=1:length(T)
    t=T(i);
    %Link Centres
    O0x=0; O0y=0; O0z=0;
    ht=fwd_kine([th1(i), th2(i), th3(i)]);
    O1x=ht(1,4,1); O1y=ht(2,4,1); O1z=ht(3,4,1); 
    O2x=ht(1,4,2); O2y=ht(2,4,2); O2z=ht(3,4,2); 
    O3x=ht(1,4,3); O3y=ht(2,4,3); O3z=ht(3,4,3); 
    L1X= [O0x, O1x]; %link1
    L1Y= [O0y, O1y];
    L1Z= [O0z, O1z];
    L2X= [O1x, O2x]; %link2
    L2Y= [O1y, O2y];
    L2Z= [O1z, O2z];
    L3X= [O2x, O3x]; %link3
    L3Y= [O2y, O3y];
    L3Z= [O2z, O3z];

    plot3(L1X,L1Y,L1Z,L2X,L2Y,L2Z,L3X,L3Y,L3Z,'linewidth',2);
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

%     path1(i,:)=[O0x+O1x O0y+O1y];
%     path2(i,:)=[O0x+O1x+O2x O0y+O1y+O2y];
%     plot(XX,YY,'linewidth',1.5);
%     hold on;
%     plot(path1(1:i,1),path1(1:i,2));
%     hold on;
%     plot(path2(1:i,1),path2(1:i,2),'m');
%     hold on
%     plot(XX(2),YY(2),'o',...
%         'LineWidth',1,...
%         'MarkerEdgeColor','k',...
%         'MarkerFaceColor','r',...
%         'MarkerSize',4);
%     hold on;
%     plot(XX(3),YY(3),'o',...
%         'LineWidth',1,...
%         'MarkerEdgeColor','k',...
%         'MarkerFaceColor','r',...
%         'MarkerSize',4);
%     hold on;
%     hold on;
    axis([xmin xmax ymin ymax zmin zmax]);
    set (gca,'fontsize',10,'fontweight','normal','fontname','times new romans','linewidth',0.5,'Box', 'off','TickDir','out' );
    xlabel('X (m)','fontweight','n','fontsize',10);
    ylabel('Y (m)','fontweight','n','fontsize',10);
    zlabel('Z (m)','fontweight','n','fontsize',10);
    t=num2str(t);
    title(['Current time t=',t],'fontweight','normal','fontsize',10);
    grid on;
%     hold off;
%     pause(0.01)
    drawnow;
end

