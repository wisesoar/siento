function varargout = FeatClassification(varargin)
% FEATCLASSIFICATION M-file for FeatClassification.fig
%      FEATCLASSIFICATION, by itself, creates a new FEATCLASSIFICATION or raises the existing
%      singleton*.
%
%      H = FEATCLASSIFICATION returns the handle to a new FEATCLASSIFICATION or the handle to
%      the existing singleton*.
%
%      FEATCLASSIFICATION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FEATCLASSIFICATION.M with the given input arguments.
%
%      FEATCLASSIFICATION('Property','Value',...) creates a new FEATCLASSIFICATION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before FeatClassification_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to FeatClassification_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help FeatClassification

% Last Modified by GUIDE v2.5 01-Mar-2010 16:59:43

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @FeatClassification_OpeningFcn, ...
                   'gui_OutputFcn',  @FeatClassification_OutputFcn, ...
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


% --- Executes just before FeatClassification is made visible.
function FeatClassification_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to FeatClassification (see VARARGIN)

prwarning off;
% prwaitbar off;

%  S = load ('Full.mat');
%  handles.current_data = S;
% handles.dataset = evalin('base','featmat');
% handles.labels = evalin('base','labels');
% handles.labelnames = evalin('base','labelnames');
% handles.dataset = colcheck(handles.dataset);
% handles.dataset = dataset(handles.dataset,handles.labels);
% handles.dataset = remclass(handles.dataset,3);
% handles.dataset = seldat(handles.dataset);
% handles.dataset = seldat(handles.dataset,[ 3 6 7 8]);
%handles.mapped_data = [];
% handles.mapped_data = handles.dataset;
handles.dataset = [];
handles.labels = [];
handles.labelnames = [];
handles.classifier = '';
handles.featsel = '';
set(handles.FeatSelc,'Enable', 'off')
set(handles.Classifier,'Enable', 'off')
set(handles.FeatSelecBtn,'Enable', 'off')
set(handles.ClassBTN,'Enable', 'off')
set(handles.Reset,'Enable', 'off')
set(handles.ClassPlot,'Enable', 'off')
set(handles.FSPlot,'Enable', 'off')

 % Choose default command line output for FeatClassification
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes FeatClassification wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = FeatClassification_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in FeatSelc.
function FeatSelc_Callback(hObject, eventdata, handles)
% hObject    handle to FeatSelc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns FeatSelc contents as cell array
%        contents{get(hObject,'Value')} returns selected item from FeatSelc

str = get(hObject, 'String');
%   display(str);
val = get(hObject,'Value');
%   display(val);
% Select a feature selection method

switch str{val};

    case 'PCA'
        handles.featsel = 'PCA';
    case 'Fisher Projection'
        handles.featsel = 'Fisher Projection';
    case 'Non Linear Fisher Projection'
        handles.featsel = 'Non Linear Fisher Projection';
    case 'Forward feature selection'
        handles.featsel = 'Forward feature selection';
    case 'Backward feature selection'
        handles.featsel = 'Backward feature selection';
    case 'floating forward feature selection'
        handles.featsel = 'floating forward feature selection';
    otherwise
        handles.featsel = '';
end

% Save the handles structure.
guidata(hObject,handles)


