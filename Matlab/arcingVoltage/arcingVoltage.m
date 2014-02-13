close all
clear all
format long

%For å bytte ut komma: sed -i.backup 's/[,]/./g' filnavnetditt.txt
%If this script is run in matlab, comment out fflush. in Octave use the
%fflyuh function to write out run info on the screen.
%Loading the different data sections

disp('Starting: Loading data');
fflush(stdout);
test_TWO=load('125_d4_D10_TR.lvm');
test_THREE=load('127_d4_D10_TR.lvm');
test_FOUR=load('128_d4_D10_TR.lvm');
disp('Loading data: OK!');
fflush(stdout);

disp('Starting: Smoothing data sections');
fflush(stdout);
wnd = 200;output_TWO = filter(ones(wnd, 1)/wnd, 1, test_TWO(:,2));
wnd = 200;output_THREE = filter(ones(wnd, 1)/wnd, 1, test_THREE(:,2));
wnd = 200;output_FOUR = filter(ones(wnd, 1)/wnd, 1, test_FOUR(:,2));
disp('Smoothing data sections: OK!');


%Findes the derivatives of the data section
disp('Staring: Derivate data sections');
fflush(stdout);
diffV2=diff(output_TWO);
diffV3=diff(output_THREE);
diffV4=diff(output_FOUR);
disp('Derivate data sections: OK!');
disp('Starting: Calculating extremal points');
fflush(stdout);
[m,j]=max(diffV2);
[m,h]=max(diffV3); 
[m,y]=max(diffV4);

%Findes where the max and min peak of the data section are
[m,o]=max(output_TWO);
[m,q]=max(output_THREE);
[m,w]=max(output_FOUR);

[m,p]=min(output_TWO);
[m,z]=min(output_THREE);
[m,x]=min(output_FOUR);
disp('Calculating extremal points:OK!');
disp('Starting: Time shifting data sections');
fflush(stdout);
%Time shifts the graphs, so that the CZ occures at the same moment. Different methodes can be used by changing the %.


%Time shifts ONE and THREE
%test_THREE(:,1)=test_THREE(:,1)+(test_TWO(j,1)-test_THREE(h,1)); %tidsforskyver, slik at maks derivert kommer på samme plass.
%test_THREE(:,1)=test_THREE(:,1)+(test_TWO(o,1)-test_THREE(q,1)); %tidsforskyver, med hensyn på topppunkt
test_THREE(:,1)=test_THREE(:,1)+(test_TWO(p,1)-test_THREE(z,1)); %tidsforskyver, med hensyn på minpunkt

%Time shifts ONE and FOUR
%test_FOUR(:,1)=test_FOUR(:,1)+(test_TWO(j,1)-test_FOUR(y,1)); %tidsforskyver, slik at maks derivert kommer på samme plass.
%test_FOUR(:,1)=test_FOUR(:,1)+(test_TWO(o,1)-test_FOUR(w,1)); %tidsforskyver, med hensyn på topppunkt
test_FOUR(:,1)=test_FOUR(:,1)+(test_TWO(p,1)-test_FOUR(x,1)); %tidsforskyver, med hensyn på minpunkt

disp('Time shifting data sections: OK!');

%Plotting the data
figure(1);
plot(test_TWO(:,1),output_TWO,'b');
xlabel('Time [s]');
ylabel('Arcing voltage [kV]');
hold on
plot(test_THREE(:,1),output_THREE,'y');
hold on
plot(test_FOUR(:,1),output_FOUR,'g');
hold off;
disp('Plotting data: OK!');

r=1;
for r=1000:(length(output_TWO)-1000)
	average_Output(r)=(output_TWO(r)+output_THREE(r+(z-p))+output_FOUR(r+(x-p)))./3;
end
disp('Calculating average: OK!');
fflush(stdout);

%Plotting the average
disp('Starting: Plotting voltage average');
fflush(stdout);
r=1;
g=1000;
testTime=1:length(average_Output);
for r=1:length(average_Output)
	testTime(r)=test_TWO(g,1);
	g=g+1;
end

figure(2);
plot(testTime,average_Output,'r');
xlabel('Time [s]');
ylabel('Average arcing voltage [kV]');
disp('Plotting voltage average: OK!');

%Using the average arcing voltage to calculate voltage between the electrods and arcing voltage that is caused by the length of the arc
t_start=0.013971;
index_start=find(testTime==t_start,1);
%if the contact speed is 5 m/s the arc will be 1 mm after 2*10^-4 sec
t_end=t_start+2*10^-4;
t_end=0.014171;
summer=0;
index_end=find(testTime==t_end,1);
deltaIndex=index_end-index_start;
for i=index_start:index_end
	summer=average_Output(i)+summer;
end
average_start=summer/deltaIndex;
average_start_V=abs(average_start)*1000;
disp('Average when the arc is 1 mm in volt (V):');
disp(average_start_V);
%uses linear regretion to find the rise
index_1=find(testTime==0.018528,1);
index_2=find(testTime==0.021654,1);

a=(average_Output(index_1)-average_Output(index_2))/(0.018528-0.021654);
a=a/5; %converts kV/s to kV/m
disp('rise: in kV/m');
disp(a);


