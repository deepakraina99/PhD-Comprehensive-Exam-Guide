clc;
clear all;
% i=0;
% Initial Values
x0=0;y0=0;ph0=0;
dx0=0;dy0=0;dph0=0;
thin=[2.1572; 1.9687; 3.1416];
th1= thin(1); th2= thin(2); th3=thin(3);
% dth1(1)=-0.05962; dth2(1)=-0.05962; dth1(2)=-0.2;
dth1=0; dth2=0; dth3=0;

% Type=1 for Floating base and =0 for Fixed Base 
type=0;
if type==0 %fixed sytem
    y0_in = [th1 th2 th3 dth1 dth2 dth3];
    t=0:0.1:10;
    %ODE
    % options = odeset('RelTol',1e-8,'AbsTol',1e-8);
    % [T,Y] = ode45(@rigid2script,t,y0_in,options);
    [T,Y] = ode45(@rigidscriptdualzero3,t,y0_in);
    th1=Y(:,1); th2=Y(:,2); th3=Y(:,3);
    dth1=Y(:,4); dth2=Y(:,5); dth3=Y(:,6);
    % Animation
    a0=0.895; a1=1.152; a2=1.152; a3=0.38;
    x0=zeros(length(T),1);
    y0=zeros(length(T),1);
    ph0=zeros(length(T),1);
    l=a0; w=a0;
    x1=x0-(l/2); y1=y0-(w/2);
    x2=x0+(l/2); y2=y0-(w/2);
    x3=x0+(l/2); y3=y0+(w/2);
    x4=x0-(l/2); y4=y0+(w/2);
    % th1=0*T;
    % th2=sin(T);
    % a1=1; a2=1;
    for i=1:length(T)
        xv=[x1(i) x2(i) x3(i) x4(i)];
        yv=[y1(i) y2(i) y3(i) y4(i)];
        % Rv(1,:)=xv(i,:);Rv(2,:)=yv(i,:);
        Rot=[cos(ph0(i)) -sin(ph0(i));sin(ph0(i)) cos(ph0(i))];
        XY=Rot*[xv;yv];
        %Midpoint
        m1=(XY(:,2)+XY(:,3))/2;
        m2=(XY(:,1)+XY(:,4))/2;
        
        XY1=[XY,XY(:,1)];
        
        O0x1=m1(1); O0y1=m1(2);
        O0x2=m2(1); O0y2=m2(2);
        
        O1x1=a1*cos(ph0(i)+th1(i)); O1y1=a1*sin(ph0(i)+th1(i));
        O2x1=a1*cos(ph0(i)+th1(i))+a2*cos(ph0(i)+th1(i)+th2(i)); O2y1=a1*sin(ph0(i)+th1(i))+a2*sin(ph0(i)+th1(i)+th2(i));
        O1x2=a3*cos(ph0(i)+th3(i)); O1y2=a3*sin(ph0(i)+th3(i));
        
        XX1=[O0x1 O0x1+O1x1 O0x1+O2x1];
        YY1=[O0y1 O0y1+O1y1 O0y1+O2y1];
        
        XX2=[O0x2 O0x2+O1x2 O0x2];
        YY2=[O0y2 O0y2+O1y2 O0y2];
        % plot(XX,YY);
        figure(1)
        plot(XY1(1,:),XY1(2,:),XX1,YY1,XX2,YY2,'linewidth',1.5);
        grid on
        title(sprintf('Time = %g sec', T(i)))
        axis([-3.5 3.5 -3.5 3.5])
        pause(0.1)
        drawnow
    end
