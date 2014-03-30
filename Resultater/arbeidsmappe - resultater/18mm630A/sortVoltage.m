close all
clear all
format long

%For å bytte ut komma: sed -i.backup 's/[,]/./g' filnavnetditt.txt
%If this script is run in matlab, comment out fflush. in Octave use the
%fflyuh function to write out run info on the screen.
%Loading the different data sections
disp('Starting: Loading data');
%fflush(stdout);
test_ONE=load('136_pos17_TR_TR.lvm');
test_TWO=load('073_pos19_TR_TR.lvm');
test_THREE=load('130_pos18_TR_TR.lvm');
test_FOUR=load('143_pos18_TR_TR.lvm'); %load('126_pos18_TR_OK.lvm'); %
test_FIVE=load('080_pos17_TR_TR.lvm'); %load('153_pos17_TR_TR_TR_OK.lvm'); %
disp('Loading data: OK!');
%fflush(stdout);
test_FIVE(:,2)=test_FIVE(:,2).*-1;
%Smoothing the datas, wnd decides the grade og smoothing. 
disp('Starting: Smoothing data sections');
%fflush(stdout);
wnd = 200;output_ONE = filter(ones(wnd, 1)/wnd, 1, test_ONE(:,2));
wnd = 200;output_TWO = filter(ones(wnd, 1)/wnd, 1, test_TWO(:,2));
wnd = 200;output_THREE = filter(ones(wnd, 1)/wnd, 1, test_THREE(:,2));
wnd = 200;output_FOUR = filter(ones(wnd, 1)/wnd, 1, test_FOUR(:,2));
wnd = 200;output_FIVE = filter(ones(wnd, 1)/wnd, 1, test_FIVE(:,2)); 
disp('Smoothing data sections: OK!');
%fflush(stdout);
%Findes the derivatives of the data section
disp('Staring: Derivate data sections');
%fflush(stdout);
diffV1=diff(output_ONE);
diffV2=diff(output_TWO);
diffV3=diff(output_THREE);
diffV4=diff(output_FOUR);
diffV5=diff(output_FIVE);
disp('Derivate data sections: OK!');
disp('Starting: Calculating extremal points');
%fflush(stdout);
[m,i]=max(diffV1); 
[m,j]=max(diffV2);
[m,h]=max(diffV3); 
[m,y]=max(diffV4);
[m,t]=max(diffV5);
%y=y-49125;
%t=t-49100;

%Findes where the max and min peak of the data section are
[m,k]=max(output_ONE);
[m,o]=max(output_TWO);
[m,q]=max(output_THREE);
[m,w]=max(output_FOUR);
[m,a]=max(output_FIVE);

[m,l]=min(output_ONE);
[m,p]=min(output_TWO);
[m,z]=min(output_THREE);
z=z+250;
[m,x]=min(output_FOUR);
[m,c]=min(output_FIVE);
disp('Calculating extremal points:OK!');
disp('Starting: Time shifting data sections');
%fflush(stdout);
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
%fflush(stdout);
%Plotting the data
figure(1);
plot(test_ONE(:,1),output_ONE,'r');
xlabel('Time [s]');
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
%fflush(stdout);
%Calculating the sum
SUM_1=[sum(output_ONE),sum(output_TWO),sum(output_THREE),sum(output_FOUR),sum(output_FIVE)];
[m,i]=max(SUM_1);
[n,j]=min(SUM_1);
%Calculating average of the five data sections
j=2;
r=1;
for r=50500:(length(output_ONE)-50500)
	average_Output(r)=(output_ONE(r)+output_TWO(r+(p-l))+output_THREE(r+(z-l))+output_FOUR(r+(x-l))+output_FIVE(r+(c-l)))./5;
end
disp('Calculating average: OK!');
%fflush(stdout);

%Plotting the average and the lowest and highest data intevall
disp('Starting: Plotting voltage average');
%fflush(stdout);
r=1;
g=50500;
testTime=1:length(average_Output);
for r=1:length(average_Output)
	testTime(r)=test_ONE(g,1);
	g=g+1;
