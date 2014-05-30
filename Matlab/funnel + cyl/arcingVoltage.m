close all
clear all
format long

%For å bytte ut komma: sed -i.backup 's/[,]/./g' filnavnetditt.txt
%If this script is run in matlab, comment out %fflush. in Octave use the
%fflyuh function to write out run info on the screen.
%Loading the different data sections

disp('Starting: Loading data');
%fflush(stdout);
%126_pos18_TR_OK.lvm
test_ONE=load('126_pos18_TR_OK.lvm');
test_TWO=load('201_pos_TR_OK.lvm');
disp('Loading data: OK!');
%fflush(stdout);

disp('Starting: Smoothing data sections');
%fflush(stdout);
test_ONE(:,1)=test_ONE(:,1).*1000;
test_ONE(:,2)=test_ONE(:,2).*-1;
test_TWO(:,1)=test_TWO(:,1).*1000;
wnd = 100;output_ONE = filter(ones(wnd, 1)/10*wnd, 1, test_ONE(:,2));
wnd = 100;output_TWO = filter(ones(wnd, 1)/10*wnd, 1, test_TWO(:,2));
%output_TWO=output_TWO./10;
%wnd = 80;output_t = filter(ones(wnd, 1)/wnd, 1, test_TWO(:,6));
disp('Smoothing data sections: OK!');

%Findes the derivatives of the data section
disp('Staring: Derivate data sections');
%fflush(stdout);
diffV1=diff(output_ONE);
diffV2=diff(output_TWO);

disp('Derivate data sections: OK!');
disp('Starting: Calculating extremal points');
%fflush(stdout);
[m,f]=max(diffV1); 
[m,d]=max(diffV2);
%d=d+50000;

%Findes where the max and min peak of the data section are
[m,k]=max(output_ONE);
[m,o]=max(output_TWO);
o=o-361;
[m,l]=min(output_ONE);
[m,p]=min(output_TWO);

disp('Calculating extremal points:OK!');

disp('Starting: Time shifting data sections');
%fflush(stdout);
%Time shifts the graphs, so that the CZ occures at the same moment. Different methodes can be used by changing the %.
%Time shifts ONE and TWO
%test_TWO(:,1)=test_TWO(:,1)+(test_ONE(f,1)-test_TWO(d,1)); %tidsforskyver, slik at maks derivert kommer på samme plass.
test_TWO(:,1)=test_TWO(:,1)+(test_ONE(k,1)-test_TWO(o,1)); %tidsforskyver, med hensyn på topppunkt
%test_TWO(:,1)=test_TWO(:,1)+(test_ONE(l,1)-test_TWO(p,1)); %tidsforskyver, med hensyn på minpunkt

disp('Time shifting data sections: OK!');

disp('Starting: Plotting data');
%fflush(stdout);
%Plotting the data
figure(1);
plot(test_ONE(:,1),output_ONE,'r');
xlabel('Time [ms]');
ylabel('Arcing voltage [V]');
hold on
plot(test_TWO(:,1),output_TWO,'b');
hold off
disp('Plotting data: OK!');

%figure(1);
%plot(test_TWO(:,1),output_t,'b');
%hold off
%plot(test_TWO(:,1),output_TWO,'k');
%xlabel('Time [ms]');
%ylabel('Arcing voltage [V]');
%disp('Plotting data: OK!');


