function [] = animate()
load timevar.dat;
load statevar.dat;
T=timevar;
Y=statevar;
figure('Name','Animation Window','NumberTitle','off');

[a1 a2 a3 m1 m2 m3 g] = inputs();
[y0, t_initial, t_final, incr, rtol, atol]=initials();

len_sum=sum((a1+a2+0.25));
xmin=-len_sum;
xmax=len_sum;
ymin=-len_sum;
ymax=len_sum;

% animate
for i=1:length(T)
    th1=Y(i,1);
    th2=Y(i,2);
    O1x=a1*cos(th1); O1y=a1*sin(th1);
    O2x=a1*cos(th1)+a2*cos(th1+th2); O2y=a1*sin(th1)+a2*sin(th1+th2);
    O3x = Y(i,3);
    O3y = 0;
    XX1=[0 O1x];
    YY1=[0 O1y];
    XX2=[O1x O2x];
    YY2=[O1y O2y];
    % plot(XX,YY);
    figure(1)
    plot(XX1,YY1,XX2,YY2,'linewidth',1.5);
    hold on;
    plot(O3x,O3y,'-s','MarkerSize',10,...
        'MarkerEdgeColor','black',...
        'MarkerFaceColor',[1 .6 .6])
    hold on;
    grid on
    title(sprintf('Time = %g sec', T(i)))
    axis([ xmin xmax  ymin ymax]);
    hold off;
end