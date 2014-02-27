clear all
close all
format long


t=0.00875:0.000000001:0.01125;
t_2=0:0.000000001:2.5*10^(-3);

V_1=7071.06*sin(2*pi*200*t-(pi/2+pi));
V_2=-353.55*sin(2*pi*4000*t);


figure(1)
plot(t_2,V_1,'b');
xlabel('Time [s]');
ylabel('Current [A]');

hold on
plot(t_2,V_2,'r');
hold off

t=0.01115:0.000000001:0.01125;
t_2=0:0.000000001:0.0001;

V_1=7071.06*sin(2*pi*200*t-(pi/2+pi));
V_2=-353.55*sin(2*pi*4000*t);

figure(2)
plot(t_2,V_1,'b');

xlabel('Time [s]');
ylabel('Current [A]');

hold on
plot(t_2,V_2,'r');
hold off
