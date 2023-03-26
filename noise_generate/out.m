%Read mode
sss=textread('output_data.txt','%8c');
eee=fi(0,0,8,0);
eee.bin=sss(1:1e4,:);
hold on
plot(double(eee),'r')
