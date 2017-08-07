function [W_selected,tr_errors,val_errors,norm_w]=my_perceptron(tr_data,val_data,threshold,stop_cnd)
[N,M]=size(tr_data);
if(M==3)
    A=tr_data(tr_data(:,3)==1,:);
    B=tr_data(tr_data(:,3)==2,:);    
end
t_tr=tr_data(:,M);
t_val=val_data(:,M);
tr_data=[ones(N,1) tr_data(:,1:M-1)];
val_data=[ones(length(val_data),1) val_data(:,1:M-1)];


n=size(tr_data,2);
W=rand(1,n)-0.5;
W=W.';
Y_tr =((tr_data*W >0)+1);
Y_val=((val_data*W>0)+1); 

it=1;
tr_errors(it)=sum(abs(t_tr-Y_tr))/length(Y_tr);
val_errors(it)=sum(abs(t_val-Y_val))/length(Y_val);

Ws(it,:)=W;
norm_w(it)=norm(W);
while ((tr_errors(it)>threshold || stop_cnd) && (it<threshold || ~stop_cnd))
    it=it+1;
    for i=1:N
        w_new=W+(1/(norm(tr_data(i,:))))*(( (t_tr(i,:)-Y_tr(i,:)).')*tr_data(i,:)).';
        W=w_new;
        Ws(it,:)=W;
        norm_w(it)=norm(W);
        Y_tr=((tr_data*W>0)+1);
        Y_val=((val_data*W>0)+1); 
        tr_errors(it)=sum(abs(t_tr-Y_tr))/length(Y_tr);
        val_errors(it)=sum(abs(t_val-Y_val))/length(Y_val);           
    end
    
    if(M==3)
        step_a=2*max(B(:,1));
        a=(-step_a:step_a/10:step_a);
        fx=-(W(2)/W(3)*a) -(W(1)/W(3));
        plot(A(:,1),A(:,2),'*b');
        grid on;
        hold on
        plot(B(:,1),B(:,2),'*r');
        hold on 
        plot(a,fx,'');
        pause(0.1);
        title('Train');
        hold off;
    end


end


[~, index]=min(val_errors);
W_selected= Ws(index,:);