end
r=1;
g=50500;
for r=1:length(average_Output)
	testTime2(r)=test_TWO(g,1);
	g=g+1;
end
r=1;
g=50500;
for r=1:length(average_Output)
	testTime3(r)=test_THREE(g,1);
	g=g+1;
end
r=1;
g=50500;
for r=1:length(average_Output)
	testTime4(r)=test_FOUR(g,1);
	g=g+1;
end
r=1;
g=50500;
for r=1:length(average_Output)
	testTime5(r)=test_FIVE(g,1);
	g=g+1;
end
figure(2);
plot(testTime,average_Output,'b');
xlabel('Time [s]');
ylabel('Average arcing voltage [kV]');
disp('Plotting voltage average: OK!');
hold on
if i==1
    for r=50500:(length(output_ONE)-50500)
	output_ONE_inter(r)=output_ONE(r);
    end
    plot(testTime,output_ONE_inter,'r');
end
if i==2
    for r=50500:(length(output_ONE)-50500)
	output_TWO_inter(r)=output_TWO(r);
    end
    plot(testTime2,output_TWO_inter,'r');
end
if i==3
    for r=50500:(length(output_ONE)-50500)
	output_THREE_inter(r)=output_THREE(r);
    end
    plot(testTime3,output_THREE_inter,'r');  
end
if i==4
    for r=50500:(length(output_ONE)-50500)
	output_FOUR_inter(r)=output_FOUR(r);
    end
    plot(testTime4,output_FOUR_inter,'r');
end
if i==5
    for r=50500:(length(output_ONE)-50500)
	output_FIVE_inter(r)=output_FIVE(r);
    end    
    plot(testTime5,output_FIVE_inter,'r');
end
if j==1
    for r=50500:(length(output_ONE)-50500)
	output_ONE_inter(r)=output_ONE(r);
    end    
    plot(testTime,output_ONE_inter,'g');
end
if j==2
    for r=50500:(length(output_ONE)-50500)
	output_TWO_inter(r)=output_TWO(r);
    end
    plot(testTime2,output_TWO_inter,'g');
end
if j==3
    for r=50500:(length(output_ONE)-50500)
	output_THREE_inter(r)=output_THREE(r);
    end    
    plot(testTime3,output_THREE_inter,'g');  
end
if j==4
    for r=50500:(length(output_ONE)-50500)
	output_FOUR_inter(r)=output_FOUR(r);
    end    
    plot(testTime4,output_FOUR_inter,'g');
end
if j==5
    for r=50500:(length(output_ONE)-50500)
	output_FIVE_inter(r)=output_FIVE(r);
    end    
    plot(testTime5,output_FIVE_inter,'g');
end
hold off
%fflush(stdout);

%Calculating the spread of data
disp('Starting: Calcultaing standard deviation');
p_1=0.02; %this value  must be adjusted by looking at the plot
p_2=p_1+0.0035; %the length of the area to integrate
x_1=find(test_ONE(:,1)==p_1);
x_2=find(test_ONE(:,1)==p_2);
m=1;
summer=1:5;
sumAverage_Output=0;
for k=1:length(summer)
	summer(k)=0;
end
for m=x_1(1):x_2(1)
	summer(1)=summer(1)+output_ONE(m);
	summer(2)=summer(2)+output_TWO(m);
	summer(3)=summer(3)+output_THREE(m);
	summer(4)=summer(4)+output_FOUR(m);
	summer(5)=summer(5)+output_FIVE(m);
	sumAverage_Output=sumAverage_Output+average_Output(m);
end

summer=abs(summer);
sumAverage_Output=abs(sumAverage_Output);
%Standard deviation
Spread=0;
Spread=sqrt(((summer(1)-sumAverage_Output)^2+(summer(2)-sumAverage_Output)^2+(summer(3)-sumAverage_Output)^2+(summer(4)-sumAverage_Output)^2+(summer(5)-sumAverage_Output)^2)/4);

