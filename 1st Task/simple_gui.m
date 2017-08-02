function varargout = simple_gui(varargin)
% SIMPLE_GUI MATLAB code for simple_gui.fig
%      SIMPLE_GUI, by itself, creates a new SIMPLE_GUI or raises the existing
%      singleton*.
%
%      H = SIMPLE_GUI returns the handle to a new SIMPLE_GUI or the handle to
%      the existing singleton*.
%
%      SIMPLE_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SIMPLE_GUI.M with the given input arguments.
%
%      SIMPLE_GUI('Property','Value',...) creates a new SIMPLE_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before simple_gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to simple_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help simple_gui

% Last Modified by GUIDE v2.5 07-Oct-2016 22:58:25

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @simple_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @simple_gui_OutputFcn, ...
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


% --- Executes just before simple_gui is made visible.
function simple_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to simple_gui (see VARARGIN)

% Choose default command line output for simple_gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes simple_gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% Set the "SelectedChannel" variable to the current selected item 
str = get(handles.popChannel,'String') ;
val = get(handles.popChannel,'Value');
handles.SelectedChannel = str{val};

% Set the "Result" variable to empty
handles.Result = [];
% Save the handles structure.
guidata(hObject, handles);


% --- Outputs from this function are returned to the command line.
function varargout = simple_gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in btnOpenImage.
function btnOpenImage_Callback(hObject, eventdata, handles)
% hObject    handle to btnOpenImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Open the image and save it in the "handles" struct
handles.Image = imread('jaguar.bmp');
% Set current drawing axes to "axes1"
axes(handles.axes1);
% Display the image
imshow(handles.Image);

% Enable the other buttons
set(handles.btnApply, 'Enable', 'on');
set(handles.btnBrightness, 'Enable', 'on');
set(handles.btnDisplayChannel, 'Enable', 'on');
set(handles.btnTranslate, 'Enable', 'on');
set(handles.transform, 'Enable', 'on');

% Save the handles structure.
guidata(hObject, handles);

% --- Executes on button press in btnSaveImage.
function btnSaveImage_Callback(hObject, eventdata, handles)
% hObject    handle to btnSaveImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in btnDisplayChannel.
function btnDisplayChannel_Callback(hObject, eventdata, handles)
% hObject    handle to btnDisplayChannel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.Result = GetImageChannel(handles.Image, handles.SelectedChannel); 

% Set current drawing axes to "axes2"
axes(handles.axes2);
imshow(handles.Result);

% Save the handles structure.
guidata(hObject, handles);

% --- Executes on selection change in popChannel.
function popChannel_Callback(hObject, eventdata, handles)
% hObject    handle to popChannel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popChannel contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popChannel
str = get(hObject,'String') ;
val = get(hObject,'Value');
handles.SelectedChannel = str{val};

% Save the handles structure.
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function figure1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in btnBrightness.
function btnBrightness_Callback(hObject, eventdata, handles)
% hObject    handle to btnBrightness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get brightness offset value from textbox
txtVal = get(handles.txtOffset, 'String');
str = get(handles.popupmenu3, 'String');
val = get(handles.popupmenu3, 'Value');
offset = str2num(txtVal) ;

channelValue = str{val};

disp(channelValue);

% Call the function
handles.Result = Brightness(handles.Image, channelValue, offset);

% Save the handles structure.
guidata(hObject, handles);

% Set current drawing axes to "axes2"
axes(handles.axes2);
imshow(handles.Result);



function txtOffset_Callback(hObject, eventdata, handles)
% hObject    handle to txtOffset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtOffset as text
%        str2double(get(hObject,'String')) returns contents of txtOffset as a double


% --- Executes during object creation, after setting all properties.
function txtOffset_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtOffset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btnApply.
function btnApply_Callback(hObject, eventdata, handles)
% hObject    handle to btnApply (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if (isempty(handles.Result))
    return;
end

% Set original "Image" to the "Result" image
handles.Image = handles.Result;

% Set current drawing axes to "axes1"
axes(handles.axes1);
imshow(handles.Image);

% Save the handles structure.
guidata(hObject, handles);


% --- Executes on button press in btnTranslate.
function btnTranslate_Callback(hObject, eventdata, handles)
% hObject    handle to btnTranslate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get X offset from textbox
% Get brightness offset value from textbox
txtVal = get(handles.txtXOffset, 'String');
Xoffset = str2num(txtVal) ;

% Call the function
handles.Result = Translate(handles.Image, Xoffset);

% Set current drawing axes to "axes2"
axes(handles.axes2);
imshow(handles.Result);

% Save the handles structure.
guidata(hObject, handles);



function txtXOffset_Callback(hObject, eventdata, handles)
% hObject    handle to txtXOffset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtXOffset as text
%        str2double(get(hObject,'String')) returns contents of txtXOffset as a double


% --- Executes during object creation, after setting all properties.
function txtXOffset_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtXOffset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu3.
function popupmenu3_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu3


% --- Executes during object creation, after setting all properties.
function popupmenu3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function rotationValue_Callback(hObject, eventdata, handles)
% hObject    handle to rotationValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of rotationValue as text
%        str2double(get(hObject,'String')) returns contents of rotationValue as a double


% --- Executes during object creation, after setting all properties.
function rotationValue_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rotationValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function xScaleValue_Callback(hObject, eventdata, handles)
% hObject    handle to xScaleValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of xScaleValue as text
%        str2double(get(hObject,'String')) returns contents of xScaleValue as a double


% --- Executes during object creation, after setting all properties.
function xScaleValue_CreateFcn(hObject, eventdata, handles)
% hObject    handle to xScaleValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function xShearValue_Callback(hObject, eventdata, handles)
% hObject    handle to xShearValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of xShearValue as text
%        str2double(get(hObject,'String')) returns contents of xShearValue as a double


% --- Executes during object creation, after setting all properties.
function xShearValue_CreateFcn(hObject, eventdata, handles)
% hObject    handle to xShearValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function yScaleValue_Callback(hObject, eventdata, handles)
% hObject    handle to yScaleValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of yScaleValue as text
%        str2double(get(hObject,'String')) returns contents of yScaleValue as a double


% --- Executes during object creation, after setting all properties.
function yScaleValue_CreateFcn(hObject, eventdata, handles)
% hObject    handle to yScaleValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function yShearValue_Callback(hObject, eventdata, handles)
% hObject    handle to yShearValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of yShearValue as text
%        str2double(get(hObject,'String')) returns contents of yShearValue as a double


% --- Executes during object creation, after setting all properties.
function yShearValue_CreateFcn(hObject, eventdata, handles)
% hObject    handle to yShearValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in transform.
function transform_Callback(hObject, eventdata, handles)
% hObject    handle to transform (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
theta = degtorad(str2double(get(handles.rotationValue, 'String')));
rotationMatrix = [cos(theta), -sin(theta); sin(theta), cos(theta)];

xScale = str2double(get(handles.xScaleValue, 'String'));
yScale = str2double(get(handles.yScaleValue, 'String'));
scaleMatrix = [xScale, 0; 0, yScale];

xShear = str2double(get(handles.xShearValue, 'string'));
yShear = str2double(get(handles.yShearValue, 'string'));
shearMatrix = [1, xShear; yShear, 1];

transformationMatrix = rotationMatrix * scaleMatrix * shearMatrix;

disp(transformationMatrix);

handles.Result = GeometricLinearTransform(handles.Image, transformationMatrix); 

% Set current drawing axes to "axes2"
axes(handles.axes2);
imshow(handles.Result);

% Save the handles structure.
guidata(hObject, handles);
