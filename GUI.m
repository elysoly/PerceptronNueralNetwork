function varargout = GUI(varargin)
% GUI MATLAB code for GUI.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI

% Last Modified by GUIDE v2.5 06-Mar-2017 22:17:19

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before GUI is made visible.
function GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI (see VARARGIN)

% Choose default command line output for GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function param_d_Callback(hObject, eventdata, handles)
% hObject    handle to param_d (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of param_d as text
%        str2double(get(hObject,'String')) returns contents of param_d as a double


% --- Executes during object creation, after setting all properties.
function param_d_CreateFcn(hObject, eventdata, handles)
% hObject    handle to param_d (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end






% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over plot_btn.
function plot_btn_ButtonDownFcn(hObject, eventdata, handles)

% hObject    handle to plot_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in btn_perceptron.
function btn_perceptron_Callback(hObject, eventdata, handles)
fprintf('Perceptron\n');
tr_obj=findobj('Tag','train_percentage');
ts_obj=findobj('Tag','test_percentage');
val_obj=findobj('Tag','validation_percentage');


%%%Test
obj_dataset=findobj('Tag','btn_dataset1');
threshold=str2num(get(handles.threshold,'String'));
stop_condition=handles.btn_iteration.Value;

if(obj_dataset.Value)

    tr_data=tr_obj.UserData;
    val_data=val_obj.UserData;
    ts_data=ts_obj.UserData;
    
    axes(handles.axes_train);
    
    [W,tr_errors,val_errors,norm_w]=my_perceptron(tr_data,val_data,threshold,stop_condition);
    handles.label_weights.UserData=W;
    label='';
    for i=1:length(W)
        tmp=strcat('W',num2str(i),': ',num2str(W(i)) ,'|_|');
        label=strcat(label,tmp);
    end
    handles.label_weights.String=label;
    
    axes(handles.axes_weights);
    plot((1:length(norm_w)),norm_w);
    xlabel('epoc');
    ylabel('|W|');
    title('Weights');
    
    axes(handles.axes_test);
    A=ts_data(ts_data(:,3)==1,:);
    B=ts_data(ts_data(:,3)==2,:);

    step_a=max(B(:,1));
    a=(-step_a:step_a/10:step_a);
    fx=-(W(2)/W(3)*a) -(W(1)/W(3));

    plot(handles.axes_test,A(:,1),A(:,2),'*b');
    hold on
    plot(handles.axes_test,B(:,1),B(:,2),'*r'); 
    hold on
    line(a, fx, 'Parent', handles.axes_test)
    title('Test')
    legend('A','B','D.B.');
    grid on;
    xlabel('x');
    ylabel('y');
    hold off;
    
    axes(handles.axes_err);
    plot((1:length(tr_errors)),tr_errors,'-r');
    hold on
    plot((1:length(val_errors)),val_errors,'-g');
    hold off;
    legend('Train','Validation');
    ylabel('Error');
    xlabel('epoc');
    
    
    XX=[ones(length(ts_data),1) ts_data(:,1:2)];
    y_test=((XX*(W.')>0)+1);
    test_error=sum(abs(y_test-ts_data(:,3)))/length(ts_data);
    handles.label_test_error.String=num2str(test_error);

else    

    tr_data=tr_obj.UserData;
    val_data=val_obj.UserData;
    ts_data=ts_obj.UserData;  

    XX=[ones(length(ts_data),1) ts_data(:,1:size(ts_data,2)-1)];
    t_tr=tr_data(:,size(tr_data,2));
    t_val=val_data(:,size(val_data,2));   
    t_ts=ts_data(:,size(ts_data,2));
    
   %class==1 as a positive class
    tt_tr=(t_tr==1)+1;
    tt_val=(t_val==1)+1;
    [W1,tr_errors,val_errors,norm_w1]=my_perceptron([tr_data(:,1:size(tr_data,2)-1), tt_tr ],[val_data(:,1:size(val_data,2)-1), tt_val ],threshold,stop_condition);
    axes(handles.axes_train);
    plot((1:length(tr_errors)),tr_errors,'-r');
    hold on
    plot((1:length(val_errors)),val_errors,'-g');
    hold off;
    handles.axes_train.Title.String='Class 1 as +';
    legend('Train','Validation');
    ylabel('Error');
    xlabel('epoc');
    
    axes(handles.axes_weights);
    hold on;
    plot((1:length(norm_w1)),norm_w1,'-g');
    xlabel('epoc');
    ylabel('|W|');
    title('Weights');
    
    
   %class==2 as a positive class
   clear tt_tr;
   clear tt_val;
   tt_tr=(t_tr==2)+1;
   tt_val=(t_val==2)+1; 
   [W2,tr_errors2,val_errors2,norm_w2]=my_perceptron([tr_data(:,1:size(tr_data,2)-1), tt_tr ],[val_data(:,1:size(val_data,2)-1), tt_val ],threshold,stop_condition);   
   axes(handles.axes_test);
   plot((1:length(tr_errors2)),tr_errors2,'-r');
   hold on
   plot((1:length(val_errors2)),val_errors2,'-g');
   hold off;
   legend('Train','Validation');
   ylabel('Error');
   xlabel('epoc');
   handles.axes_test.Title.String='Class 2 as +';

   
    axes(handles.axes_weights);
    hold on ;
    plot((1:length(norm_w2)),norm_w2,'-r');
    
   %class==3 as a positive class
   clear tt_tr;
   clear tt_val;
   tt_tr=(t_tr==3)+1;
   tt_val=(t_val==3)+1; 
   [W3,tr_errors3,val_errors3,norm_w3]=my_perceptron([tr_data(:,1:size(tr_data,2)-1), tt_tr ],[val_data(:,1:size(val_data,2)-1), tt_val ],threshold,stop_condition);  
   axes(handles.axes_err);
   plot((1:length(tr_errors3)),tr_errors3,'-r');
   hold on
   plot((1:length(val_errors3)),val_errors3,'-g');
   hold off;
   legend('Train','Validation');
   ylabel('Error');
   xlabel('epoc');
    handles.axes_err.Title.String='Class 3 as +';


    axes(handles.axes_weights);
    hold on;
    plot((1:length(norm_w3)),norm_w3,'-b');
    hold off;
    legend('|W1|','|W2|','|W3|');

   
   
    y1=((XX*W1.'>0)+1);
    y2=((XX*W2.'>0)+1);
    y3=((XX*W3.'>0)+1);  
    [~, my_y]= max([y1,y2,y3],[],2);
    test_error=sum(abs(my_y-t_ts))/length(ts_data);
    handles.label_test_error.String=num2str(test_error);
    label='';
    for i=1:length(W1)
        tmp=strcat('W',num2str(i),': ',num2str(W1(i)) ,'|_|');
        label=strcat(label,tmp);
    end
    
    handles.label_weights.String=label;  
    label2='';
    for i=1:length(W2)
        tmp=strcat('W',num2str(i),': ',num2str(W2(i)) ,'|_|');
        label2=strcat(label,tmp);
    end
    
    handles.label_w2.String=label2;
    label3='';
    for i=1:length(W3)
        tmp=strcat('W',num2str(i),': ',num2str(W3(i)) ,'|_|');
        label3=strcat(label3,tmp);
    end
    handles.label_w3.String=label3; 
    handles.label_weights.UserData=[W1;W2;W3];
end





% --- Executes on button press in btn_start.
function btn_start_Callback(hObject, eventdata, handles)

cla(handles.axes_train,'reset');
cla(handles.axes_test,'reset');
cla(handles.axes_err,'reset');
cla(handles.axes_weights,'reset');


handles.figure1.HandleVisibility='off';
close all;
handles.figure1.HandleVisibility='on';
handles.label_test_error.String='unknown';
handles.label_weights.String='unknown';

handles.label_w2.String='';

handles.label_w3.String='';
clear;
clc;

% -------------------------------------------------------------


% --- Executes on button press in btn_adaline.
function btn_adaline_Callback(hObject, eventdata, handles)
fprintf('Perceptron\n');
tr_obj=findobj('Tag','train_percentage');
ts_obj=findobj('Tag','test_percentage');
val_obj=findobj('Tag','validation_percentage');


%%%Test
obj_dataset=findobj('Tag','btn_dataset1');
threshold=str2num(get(handles.threshold,'String'));
stop_condition=handles.btn_iteration.Value;
alfa=str2num(handles.param_alfa.String);
if(obj_dataset.Value)

    tr_data=tr_obj.UserData;
    val_data=val_obj.UserData;
    ts_data=ts_obj.UserData;
    axes(handles.axes_train);

%     [W,tr_errors,val_errors]=my_perceptron(tr_data,val_data,threshold,stop_condition);
    [W,tr_errors,val_errors]=my_adaline(tr_data,val_data,alfa,threshold,stop_condition);

    handles.label_weights.UserData=W;
    label='';
    for i=1:length(W)
        tmp=strcat('W',num2str(i),': ',num2str(W(i)) ,'|_|');
        label=strcat(label,tmp);
    end
    handles.label_weights.String=label;

    
    axes(handles.axes_test);
    A=ts_data(ts_data(:,3)==1,:);
    B=ts_data(ts_data(:,3)==2,:);
    
    step_a=max(B(:,1));
    a=(-step_a:step_a/10:step_a);
    fx=-(W(2)/W(3)*a) -(W(1)/W(3));

    plot(handles.axes_test,A(:,1),A(:,2),'*b');
    hold on
    plot(handles.axes_test,B(:,1),B(:,2),'*r'); 
    hold on
    line(a, fx, 'Parent', handles.axes_test)
    title('Test')
    legend('A','B','D.B.');
    grid on
    xlabel('x');
    ylabel('y');
    hold off;
    
    axes(handles.axes_err);
    plot((1:length(tr_errors)),tr_errors,'-r');
    hold on
    plot((1:length(val_errors)),val_errors,'-g');
    hold off;
    legend('Train','Validation');
    ylabel('Error');
    xlabel('epoc');
    
    
    XX=[ones(length(ts_data),1) ts_data(:,1:2)];
    y_test=((XX*(W.')>0)+1);
    test_error=sum(abs(y_test-ts_data(:,3)))/length(ts_data);
    handles.label_test_error.String=num2str(test_error);

else    

    tr_data=tr_obj.UserData;
    val_data=val_obj.UserData;
    ts_data=ts_obj.UserData;  

    XX=[ones(length(ts_data),1) ts_data(:,1:size(ts_data,2)-1)];
    t_tr=tr_data(:,size(tr_data,2));
    t_val=val_data(:,size(val_data,2));   
    t_ts=ts_data(:,size(ts_data,2));
    
   %class==1 as a positive class
    
    tt_val=(t_val==1)+1;
    tt_tr=(t_tr==1)+1;

    [W1,tr_errors,val_errors,norm_w1]=my_adaline([tr_data(:,1:size(tr_data,2)-1), tt_tr ],[val_data(:,1:size(val_data,2)-1), tt_val ],alfa,threshold,stop_condition);
    
   axes(handles.axes_weights);
    plot((1:length(norm_w1)),norm_w1);
    xlabel('epoc');
    ylabel('|W|');
    title('Weights');
    hold on;
    axes(handles.axes_train);
    plot((1:length(tr_errors)),tr_errors,'-r');
    hold on
    plot((1:length(val_errors)),val_errors,'-g');
    hold off;
    handles.axes_train.Title.String='Class 1 as +';
    legend('Train','Validation');
    ylabel('Error');
    xlabel('epoc');
    
   %class==2 as a positive class
   clear tt_tr;
   clear tt_val;
   tt_tr=(t_tr==2)+1;
   tt_val=(t_val==2)+1; 
   [W2,tr_errors2,val_errors2,norm_w2]=my_adaline([tr_data(:,1:size(tr_data,2)-1), tt_tr ],[val_data(:,1:size(val_data,2)-1), tt_val ],alfa,threshold,stop_condition);   
   
   axes(handles.axes_weights);
    plot((1:length(norm_w2)),norm_w2);
   
    
   axes(handles.axes_test);
   plot((1:length(tr_errors2)),tr_errors2,'-r');
   hold on
   plot((1:length(val_errors2)),val_errors2,'-g');
   hold off;
   legend('Train','Validation');
   ylabel('Error');
   xlabel('epoc');
   handles.axes_test.Title.String='Class 2 as +';

    
   %class==3 as a positive class
   clear tt_tr;
   clear tt_val;
   tt_tr=(t_tr==3)+1;
   tt_val=(t_val==3)+1; 
   [W3,tr_errors3,val_errors3,norm_w3]=my_adaline([tr_data(:,1:size(tr_data,2)-1), tt_tr ],[val_data(:,1:size(val_data,2)-1), tt_val ],alfa,threshold,stop_condition);  
   
   axes(handles.axes_weights);

    plot((1:length(norm_w3)),norm_w3);
    hold off;
    legend('|W1|','|W2|','|W3|'); 
    
   axes(handles.axes_err);
   plot((1:length(tr_errors3)),tr_errors3,'-r');
   hold on
   plot((1:length(val_errors3)),val_errors3,'-g');
   hold off;
   legend('Train','Validation');
   ylabel('Error');
   xlabel('epoc');
   handles.axes_err.Title.String='Class 3 as +';

    
   
    y1=((XX*W1.'>0)+1);
    y2=((XX*W2.'>0)+1);
    y3=((XX*W3.'>0)+1);  
    [~, my_y]= max([y1,y2,y3],[],2);
    test_error=0;
    for i=1:length(t_ts)
        if(t_ts(i)~=my_y(i))
            test_error=test_error+1;
        end
    end
    test_error=test_error/length(t_ts);
%     test_error=sum(abs(my_y-t_ts))/length(ts_data);
    handles.label_test_error.String=num2str(test_error);
    label='';
    for i=1:length(W1)
        tmp=strcat('W',num2str(i),': ',num2str(W1(i)) ,'|_|');
        label=strcat(label,tmp);
    end
    
    handles.label_weights.String=label;  
    label2='';
    for i=1:length(W2)
        tmp=strcat('W',num2str(i),': ',num2str(W2(i)) ,'|_|');
        label2=strcat(label,tmp);
    end
    
    handles.label_w2.String=label2;
    label3='';
    for i=1:length(W3)
        tmp=strcat('W',num2str(i),': ',num2str(W3(i)) ,'|_|');
        label3=strcat(label3,tmp);
    end
    handles.label_w3.String=label3; 
    handles.label_weights.UserData=[W1;W2;W3];
end




function train_percentage_Callback(hObject, eventdata, handles)
% hObject    handle to train_percentage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of train_percentage as text
%        str2double(get(hObject,'String')) returns contents of train_percentage as a double


% --- Executes during object creation, after setting all properties.
function train_percentage_CreateFcn(hObject, eventdata, handles)
% hObject    handle to train_percentage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function validation_percentage_Callback(hObject, eventdata, handles)
% hObject    handle to validation_percentage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of validation_percentage as text
%        str2double(get(hObject,'String')) returns contents of validation_percentage as a double


% --- Executes during object creation, after setting all properties.
function validation_percentage_CreateFcn(hObject, eventdata, handles)
% hObject    handle to validation_percentage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function test_percentage_Callback(hObject, eventdata, handles)
% hObject    handle to test_percentage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of test_percentage as text
%        str2double(get(hObject,'String')) returns contents of test_percentage as a double


% --- Executes during object creation, after setting all properties.
function test_percentage_CreateFcn(hObject, eventdata, handles)
% hObject    handle to test_percentage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btn_load_data.
function btn_load_data_Callback(hObject, eventdata, handles)
obj_dataset=findobj('Tag','btn_dataset1');
if(obj_dataset.Value)
    axes(handles.axes_train);
    d=str2num(get(handles.param_d,'String'));
    n=str2num(get(handles.param_n,'String'));
    r=str2num(get(handles.param_r,'String'));
    w=str2num(get(handles.param_w,'String'));

    data=moon_data(d,n,r,w);
%     data=[normc(data(:,1:2)) , data(:,3)];
    hObject.UserData =data;
    % hold(handles.axes_train,'on');
    A=data(data(:,3)==1,:);
    B=data(data(:,3)==2,:);
    plot(A(:,1),A(:,2),'*b');
    hold on
    plot(B(:,1),B(:,2),'*r');
    title('Train');
    xlabel('x');
    ylabel('y');
    legend('A','B');
    grid on;
    hold off;
else 
    fileID = fopen('DataSet2.txt');
    size_d=[5 inf];
    data2= fscanf(fileID,'%f,%f,%f,%f,%d',size_d);
    data2=data2.';

    data2=datasample(data2,length(data2),'Replace',false);
    fclose(fileID);
    hObject.UserData =data2;
    
end

Data=hObject.UserData;

tr_obj=findobj('Tag','train_percentage');
tr_pr=str2num(tr_obj.String)/100;


ts_obj=findobj('Tag','test_percentage');
ts_pr=str2num(ts_obj.String)/100;

val_obj=findobj('Tag','validation_percentage');
val_pr=str2num(val_obj.String)/100;

%%%Test
obj_dataset=findobj('Tag','btn_dataset1');
if(obj_dataset.Value)
    d=str2num(get(handles.param_d,'String'));
    n=str2num(get(handles.param_n,'String'));
    r=str2num(get(handles.param_r,'String'));
    w=str2num(get(handles.param_w,'String'));
    tmp_data=moon_data(d,n,r,w);
%     tmp_data=[normc(tmp_data(:,1:2)) , tmp_data(:,3)];
    ts_obj.UserData=tmp_data;
    tr_obj.UserData=Data(1:round(tr_pr*length(Data)),: );
    val_obj.UserData=Data(length(tr_obj.UserData)+1:length(Data) ,: );
else
    tr_obj.UserData=Data(1:round(tr_pr*length(Data)),: );
    tr_data=tr_obj.UserData;
    val_obj.UserData=Data(length(tr_data)+1:length(tr_data)+ round(val_pr*length(Data)) ,: );
    val_data=val_obj.UserData;
    ts_obj.UserData=Data(length(val_data)+length(tr_data)+1:length(Data),: ); 
    val_data=val_obj.UserData;

end

% --- Executes on button press in btn_load_weights.
function btn_load_weights_Callback(hObject, eventdata, handles)
% hObject    handle to btn_load_weights (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.label_weights.UserData=csvread('weights.dat');
W=handles.label_weights.UserData;
label=' ';
for i=1:size(W,2)
    tmp=strcat('W',num2str(i),': ',num2str(W(1,i)) ,'|_|');
    label=strcat(label,tmp);
end
handles.label_weights.String=label;

if(size(W,1)>1)
    label=' ';
    for i=1:size(W,2)
        tmp=strcat('W',num2str(i),': ',num2str(W(2,i)) ,'|_|');
        label=strcat(label,tmp);
    end
    handles.label_w2.String=label;

    label=' ';
    for i=1:size(W,2)
        tmp=strcat('W',num2str(i),': ',num2str(W(3,i)) ,'|_|');
        label=strcat(label,tmp);
    end
    handles.label_w3.String=label;

    
end

% --- Executes on button press in btn_save_weights.
function btn_save_weights_Callback(hObject, eventdata, handles)
csvwrite('weights.dat',handles.label_weights.UserData);

% hObject    handle to btn_save_weights (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in btn_and.
function btn_and_Callback(hObject, eventdata, handles)
axes(handles.axes_train);
tr_data=[0,0,0; 0,1,0; 1,0,0; 1,1,1;];
tr_data(:,3)=tr_data(:,3)+1;
threshold=str2num(get(handles.threshold,'String'));
stop_condition=handles.btn_iteration.Value;

[w_and,tr_errors,val_errors]=my_perceptron(tr_data,tr_data,threshold,stop_condition);% hObject    handle to btn_and (see GCBO)
handles.label_weights.String=strcat('W1:' ,num2str(w_and(1)),' |_| W2: ',num2str(w_and(2)),' |_| W3: ',num2str(w_and(3))) ;
handles.label_weights.UserData=w_and;
handles.axes_train.Title.String='AND';
axis([-1.5 2 -1.5 1.5]);

% --- Executes on button press in btn_iteration.
function btn_iteration_Callback(hObject, eventdata, handles)

% Hint: get(hObject,'Value') returns toggle state of btn_iteration


% --- Executes on button press in radiobutton8.
function radiobutton8_Callback(hObject, eventdata, handles)


function threshold_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function threshold_CreateFcn(hObject, eventdata, handles)
% % hObject    handle to threshold (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    empty - handles not created until after all CreateFcns called
% 
% % Hint: edit controls usually have a white background on Windows.
% %       See ISPC and COMPUTER.
% if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
%     set(hObject,'BackgroundColor','white');
% end



function param_n_Callback(hObject, eventdata, handles)

% Hints: get(hObject,'String') returns contents of param_n as text
%        str2double(get(hObject,'String')) returns contents of param_n as a double


% --- Executes during object creation, after setting all properties.
function param_n_CreateFcn(hObject, eventdata, handles)
% hObject    handle to param_n (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function param_r_Callback(hObject, eventdata, handles)

% Hints: get(hObject,'String') returns contents of param_r as text
%        str2double(get(hObject,'String')) returns contents of param_r as a double


% --- Executes during object creation, after setting all properties.
function param_r_CreateFcn(hObject, eventdata, handles)
% hObject    handle to param_r (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function param_w_Callback(hObject, eventdata, handles)
% hObject    handle to param_w (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of param_w as text
%        str2double(get(hObject,'String')) returns contents of param_w as a double


% --- Executes during object creation, after setting all properties.
function param_w_CreateFcn(hObject, eventdata, handles)
% hObject    handle to param_w (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btn_or.
function btn_or_Callback(hObject, eventdata, handles)
axes(handles.axes_test);
tr_data=[0,0,0; 0,1,1; 1,0,1; 1,1,1;];
tr_data(:,3)=tr_data(:,3)+1;
threshold=str2num(get(handles.threshold,'String'));
stop_condition=handles.btn_iteration.Value;

[w_and,tr_errors,val_errors]=my_perceptron(tr_data,tr_data,threshold,stop_condition);% hObject    handle to btn_and (see GCBO)
handles.label_weights.String=strcat('W1:' ,num2str(w_and(1)),' |_| W2: ',num2str(w_and(2)),' |_| W3: ',num2str(w_and(3))) ;
handles.label_weights.UserData=w_and;
handles.axes_test.Title.String='OR';
axis([-0.5 1.5 -0.5 1.5]);
% y_ts=(([ones(length(ts_data),1) ts_data(:,1:size(ts_data,2)-1)]*W.')>0) +1;


% --- Executes on button press in ld_weights.
function ld_weights_Callback(hObject, eventdata, handles)
W=handles.label_weights.UserData;
% Data=handles.btn_load_data.UserData;
% 
% tr_obj=findobj('Tag','train_percentage');
% tr_pr=str2num(tr_obj.String)/100;
% 
% 
ts_obj=findobj('Tag','test_percentage');
% ts_pr=str2num(ts_obj.String)/100;
% 
% val_obj=findobj('Tag','validation_percentage');
% val_pr=str2num(val_obj.String)/100;
% 
% 
% tr_obj.UserData=Data(1:round(tr_pr*length(Data)),: );
% tr_data=tr_obj.UserData;
% val_obj.UserData=Data(length(tr_data)+1:length(tr_data)+ round(val_pr*length(Data)) ,: );
% val_data=val_obj.UserData;
% ts_obj.UserData=Data(length(val_data)+length(tr_data)+1:length(Data),: );    
ts_data=ts_obj.UserData;
if (size(W,1)>1)
    XX=[ones(length(ts_data),1) ts_data(:,1:size(ts_data,2)-1)];
    y1=((XX*W(1,:).'>0)+1);
    y2=((XX*W(2,:).'>0)+1);
    y3=((XX*W(3,:).'>0)+1); 
    [~,y]= max([y1,y2,y3],[],2);
    er_tmp=(ts_data(:,size(ts_data,2))~=y);
    ts_error=sum(er_tmp)/length(er_tmp);

else
    y=(([ones(length(ts_data),1) ts_data(:,1:size(ts_data,2)-1)]*W.')>0) +1;
    ts_error=sum(abs(y-ts_data(:,size(ts_data,2))))/length(ts_data);

end
handles.label_test_error.String=num2str(ts_error);



function param_alfa_Callback(hObject, eventdata, handles)
% hObject    handle to param_alfa (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of param_alfa as text
%        str2double(get(hObject,'String')) returns contents of param_alfa as a double


% --- Executes during object creation, after setting all properties.
function param_alfa_CreateFcn(hObject, eventdata, handles)
% hObject    handle to param_alfa (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
