close all
clear all
format long

%For å bytte ut komma: sed -i.backup 's/[,]/./g' filnavnetditt.txt
%If this script is run in matlab, comment out %fflush. in Octave use the
%fflyuh function to write out run info on the screen.
%Loading the different data sections

disp('Starting: Loading data');
%fflush(stdout);
test_TWO=load('258_test_spenningsmaaling.lvm');
disp('Loading data: OK!');
%fflush(stdout);
test_TWO(:,2)=test_TWO(:,2).*1000;
test_TWO(:,1)=test_TWO(:,1).*1000;
figure(1);
plot(test_TWO(:,1),test_TWO(:,2),'g');
ylabel('Voltage [V]');
xlabel('Time [ms]');
disp('Plotting data: OK!');

disp('Starting: Loading data');
%fflush(stdout);
test_1=load('259_test_spenningsmaaling.lvm');
disp('Loading data: OK!');
%fflush(stdout);
test_1(:,2)=test_1(:,2).*1000;
test_1(:,1)=test_1(:,1).*1000;
figure(2);
plot(test_1(:,1),test_1(:,2),'r');
ylabel('Voltage [V]');
xlabel('Time [ms]');
disp('Plotting data: OK!');


