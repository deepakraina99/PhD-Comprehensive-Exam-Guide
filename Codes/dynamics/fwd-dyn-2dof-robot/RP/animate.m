% Animate module. This module animates the system under study
% Contibutors: Deepak Raina @IIT Delhi
function [] = animate()
load timevar.dat;
load statevar.dat;
T=timevar;
Y=statevar;
figure('Name','Animation Window','NumberTitle','off');

[dof m1 m2 a1 l2 g b th a alp]=inputs();
[y0, t_initial, t_final, incr, rtol, atol, eepi, ctrl_type]=initials();

%xy limits
len_sum=sum(a1+l2);
xmin=-len_sum;
xmax=len_sum;
ymin=-len_sum;
ymax=len_sum;

th1=Y(:,1);
b2=Y(:,3);
for i=1:length(T)
    t=T(i);
    %Link Centres
    O0x=0; O0y=0;
    th1(i)
    b2(i)
    ht=fwd_kine([th1(i), b2(i)]);
    O1x=a1*cos(th1(i)); 
    O1y=a1*sin(th1(i));
    O21x=(l2-b2(i))*cos(th1(i)-pi/2);
    O21y=(l2-b2(i))*sin(th1(i)-pi/2);   
    O22x=b2(i)*cos(th1(i)+pi/2);
    O22y=b2(i)*sin(th1(i)+pi/2);
    L1X=[O0x, O0x+O1x]; %link1
    L1Y= [O0y, O0y+O1y];
    L2X= [O0x+O1x+O21x, O0x+O1x+O22x]; %link2
    L2Y= [O0y+O1y+O21y, O0y+O1y+O22y];
    
    if ctrl_type==4
        % stiffnes-control
        pe=[0.35; 0];
        ve=[-0.05; 0];
        pec= pe + ve*(t);
    elseif ctrl_type==5
        % Impedence-control
        pe=[0.35; 0];
        ae=[-0.2; 0];
        pec = pe + 0.5*ae*t*t;
    elseif ctrl_type==6 || ctrl_type==7
        % Admittance-control
        pe=[0.35; 0];
        ve=[-0.01; 0];
        pec = pe + ve*(t);
    end
    if ctrl_type<4
        plot(L1X,L1Y,L2X,L2Y,'linewidth',2);
    else
        W1X= [pec(1), pec(1)];
        W1Y= [1, -1];
        plot(L1X,L1Y,L2X,L2Y,W1X, W1Y,'linewidth',2);
    end

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
    axis([xmin xmax ymin ymax]);
    set (gca,'fontsize',10,'fontweight','normal','fontname','times new romans','linewidth',0.5,'Box', 'off','TickDir','out' );
    xlabel('X (m)','fontweight','n','fontsize',10);
    ylabel('Y (m)','fontweight','n','fontsize',10);
    t=num2str(t);
    title(['Current time t=',t],'fontweight','normal','fontsize',10);
    grid on;
%     hold off;
%     pause(0.01)
    drawnow;
end

