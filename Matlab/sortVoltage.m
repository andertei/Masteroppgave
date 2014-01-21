close all
clear all
format long

%For å bytte ut komma: sed -i.backup 's/[,]/./g' filnavnetditt.txt

%Loading the different data sections
disp('Starting: Loading data');
fflush(stdout);
test_ONE=load('128_d4_D10_TR.lvm');
test_TWO=load('116_d4_D10_TR.lvm');
test_THREE=load('118_d4_D10_TR.lvm');
test_FOUR=load('128_d4_D10_TR.lvm');
test_FIVE=load('125_d4_D10_TR.lvm');
disp('Loading data: OK!');
fflush(stdout);
%Smoothing the datas, wnd decides the grade og smoothing. wnd=500 lit for grov, men funker ok når den bryter.
disp('Starting: Smoothing data sections');
fflush(stdout);
wnd = 100;output_ONE = filter(ones(wnd, 1)/wnd, 1, test_ONE(:,2));
wnd = 100;output_TWO = filter(ones(wnd, 1)/wnd, 1, test_TWO(:,2));
wnd = 100;output_THREE = filter(ones(wnd, 1)/wnd, 1, test_THREE(:,2));
wnd = 100;output_FOUR = filter(ones(wnd, 1)/wnd, 1, test_FOUR(:,2));
wnd = 100;output_FIVE = filter(ones(wnd, 1)/wnd, 1, test_FIVE(:,2)); 
disp('Smoothing data sections: OK!');
fflush(stdout);
%Findes the derivatives of the data section
disp('Staring: Derivate data sections');
fflush(stdout);
diffV1=diff(output_ONE);
diffV2=diff(output_TWO);
diffV3=diff(output_ONE);
diffV4=diff(output_TWO);
diffV5=diff(output_ONE);
disp('Derivate data sections: OK!');
disp('Starting: Calculating extremal points');
fflush(stdout);
[m,i]=max(diffV1); 
[m,j]=max(diffV2);
[m,h]=max(diffV3); 
[m,y]=max(diffV4);
[m,t]=max(diffV5);

%Findes where the max and min peak of the data section are
[m,k]=max(output_ONE);
[m,o]=max(output_TWO);
[m,q]=max(output_THREE);
[m,w]=max(output_FOUR);
[m,a]=max(output_FIVE);

[m,l]=min(output_ONE);
[m,p]=min(output_TWO);
[m,z]=min(output_THREE);
[m,x]=min(output_FOUR);
[m,c]=min(output_FIVE);
disp('Calculating extremal points:OK!');
disp('Starting: Time shifting data sections');
fflush(stdout);
%Time shifts the graphs, so that the CZ occures at the same moment. Different methodes can be used by changing the %.
%Time shifts ONE and TWO
%test_TWO(:,1)=test_TWO(:,1)+(test_ONE(i,1)-test_TWO(j,1)); %tidsforskyver, slik at maks derivert kommer på samme plass.
%test_TWO(:,1)=test_TWO(:,1)+(test_ONE(k,1)-test_TWO(o,1)); %tidsforskyver, med hensyn på topppunkt
test_TWO(:,1)=test_TWO(:,1)+(test_ONE(l,1)-test_TWO(p,1)); %tidsforskyver, med hensyn på minpunkt

%Time shifts ONE and THREE
%test_THREE(:,1)=test_THREE(:,1)+(test_ONE(i,1)-test_THREE(h,1)); %tidsforskyver, slik at maks derivert kommer på samme plass.
%test_THREE(:,1)=test_THREE(:,1)+(test_ONE(k,1)-test_THREE(q,1)); %tidsforskyver, med hensyn på topppunkt
test_THREE(:,1)=test_THREE(:,1)+(test_ONE(l,1)-test_THREE(z,1)); %tidsforskyver, med hensyn på minpunkt

%Time shifts ONE and FOUR
%test_FOUR(:,1)=test_FOUR(:,1)+(test_ONE(i,1)-test_FOUR(y,1)); %tidsforskyver, slik at maks derivert kommer på samme plass.
%test_FOUR(:,1)=test_FOUR(:,1)+(test_ONE(k,1)-test_FOUR(w,1)); %tidsforskyver, med hensyn på topppunkt
test_FOUR(:,1)=test_FOUR(:,1)+(test_ONE(l,1)-test_FOUR(x,1)); %tidsforskyver, med hensyn på minpunkt

%Time shifts ONE and FIVE
%test_FIVE(:,1)=test_FIVE(:,1)+(test_ONE(i,1)-test_FIVE(t,1)); %tidsforskyver, slik at maks derivert kommer på samme plass.
%test_FIVE(:,1)=test_FIVE(:,1)+(test_ONE(k,1)-test_FIVE(a,1)); %tidsforskyver, med hensyn på topppunkt
test_FIVE(:,1)=test_FIVE(:,1)+(test_ONE(l,1)-test_FIVE(c,1)); %tidsforskyver, med hensyn på minpunkt
disp('Time shifting data sections: OK!');
disp('Starting: Plotting data');
fflush(stdout);
%Plotting the data
figure(1);
plot(test_ONE(:,1),output_ONE,'r');
xlabel('Time [us]');
ylabel('Arcing voltage [kV]');
hold on
plot(test_TWO(:,1),output_TWO,'b');
hold on
plot(test_THREE(:,1),output_THREE,'y');
hold on
plot(test_FOUR(:,1),output_FOUR,'g');
hold on
plot(test_FIVE(:,1),output_FIVE,'m');
hold off;
disp('Plotting data: OK!');
disp('Starting: Calculating average');
fflush(stdout);

%Calculating average of the five data sections IKKE FERDIG

r=1;
for r=1000:(length(output_ONE)-1000)
	average_Output(r)=(output_ONE(r)+output_TWO(r+(p-l))+output_THREE(r+(z-l))+output_FOUR(r+(x-l))+output_FIVE(r+(c-l)))./5;
end
disp('Calculating average: OK!');
fflush(stdout);

%Plotting the average
disp('Starting: Plotting voltage average');
fflush(stdout);
r=1;
g=1000;
for r=1:length(average_Output)
	testTime(r)=test_ONE(g,1);
g=g+1;
end
figure(2);
plot(testTime,average_Output,'b');
xlabel('Time [us]');
ylabel('Average arcing voltage [kV]');
disp('Plotting voltage average: OK!');
fflush(stdout);

disp('END');