disp(Spread);

disp('Calcultaing standard deviation: OK!');

%Loading the different data sections
disp('Starting: Loading data 2');
%fflush(stdout);
test_ONE_OK=load('115_pos18_Ok.lvm');
test_TWO_OK=load('110_pos18_OK.lvm');
test_THREE_OK=load('152_pos18_OK.lvm');
test_FOUR_OK=load('144_pos17_OK.lvm');
test_FIVE_OK=load('137_pos19_OK.lvm');
disp('Loading data 2: OK!');
%fflush(stdout);

%Smoothing the datas, wnd decides the grade og smoothing. wnd=500 lit for grov, men funker ok når den bryter.
disp('Starting: Smoothing data sections');
%fflush(stdout);
wnd = 200;output_ONE_OK = filter(ones(wnd, 1)/wnd, 1, test_ONE_OK(:,2));
wnd = 200;output_TWO_OK = filter(ones(wnd, 1)/wnd, 1, test_TWO_OK(:,2));
wnd = 200;output_THREE_OK = filter(ones(wnd, 1)/wnd, 1, test_THREE_OK(:,2));
wnd = 200;output_FOUR_OK = filter(ones(wnd, 1)/wnd, 1, test_FOUR_OK(:,2));
wnd = 200;output_FIVE_OK = filter(ones(wnd, 1)/wnd, 1, test_FIVE_OK(:,2)); 
disp('Smoothing data sections: OK!');
%fflush(stdout);

%Findes the derivatives of the data section
disp('Staring: Derivate data sections');
%fflush(stdout);
diffV1=diff(output_ONE_OK);
diffV2=diff(output_TWO_OK);
diffV3=diff(output_THREE_OK);
diffV4=diff(output_FOUR_OK);
diffV5=diff(output_FIVE_OK);
disp('Derivate data sections: OK!');
disp('Starting: Calculating extremal points');
%fflush(stdout);
[m,f]=max(diffV1); 
[m,d]=max(diffV2);
[m,h]=max(diffV3); 
[m,y]=max(diffV4);
[m,t]=max(diffV5);

%Findes where the max and min peak of the data section are
[m,k]=max(output_ONE_OK);
[m,o]=max(output_TWO_OK);
o=o+650;
[m,q]=max(output_THREE_OK);
q=q+100;
[m,w]=max(output_FOUR_OK);
w=w-100;
[m,a]=max(output_FIVE_OK);
a=a-450;

[m,l]=min(output_ONE_OK);
[m,p]=min(output_TWO_OK);
[m,z]=min(output_THREE_OK);
[m,x]=min(output_FOUR_OK);
[m,c]=min(output_FIVE_OK);
disp('Calculating extremal points:OK!');

disp('Starting: Time shifting data sections');
%fflush(stdout);
%Time shifts the graphs, so that the CZ occures at the same moment. Different methodes can be used by changing the %.
%Time shifts ONE and TWO
%test_TWO_OK(:,1)=test_TWO_OK(:,1)+(test_ONE_OK(f,1)-test_TWO_OK(d,1)); %tidsforskyver, slik at maks derivert kommer på samme plass.
test_TWO_OK(:,1)=test_TWO_OK(:,1)+(test_ONE_OK(k,1)-test_TWO_OK(o,1)); %tidsforskyver, med hensyn på topppunkt
%test_TWO_OK(:,1)=test_TWO_OK(:,1)+(test_ONE_OK(l,1)-test_TWO_OK(p,1)); %tidsforskyver, med hensyn på minpunkt

%Time shifts ONE and THREE
%test_THREE_OK(:,1)=test_THREE_OK(:,1)+(test_ONE_OK(f,1)-test_THREE_OK(h,1)); %tidsforskyver, slik at maks derivert kommer på samme plass.
test_THREE_OK(:,1)=test_THREE_OK(:,1)+(test_ONE_OK(k,1)-test_THREE_OK(q,1)); %tidsforskyver, med hensyn på topppunkt
%test_THREE_OK(:,1)=test_THREE_OK(:,1)+(test_ONE_OK(l,1)-test_THREE_OK(z,1)); %tidsforskyver, med hensyn på minpunkt

