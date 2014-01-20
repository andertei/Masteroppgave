close all
clear all
format long


test_ONE_OK=load('12_400_d4_d8_Ok_new.lvm');

test_TWO_OK=load('15_400_d4_d8_OK.lvm');

[m,i]=max(test_ONE_OK(:,2));
[m,j]=max(test_TWO_OK(:,2));

test_TWO_OK(:,1)=test_TWO_OK(:,1)+(test_ONE_OK(i,1)-test_TWO_OK(j,1));

plot(test_ONE_OK(:,1),test_ONE_OK(:,2),'r');

hold on

plot(test_TWO_OK(:,1),test_TWO_OK(:,2),'b');

