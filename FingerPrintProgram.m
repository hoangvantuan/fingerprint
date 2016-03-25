function varargout = FingerPrintProgram(varargin)
% FINGERPRINTPROGRAM M-file for FingerPrintProgram.fig
%      FINGERPRINTPROGRAM, by itself, creates a new FINGERPRINTPROGRAM or raises the existing
%      singleton*.
%
%      H = FINGERPRINTPROGRAM returns the handle to a new FINGERPRINTPROGRAM or the handle to
%      the existing singleton*.
%
%      FINGERPRINTPROGRAM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FINGERPRINTPROGRAM.M with the given input arguments.
%
%      FINGERPRINTPROGRAM('Property','Value',...) creates a new FINGERPRINTPROGRAM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before FingerPrintProgram_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to FingerPrintProgram_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help FingerPrintProgram

% Last Modified by GUIDE v2.5 25-Mar-2016 14:01:52

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @FingerPrintProgram_OpeningFcn, ...
                   'gui_OutputFcn',  @FingerPrintProgram_OutputFcn, ...
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


% --- Executes just before FingerPrintProgram is made visible.
function FingerPrintProgram_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to FingerPrintProgram (see VARARGIN)

% Choose default command line output for FingerPrintProgram
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes FingerPrintProgram wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = FingerPrintProgram_OutputFcn(hObject, eventdata, handles) 
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
global orgImage;
orgImage = loadImage();
axes(handles.axes1);
imagesc(orgImage);
colormap(gray);


% --- Executes on button press in btnHistEqua.
function btnHistEqua_Callback(hObject, eventdata, handles)
% hObject    handle to btnHistEqua (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global orgImage;
orgImage = histogramEqualization(orgImage);
axes(handles.axes2);
imagesc(orgImage);


% --- Executes on button press in btnFT.
function btnFT_Callback(hObject, eventdata, handles)
% hObject    handle to btnFT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global orgImage;

orgImage = fouriorTranform(orgImage,0.35);
axes(handles.axes1);
imagesc(orgImage);


% --- Executes on button press in btnBinarization.
function btnBinarization_Callback(hObject, eventdata, handles)
% hObject    handle to btnBinarization (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global orgImage;

%orgImage = binarization(double(orgImage));
orgImage = adaptivethreshold(double(orgImage),16,0.03,0);
axes(handles.axes2);
imagesc(orgImage);


% --- Executes on button press in btnDirection.
function btnDirection_Callback(hObject, eventdata, handles)
% hObject    handle to btnDirection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global orgImage;
global a;
global b;
axes(handles.axes1);
[b,a] = direction(orgImage,16);


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global orgImage;
global a;
global b;
global c;

axes(handles.axes2);
[c,b,a] = ROIArea(orgImage,b,a);