%Time shifts ONE and FOUR
%test_FOUR_OK(:,1)=test_FOUR_OK(:,1)+(test_ONE_OK(f,1)-test_FOUR_OK(y,1)); %tidsforskyver, slik at maks derivert kommer på samme plass.
test_FOUR_OK(:,1)=test_FOUR_OK(:,1)+(test_ONE_OK(k,1)-test_FOUR_OK(w,1)); %tidsforskyver, med hensyn på topppunkt
%test_FOUR_OK(:,1)=test_FOUR_OK(:,1)+(test_ONE_OK(l,1)-test_FOUR_OK(x,1)); %tidsforskyver, med hensyn på minpunkt

%Time shifts ONE and FIVE
%test_FIVE_OK(:,1)=test_FIVE_OK(:,1)+(test_ONE_OK(f,1)-test_FIVE_OK(t,1)); %tidsforskyver, slik at maks derivert kommer på samme plass.
test_FIVE_OK(:,1)=test_FIVE_OK(:,1)+(test_ONE_OK(k,1)-test_FIVE_OK(a,1)); %tidsforskyver, med hensyn på topppunkt
%test_FIVE_OK(:,1)=test_FIVE_OK(:,1)+(test_ONE_OK(l,1)-test_FIVE_OK(c,1)); %tidsforskyver, med hensyn på minpunkt
disp('Time shifting data sections: OK!');
disp('Starting: Plotting data');
%fflush(stdout);
%Plotting the data
figure(3);
plot(test_ONE_OK(:,1),output_ONE_OK,'r');
xlabel('Time [s]');
ylabel('Arcing voltage [kV]');
hold on
plot(test_TWO_OK(:,1),output_TWO_OK,'b');
hold on
plot(test_THREE_OK(:,1),output_THREE_OK,'y');
hold on
plot(test_FOUR_OK(:,1),output_FOUR_OK,'g');
hold on
plot(test_FIVE_OK(:,1),output_FIVE_OK,'m');
hold off;
disp('Plotting data: OK!');
disp('Starting: Calculating average');
%fflush(stdout);
%Calculating the sum of the five data sections
SUM_2=[sum(output_ONE_OK),sum(output_TWO_OK),sum(output_THREE_OK),sum(output_FOUR_OK),sum(output_FIVE_OK)];
[m,i]=max(SUM_2);
[n,j]=min(SUM_2);
%Calculating average of the five data sections

r=1;
for r=25000:(length(output_ONE_OK)-25000)
	average_Output_OK(r)=(output_ONE_OK(r)+output_TWO_OK(r+(o-k))+output_THREE_OK(r+(q-k))+output_FOUR_OK(r+(w-k))+output_FIVE_OK(r+(a-k)))./5;
end
disp('Calculating average: OK!');
%fflush(stdout);

%Plotting the average
disp('Starting: Plotting voltage average');
%fflush(stdout);
r=1;
g=25000;
testTime=1:length(average_Output_OK);
for r=1:length(average_Output_OK)
	testTime(r)=test_ONE_OK(g,1);
	g=g+1;
end
r=1;
g=25000;
testTime2=1:length(average_Output_OK);
for r=1:length(average_Output_OK)
	testTime2(r)=test_TWO_OK(g,1);
	g=g+1;
end
r=1;
g=25000;
testTime3=1:length(average_Output_OK);
for r=1:length(average_Output_OK)
	testTime3(r)=test_THREE_OK(g,1);
	g=g+1;
end
r=1;
g=25000;
testTime4=1:length(average_Output_OK);
for r=1:length(average_Output_OK)
	testTime4(r)=test_FOUR_OK(g,1);
	g=g+1;
