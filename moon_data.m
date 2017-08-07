function data=moon_data(d,n,r,w)
% clear;
% clc;
% close all;
% n=1000;
% r=10;
% w=6;
% d=2;
data=zeros(n,3);
% random_thetas=rand(1,n)*pi;

random_thetas=(rand(1,n)*2*pi)-pi;

for i=1:n
    if(random_thetas(i)>0)
        rr=(w*rand(1))-w/2+r;
        x=rr.*cos(random_thetas(i));
        y=rr.*sin(random_thetas(i));
        class=1;
    else 
        rr=(w*rand(1))-w/2+r;
        x= (rr.*cos(random_thetas(i)))+r;
        y= (rr.*sin(random_thetas(i))) -d ;
        class=2;
    end
    data(i,:)=[x; y; class];
end
%     A=[x_a; y_a].';
% plot(A(:,1),A(:,2),'*');
% grid on
% hold on;



% random_thetas=-rand(1,n)*pi;
% 
% B=[x_b; y_b].';
% % plot(B(:,1),B(:,2),'*r');
% A=[A ones(length(A),1)];
% B=[B 2*ones(length(B),1)];

% data=[A; B];
data=datasample(data,length(data),'Replace',false);

% % axis 
% csvwrite('A_data.csv',A);
% csvwrite('B_data.csv',B);


