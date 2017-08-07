function [W_selected,tr_errors,val_errors,norm_w]=my_adaline(tr_data,val_data,alfa,threshold,stop_cnd)

[N,M]=size(tr_data);

if(M==3)
    A=tr_data(tr_data(:,3)==1,:);
    B=tr_data(tr_data(:,3)==2,:);    
end
for i=1:M-1
   tr_data(:,i)=normc(tr_data(:,i));
   val_data(:,i)=normc(val_data(:,i));
end
t_tr=tr_data(:,M);
t_val=val_data(:,M);
tr_data=[ones(N,1) tr_data(:,1:M-1)];
val_data=[ones(length(val_data),1) val_data(:,1:M-1)];


n=size(tr_data,2);
W=rand(1,n)-0.5;
W=W.';
Y_tr =tr_data*W ;
Y_val=val_data*W;

it=1;
norm_w(it)=norm(W);

tr_errors(it)=sum(abs(t_tr-Y_tr))/length(Y_tr);
val_errors(it)=sum(abs(t_val-Y_val))/length(Y_val);

Ws(it,:)=W;

while ((tr_errors(it)>threshold || stop_cnd) && (it<threshold || ~stop_cnd))
    it=it+1;
    if(it>100) 
        alfa=0.0001;
    end;
    
    for i=1:N
        w_new=W+(2*alfa)*(( (t_tr(i)-Y_tr(i)).')*tr_data(i,:)).';
        if(isnan(tr_data*w_new))
            a=1;
        end
        W=w_new;
        norm_w(it)=norm(W);

        Ws(it,:)=W;
        Y_tr=tr_data*W;
        Y_val=val_data*W;
    end
    tr_errors(it)=sum(abs(t_tr-Y_tr).^2)/length(Y_tr);
    val_errors(it)=sum(abs(t_val-Y_val).^2)/length(Y_val); 
    if(M==3)
        step_a=max(B(:,1));
        a=(-step_a:step_a/10:step_a);
        fx=-(W(2)/W(3)*a) -(W(1)/W(3));
        plot(A(:,1),A(:,2),'*b');
        grid on;
        hold on
        plot(B(:,1),B(:,2),'*r');
        hold on 
        plot(a,fx,'--g');
        pause(0.05);
        title('Train');
        hold off;
    end


end


[~, index]=min(val_errors);
W_selected= Ws(index,:);