% --- Executes during object creation, after setting all properties.
function FeatSelc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FeatSelc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in Classifier.
function Classifier_Callback(hObject, eventdata, handles)
% hObject    handle to Classifier (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns Classifier contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Classifier

str = get(hObject, 'String');
val = get(hObject,'Value');
% Select Classifier from the popup menu.
switch str{val};
case 'LDA' 
   handles.classifier = 'LDA';
case 'SVM' 
   handles.classifier = 'SVM';
case 'K Nearest Neighbor' 
   handles.classifier = 'K Nearest Neighbor';
case 'Naive Bayes' 
   handles.classifier = 'Naive Bayes';
otherwise 
   handles.classifier = '';
end
% Save the handles structure.
guidata(hObject,handles)



% --- Executes during object creation, after setting all properties.
function Classifier_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Classifier (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in ClassBTN.
function ClassBTN_Callback(hObject, eventdata, handles)
% hObject    handle to ClassBTN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~strcmp(handles.classifier,'') 
    set(handles.ResultsEB,'String', '');
if strcmp(handles.featsel,'')
    [result,NLAB_OUT] = run_classifier(handles.dataset, handles.classifier);
    [Performance_Measures, Performance_Measures1,ConfusionMatrix]...
           = confm (NLAB_OUT,handles.dataset);
else
    [result,NLAB_OUT] = run_classifier(handles.mapped_data, handles.classifier);
    [Performance_Measures, Performance_Measures1,ConfusionMatrix] = confm (NLAB_OUT,handles.dataset);
end
result = num2str(1-result);
result =strcat(handles.classifier,' Accuracy =  ', result);  
set(handles.ClassPlot,'Enable', 'on')
else
result =strcat('Error Rate =  No method has been selected');  
end

% set(handles.Class_Results,'String', result);
% set(handles.ResultsEB,'String', result);

% set(handles.ResultsEB,'String', {['Results... ' handles.classifier];...
%     '  '; Performance_Measures{:}});
% oldstring = get(handles.ResultsEB,'string');
% set(handles.ResultsEB,'String', {oldstring{:},Performance_Measures1{:}});

oldstring = handles.DataSetInfo;

set(handles.ResultsEB,'String', {oldstring{:},'' ,...
    sprintf('Results.....%s ', handles.classifier),...
    ' ',Performance_Measures{:}});
oldstring = get(handles.ResultsEB,'string');
set(handles.ResultsEB,'String', {oldstring{:},Performance_Measures1{:}});

oldstring = get(handles.ResultsEB,'string');
set(handles.ResultsEB,'String', {oldstring{:},ConfusionMatrix{:}});

guidata(hObject, handles);

% --- Executes on button press in ClassPlot.
function ClassPlot_Callback(hObject, eventdata, handles)
% hObject    handle to ClassPlot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% figure;
axes( handles.ClassifierFeatureAxes);
if ~strcmp(handles.classifier,'')
if strcmp(handles.featsel,'') 
    plot_classifier(handles.dataset, handles.classifier);
else  
    plot_classifier(handles.mapped_data, handles.classifier);
end
end

% --- Executes on button press in FeatSelecBtn.
function FeatSelecBtn_Callback(hObject, eventdata, handles)
% hObject    handle to FeatSelecBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if ~strcmp(handles.featsel,'')
   % handles.mapped_data = run_featselect(handles.dataset,handles.featsel);
    set(handles.ResultsEB,'String', '');
    handles.mapped_data = run_featselect(handles.mapped_data,handles.featsel);
    result =strcat('Result = ',handles.featsel,'......Ok');  
    set(handles.FSPlot,'Enable', 'on')
else
    result =strcat('Result = No method has been selected');  
end

% set(handles.Featsel_Result,'String', result)
set(handles.ResultsEB,'String', result)
guidata(hObject, handles);

% --- Executes on button press in FSPlot.
function FSPlot_Callback(hObject, eventdata, handles)
% hObject    handle to FSPlot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes( handles.ClassifierFeatureAxes);
if ~strcmp(handles.featsel,'')    
plot_featselect(handles.mapped_data);
end

% --- Executes on button press in ClassFinish.
function ClassFinish_Callback(hObject, eventdata, handles)
% hObject    handle to ClassFinish (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close all;


% --- Executes on button press in Reset.
function Reset_Callback(hObject, eventdata, handles)
% hObject    handle to Reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.mapped_data = handles.dataset;
handles.featsel = '';
handles.classifier = '';
result =strcat('Error rate = ...  ');  
% set(handles.Class_Results,'String', result)

result =strcat('Result = ...  ');  
% set(handles.Featsel_Result,'String', result)


set(handles.ClassPlot,'Enable', 'off')
set(handles.FSPlot,'Enable', 'off')

guidata(hObject, handles);



% --- Executes on button press in OpenDataSet.
function OpenDataSet_Callback(hObject, eventdata, handles)
% hObject    handle to OpenDataSet (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, pathname] = uigetfile( {'*.mat', 'All MAT-Files (*.mat)'; '*.*','All Files (*.*)'});
% If "Cancel" is selected then return
 set(handles.ResultsEB,'string','DataSet Info....');
if isequal([filename,pathname],[0,0])
	return
% Otherwise construct the fullfilename and Check and load the file
else
    File = fullfile(pathname,filename);
    set(handles.GetDataSet,'string',File);
    Data_Set1= uiimport(File);
%     Data_Set1= load(File);
    if (~isempty(Data_Set1))
    vars = fieldnames(Data_Set1);
    for i = 1:length(vars)
       Data_Set= Data_Set1.(vars{i});
    end
    if (isnumeric(Data_Set))
    assignin('base', 'Data_Set', Data_Set);
    else
        errordlg('Please Load DataSet Again','DataSet Format Error');
       % display('Please Load DataSet Again');
    end
    [n m] = size(Data_Set);
    handles.DatasizeRow = n;
    handles.DatasizeCol = m;
    end
    guidata(hObject, handles)
end

% --- Executes on button press in OpenLabels.
function OpenLabels_Callback(hObject, eventdata, handles)
% hObject    handle to OpenLabels (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, pathname] = uigetfile( {'*.mat', 'All MAT-Files (*.mat)'; '*.*','All Files (*.*)'});
% If "Cancel" is selected then return
if isequal([filename,pathname],[0,0])
	return
% Otherwise construct the fullfilename and Check and load the file
else
	File = fullfile(pathname,filename);
    set(handles.GetLabels,'string',File);
    Labels1=uiimport(File);
%   Labels1= load (File);
    if (~isempty(Labels1))
    vars = fieldnames(Labels1);
    for i = 1:length(vars)
        Labels = Labels1.(vars{i});
    end   
    [n m] = size(Labels);
    if ( isvector(Labels) && n == handles.DatasizeRow ) 
        assignin('base', 'Labels', Labels);
        
                   
         DataSetInfo = ['DataSet Size...  ' int2str(handles.DatasizeRow)...
           ' X ' int2str(handles.DatasizeCol)];
         DataSetInfo = strvcat(get(handles.ResultsEB,'string'), DataSetInfo, ' ');
         set(handles.ResultsEB,'string',DataSetInfo);
         
         Labels1 = '';
         if isnumeric(Labels)
             for i=1:length(Labels)
                 Labels1{i} = num2str(Labels(i));
             end
         Labels = Labels1';    
         end
         
         
         ClassFreq = tabulate(Labels);

        [n m] = size(ClassFreq);
        cellinfo = 'ClassName           Count           Parecent ';
        cellinfo =[cellinfo;'============================================='];
        for i=1:n
            classname =ClassFreq{i,1};
            classname = sscanf(classname, '%c',11);
           
            rowinfo = [sprintf('%s \t',classname)...
                       sprintf('%s \t',num2str(ClassFreq{i,2},'%d')),...
                       sprintf( '%s',num2str(ClassFreq{i,3},'%6.3f %%'))];

            cellinfo = strvcat(cellinfo,rowinfo);
        end
      

        cellinfo = {get(handles.ResultsEB,'string');cellinfo};
        handles.DataSetInfo = cellinfo;
        set(handles.ResultsEB,'string',cellinfo);    
        
        handles.dataset = evalin('base','Data_Set');
        handles.labels = evalin('base','Labels');
        handles.labelnames = [];
        handles.dataset = colcheck(handles.dataset);
               
        axes(handles.ClassifierFeatureAxes);
        [coefs,scores] = princomp(handles.dataset);
        gscatter(scores(:,1),scores(:,2),handles.labels)
                 
        handles.dataset = dataset(handles.dataset,handles.labels);
        handles.dataset = remclass(handles.dataset,3);  
        handles.dataset = seldat(handles.dataset); % remove unlabled objects
        % handles.dataset = seldat(handles.dataset,[ 3 6 7 8]);
        handles.mapped_data = handles.dataset;%%%% strange behavior check
%          scatterd(handles.dataset,'legend');
        
        set(handles.FeatSelc,'Enable', 'on')
        set(handles.Classifier,'Enable', 'on')
        set(handles.FeatSelecBtn,'Enable', 'on')
        set(handles.ClassBTN,'Enable', 'on')
        set(handles.Reset,'Enable', 'on')
    else
        errordlg('Labels size is Different, Please Load Labels Again','Labels Format Error');
       % display ('Labels size is Different, Please Load Labels Again');
    end
    
    end
	guidata(hObject, handles)
end


      

% --- Executes on button press in LabelNamesBP.
function LabelNamesBP_Callback(hObject, eventdata, handles)
% hObject    handle to LabelNamesBP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[filename, pathname] = uigetfile( {'*.mat', 'All MAT-Files (*.mat)'; '*.*','All Files (*.*)'});
% If "Cancel" is selected then return
if isequal([filename,pathname],[0,0])
	return
% Otherwise construct the fullfilename and Check and load the file
else
	File = fullfile(pathname,filename);
    set(handles.GetLabels,'string',File);
    LabelsNames1=uiimport(File);
%   LabelsNames1= load (File);
    if (~isempty(LabelsNames1))
    vars = fieldnames(LabelsNames1);
    for i = 1:length(vars)
        Labels_Names = LabelsNames1.(vars{i});
    end   
    [n m] = size(Labels_Names);
    if ( isvector(LabelsNames1) && m == handles.DatasizeCol ) 
        assignin('base', 'Labels', Labels_Names);
    else
        errordlg('Labels Names size is Different, Please Load Label Names Again','Label Names Format Error');
       % display ('Labels size is Different, Please Load Labels Again');
    end
    end
	guidata(hObject, handles)
end


% --- Executes during object creation, after setting all properties.
function GetDataSet_CreateFcn(hObject, eventdata, handles)
% hObject    handle to GetDataSet (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function GetDataSet_Callback(hObject, eventdata, handles)
% hObject    handle to GetDataSet (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of GetDataSet as text
%        str2double(get(hObject,'String')) returns contents of GetDataSet as a double


% --- Executes during object creation, after setting all properties.
function GetLabels_CreateFcn(hObject, eventdata, handles)
% hObject    handle to GetLabels (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function LabelNamesEB_Callback(hObject, eventdata, handles)
% hObject    handle to LabelNamesEB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of LabelNamesEB as text
%        str2double(get(hObject,'String')) returns contents of LabelNamesEB as a double


% --- Executes during object creation, after setting all properties.
function LabelNamesEB_CreateFcn(hObject, eventdata, handles)
% hObject    handle to LabelNamesEB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function OpenDataSet_CreateFcn(hObject, eventdata, handles)
% hObject    handle to OpenDataSet (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function OpenLabels_CreateFcn(hObject, eventdata, handles)
% hObject    handle to OpenLabels (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function LabelNamesBP_CreateFcn(hObject, eventdata, handles)
% hObject    handle to LabelNamesBP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function DataSetInfoLB_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DataSetInfoLB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function DataSetAxes_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DataSetAxes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate DataSetAxes


% --- Executes during object creation, after setting all properties.
function figure1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function Featsel_Result_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Featsel_Result (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function Class_Results_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Class_Results (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function FeatSelecBtn_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FeatSelecBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function FSPlot_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FSPlot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function Reset_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function ClassBTN_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ClassBTN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function ClassPlot_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ClassPlot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



function ResultsEB_Callback(hObject, eventdata, handles)
% hObject    handle to ResultsEB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ResultsEB as text
%        str2double(get(hObject,'String')) returns contents of ResultsEB as a double


% --- Executes during object creation, after setting all properties.
function ResultsEB_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ResultsEB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on mouse press over axes background.
function DataSetAxes_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to DataSetAxes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function DataSetInfoLB_Callback(hObject, eventdata, handles)
% hObject    handle to DataSetInfoLB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DataSetInfoLB as text
%        str2double(get(hObject,'String')) returns contents of DataSetInfoLB as a double


% --------------------------------------------------------------------
function CopyResults_Callback(hObject, eventdata, handles)
% hObject    handle to CopyResults (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