end
r=1;
g=25000;
testTime5=1:length(average_Output_OK);
for r=1:length(average_Output_OK)
	testTime5(r)=test_FIVE_OK(g,1);
	g=g+1;
end
j=1;
i=5;
figure(4);
plot(testTime,average_Output_OK,'b');
xlabel('Time [s]');
ylabel('Average arcing voltage [kV]');
disp('Plotting voltage average: OK!');
hold on
if i==1
    for r=25000:(length(output_ONE_OK)-25000)
	output_ONE_inter_OK(r)=output_ONE_OK(r);
    end
    plot(testTime,output_ONE_inter_OK,'r');
end
if i==2
    for r=25000:(length(output_ONE_OK)-25000)
	output_TWO_inter_OK(r)=output_TWO_OK(r);
    end
    plot(testTime2,output_TWO_inter_OK,'r');
end
if i==3
    for r=25000:(length(output_ONE_OK)-25000)
	output_THREE_inter_OK(r)=output_THREE_OK(r);
    end
    plot(testTime3,output_THREE_inter_OK,'r');  
end
if i==4
    for r=25000:(length(output_ONE_OK)-25000)
	output_FOUR_inter_OK(r)=output_FOUR_OK(r);
    end
    plot(testTime4,output_FOUR_inter_OK,'r');
end
if i==5
    for r=25000:(length(output_ONE_OK)-25000)
	output_FIVE_inter_OK(r)=output_FIVE_OK(r);
    end    
    plot(testTime5,output_FIVE_inter_OK,'r');
end
if j==1
    for r=25000:(length(output_ONE_OK)-25000)
	output_ONE_inter_OK(r)=output_ONE_OK(r);
    end    
    plot(testTime,output_ONE_inter_OK,'g');
end
if j==2
    for r=25000:(length(output_ONE_OK)-25000)
	output_TWO_inter_OK(r)=output_TWO_OK(r);
    end
    plot(testTime2,output_TWO_inter_OK,'g');
end
if j==3
    for r=25000:(length(output_ONE_OK)-25000)
	output_THREE_inter_OK(r)=output_THREE_OK(r);
    end    
    plot(testTime3,output_THREE_inter_OK,'g');  
end
if j==4
    for r=25000:(length(output_ONE_OK)-25000)
	output_FOUR_inter_OK(r)=output_FOUR_OK(r);
    end    
    plot(testTime4,output_FOUR_inter_OK,'g');
end
if j==5
    for r=1000:(length(output_ONE_OK)-25000)
	output_FIVE_inter_OK(r)=output_FIVE_OK(r);
    end    
    plot(testTime5,output_FIVE_inter_OK,'g');
end
hold off
%fflush(stdout);

%Calculating the spread of data
disp('Starting: Calcultaing standard deviation');
p_1=0.0147; %this value  must be adjusted by looking at the plot
p_2=p_1+0.0035; %the length of the area to integrate
x_1=find(test_ONE(:,1)==p_1);
x_2=find(test_ONE(:,1)==p_2);
m=1;
summer=1:5;
sumAverage_Output=0;
for k=1:length(summer)
	summer(k)=0;
end
for m=x_1(1):x_2(1)
	summer(1)=summer(1)+output_ONE_OK(m);
	summer(2)=summer(2)+output_TWO_OK(m);
	summer(3)=summer(3)+output_THREE_OK(m);
	summer(4)=summer(4)+output_FOUR_OK(m);
	summer(5)=summer(5)+output_FIVE_OK(m);
	sumAverage_Output=sumAverage_Output+average_Output_OK(m);
end

summer=abs(summer);
sumAverage_Output=abs(sumAverage_Output);
%Standard deviation
Spread=0;
Spread=sqrt(((summer(1)-sumAverage_Output)^2+(summer(2)-sumAverage_Output)^2+(summer(3)-sumAverage_Output)^2+(summer(4)-sumAverage_Output)^2+(summer(5)-sumAverage_Output)^2)/4);

disp(Spread);

disp('Calcultaing standard deviation: OK!');

disp('END');
