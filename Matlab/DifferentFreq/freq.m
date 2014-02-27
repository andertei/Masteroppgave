clear all
clc
close all
format long


t=0.01115:0.0000000001:0.01125;
t_2=0:0.0000000001:0.0001;
V_1=7071.06*sin(2*pi*200*t-(pi/2+pi));
V_2=-353.55*sin(2*pi*4000*t);

figure(1)
plot(t_2,V_1);
%# vertical line
hx = graph2d.constantline(0, 'LineStyle',':', 'Color',[.7 .7 .7]);
changedependvar(hx,'x');

%# horizontal line
hy = graph2d.constantline(0, 'Color',[.7 .7 .7]);
changedependvar(hy,'y');

hold on
plot(t_2,V_2);
hold off