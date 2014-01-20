close all
clear all
format long


test_ONE_OK=load('12_400_d4_d8_Ok_new.lvm');

test_TWO_OK=load('15_400_d4_d8_OK.lvm');

wnd = 500;output_ONE = filter(ones(wnd, 1)/wnd, 1, test_ONE_OK(:,2));

wnd = 500;output_TWO = filter(ones(wnd, 1)/wnd, 1, test_TWO_OK(:,2)); %smoother dataene

diffV1=diff(output_ONE); %finner de deriverte
diffV2=diff(output_TWO);

[m,i]=max(diffV1); %finner posisjonen til max av de deriverte
[m,j]=max(diffV2);

test_TWO_OK(:,1)=test_TWO_OK(:,1)+(test_ONE_OK(i,1)-test_TWO_OK(j,1)); %tidsforskyver

plot(test_ONE_OK(:,1),output_ONE,'r');

hold on

plot(test_TWO_OK(:,1),output_TWO,'b');

%http://www.mathworks.se/help/matlab/creating_plots/using-multiple-x-and-y-axes.html

