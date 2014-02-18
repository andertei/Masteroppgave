close all
clear all
format long

%For å bytte ut komma: sed -i.backup 's/[,]/./g' filnavnetditt.txt
%If this script is run in matlab, comment out fflush. in Octave use the
%fflyuh function to write out run info on the screen.
%Loading the different data sections

disp('Starting: Loading data');
%fflush(stdout);
%test_TWO=load('125_d4_D10_TR.lvm');
test_THREE=load('127_d4_D10_TR.lvm');
%test_FOUR=load('128_d4_D10_TR.lvm');
disp('Loading data: OK!');
%fflush(stdout);




disp('Starting: Smoothing data sections');
%fflush(stdout);
%wnd = 100;output_TWO = filter(ones(wnd, 1)/wnd, 1, test_TWO(:,2));
wnd = 100;output_THREE = filter(ones(wnd, 1)/wnd, 1, test_THREE(:,2));
%wnd = 100;output_FOUR = filter(ones(wnd, 1)/wnd, 1, test_FOUR(:,2));
%wnd = 100;output_TWO_c = filter(ones(wnd, 1)/wnd, 1, test_TWO(:,6));
wnd = 100;output_THREE_c = filter(ones(wnd, 1)/wnd, 1, test_THREE(:,6));
%wnd = 100;output_FOUR_c = filter(ones(wnd, 1)/wnd, 1, test_FOUR(:,6));

disp('Smoothing data sections: OK!');

x_1=7.016*10^4;
x_2=1.695*10^5;
j=1;
for i=x_1:x_2
    voltage(j)=output_THREE(i);
    current(j)=output_THREE_c(i);
    j=j+1;
end

figure(1);
plot(current,voltage);
xlabel('Current [A]');
ylabel('Arcing voltage [kV]');
