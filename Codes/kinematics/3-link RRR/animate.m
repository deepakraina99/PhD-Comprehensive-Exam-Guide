function [] = animate()
disp('------------------------------------------------------------------');
disp('Animating the simulation data');

load statevar.dat;
load timevar.dat;
Y=statevar;T=timevar;

[robo_type, n, joint, al, b, th, a, alpha] = params();
len_sum=sum(al+0.5);
xmin=-len_sum;
xmax=len_sum;
ymin=-len_sum;
ymax=len_sum;
zmin=-len_sum;
zmax=len_sum;


figure('Name','Animation Window','NumberTitle','off');
for i=1:length(T)
    t=T(i);
    th = Y(i,1:n);
    Te = fwd_kine(b,th,a,alpha);
    Ox = [0 Te(1,4,1) Te(1,4,2) Te(1,4,3)];
    Oy = [0 Te(2,4,1) Te(2,4,2) Te(2,4,3)];
    Oz = [0 Te(3,4,1) Te(3,4,2) Te(3,4,3)];
    t=num2str(t);
    plot(Ox,Oy,'linewidth',2);
    axis([xmin xmax ymin ymax zmin zmax]);
    set (gca,'fontsize',10,'fontweight','normal','fontname','times new romans','linewidth',0.5,'Box', 'off','TickDir','out' );
    xlabel('X (m)','fontweight','normal','fontsize',10);
    ylabel('Y (m)','fontweight','normal','fontsize',10);
    zlabel('Z (m)','fontweight','normal','fontsize',10);
    title(['Current time t=',t],'fontweight','normal','fontsize',10);
    grid on;    
    drawnow;
end