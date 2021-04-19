% Animate module. This module animates the system under study
% Contibutors: Deepak Raina @IIT Delhi
function [] = animate()
load timevar.dat;
load statevar.dat;
T=timevar;
Y=statevar;
figure('Name','Animation Window','NumberTitle','off');

[robo_type, n, joint, al, b, th, a, alpha] = params();
[te, qi, ti, dt, tf] = initials();

%xy limits
len_sum=1;
xmin=-len_sum;
xmax=len_sum;
ymin=-len_sum;
ymax=len_sum;
zmin=-len_sum;
zmax=len_sum;

for i=1:length(T)
    t=T(i);
    th = Y(i,1:n);
    Te = fwd_kine(b,th,a,alpha);
    Ox = [0 Te(1,4,1) Te(1,4,2) Te(1,4,3) Te(1,4,4) Te(1,4,5) Te(1,4,6)];
    Oy = [0 Te(2,4,1) Te(2,4,2) Te(2,4,3) Te(2,4,4) Te(2,4,5) Te(2,4,6)];
    Oz = [0 Te(3,4,1) Te(3,4,2) Te(3,4,3) Te(3,4,4) Te(3,4,5) Te(3,4,6)];
    t=num2str(t);
    plot3(Ox,Oy,Oz,'linewidth',2);
    axis([xmin xmax ymin ymax zmin zmax]);
    set (gca,'fontsize',10,'fontweight','normal','fontname','times new romans','linewidth',0.5,'Box', 'off','TickDir','out' );
    xlabel('X (m)','fontweight','n','fontsize',10);
    ylabel('Y (m)','fontweight','n','fontsize',10);
    ylabel('Z (m)','fontweight','n','fontsize',10);
    t=num2str(t);
    title(['Current time t=',t],'fontweight','normal','fontsize',10);
    grid on;
%     hold off;
%     pause(0.01)
    drawnow;
end

