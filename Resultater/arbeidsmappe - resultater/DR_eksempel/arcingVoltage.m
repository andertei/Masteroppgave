close all
clear all
format long

%For å bytte ut komma: sed -i.backup 's/[,]/./g' filnavnetditt.txt
%If this script is run in matlab, comment out %fflush. in Octave use the
%fflyuh function to write out run info on the screen.
%Loading the different data sections

disp('Starting: Loading data');
%fflush(stdout);
test_TWO=load('305_pos10_DR.lvm');
disp('Loading data: OK!');
%fflush(stdout);

disp('Starting: Smoothing data sections');
%fflush(stdout);
test_TWO(:,1)=test_TWO(:,1).*1000;
wnd = 100;output_TWO = filter(ones(wnd, 1)/10*wnd, 1, test_TWO(:,2));
output_TWO=output_TWO./10;
wnd = 80;output_t = filter(ones(wnd, 1)/wnd, 1, test_TWO(:,6));
disp('Smoothing data sections: OK!');


figure(1);
plot(test_TWO(:,1),output_t,'b');
hold on
plot(test_TWO(:,1),output_TWO,'k');
xlabel('Time [ms]');
disp('Plotting data: OK!');


