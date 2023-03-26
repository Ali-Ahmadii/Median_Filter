close all
clear all

x=128*ones(1,1e4)+64;
t=1:1e4;
x(mod(t,1000)>100) = 64;

x=x+10*randn(1,1e4);
plot(x)

data = dec2bin(round(x),8);
dlmwrite('test.txt',data,'');