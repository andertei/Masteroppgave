close all
clear all
format long

arcing_voltage=load('301_pos23_TR.lvm');

wnd = 20;arcing_voltage_filter = filter(ones(wnd, 1)/wnd, 1, arcing_voltage(:,2));

arcing_voltage(:,1)=arcing_voltage(:,1).*1000;

figure(1);
plot(arcing_voltage(:,1),arcing_voltage_filter,'b');
xlabel('Time [ms]');
ylabel('Arcing voltage [kV]');