% Momentum
Momentum        
elseif type==1 %floating system
    y0_in = [x0 y0 ph0 th1 th2 th3 dx0 dy0 dph0 dth1 dth2 dth3];
    t=0:0.1:10;
    %ODE
    % options = odeset('RelTol',1e-8,'AbsTol',1e-8);
    % [T,Y] = ode45(@rigid2script,t,y0_in,options);
    [T,Y] = ode45(@rigidscriptdualzero,t,y0_in);
    Y;
    % Animation
    % Y(:,1)=0;
    % Y(:,2)=0;
    a0=0.895; a1=1.152; a2=1.152; a3=0.38;
    x0=Y(:,1);
    y0=Y(:,2);
    ph0=Y(:,3);
    l=a0; w=a0;
    x1=x0-(l/2); y1=y0-(w/2);
    x2=x0+(l/2); y2=y0-(w/2);
    x3=x0+(l/2); y3=y0+(w/2);
    x4=x0-(l/2); y4=y0+(w/2);
    % i=1;
    % th1=0; th2= 0;
    th1=Y(:,4); th2=Y(:,5); th3=Y(:,6);
    dth1=Y(:,10); dth2=Y(:,11); dth3=Y(:,12);
    
    for i=1:length(T)
        xv=[x1(i) x2(i) x3(i) x4(i)];
        yv=[y1(i) y2(i) y3(i) y4(i)];
        % Rv(1,:)=xv(i,:);Rv(2,:)=yv(i,:);
        Rot=[cos(ph0(i)) -sin(ph0(i));sin(ph0(i)) cos(ph0(i))];
        XY=Rot*[xv;yv];
        %Midpoint
        m1=(XY(:,2)+XY(:,3))/2;
        m2=(XY(:,1)+XY(:,4))/2;
        % figure
        XY1=[XY,XY(:,1)];
        % rectangle('Position',[XY(i,1) XY(i,1) l w])
        % hold off;
        % end
        O0x1=m1(1); O0y1=m1(2);
        O0x2=m2(1); O0y2=m2(2);
        
        O1x1=a1*cos(ph0(i)+th1(i)); O1y1=a1*sin(ph0(i)+th1(i));
        O2x1=a1*cos(ph0(i)+th1(i))+a2*cos(ph0(i)+th1(i)+th2(i)); O2y1=a1*sin(ph0(i)+th1(i))+a2*sin(ph0(i)+th1(i)+th2(i));
        
        O1x2=a3*cos(ph0(i)+th3(i)); O1y2=a3*sin(ph0(i)+th3(i));
        
        XX1=[O0x1 O0x1+O1x1 O0x1+O2x1];
        YY1=[O0y1 O0y1+O1y1 O0y1+O2y1];
        
        XX2=[O0x2 O0x2+O1x2 O0x2];
        YY2=[O0y2 O0y2+O1y2 O0y2];
        % plot(XX,YY);
        figure(1)
        plot(XY1(1,:),XY1(2,:),XX1,YY1,XX2,YY2,'linewidth',1.5);
        grid on
        title(sprintf('Time = %g sec', T(i)))
        axis([-3.5 3.5 -3.5 3.5])
        pause(0.1)
        drawnow
    end
end



% % Base Motion
% figure(3)
% title('Base Motion')
% subplot(2,2,1);
% plot(T,Y(:,1),T,Y(:,2))
% legend('X_0','Y_0')
% legend('boxoff')
% subplot(2,2,2);
% plot(T,Y(:,3))
% legend('\phi_0')
% legend('boxoff')
% subplot(2,2,3);
% plot(T,Y(:,7),T,Y(:,8))
% legend('dX_0','dY_0')
% legend('boxoff')
% subplot(2,2,4);
% plot(T,Y(:,9))
% legend('d\phi_0')
% legend('boxoff')
%
% %Joint Motion
% figure(4)
% title('Joint Motion')
% subplot(1,2,1);
% plot(T,th1,T,th2,T,th3)
% legend('th1','th2','th3')
% legend('boxoff')
% subplot(1,2,2);
% plot(T,dth1,T,dth2,T,dth3)
% legend('dth1','dth2','dth3')
% legend('boxoff')

% Momentum
Momentum
