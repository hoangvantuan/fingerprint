function varargout = match2ridge(varargin)
% MATCH2RIDGE M-file for match2ridge.fig
%      MATCH2RIDGE, by itself, creates a new MATCH2RIDGE or raises the existing
%      singleton*.
%
%      H = MATCH2RIDGE returns the handle to a new MATCH2RIDGE or the handle to
%      the existing singleton*.
%
%      MATCH2RIDGE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MATCH2RIDGE.M with the given input arguments.
%
%      MATCH2RIDGE('Property','Value',...) creates a new MATCH2RIDGE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before match2ridge_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to match2ridge_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help match2ridge

% Last Modified by GUIDE v2.5 11-May-2016 15:41:59

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @match2ridge_OpeningFcn, ...
                   'gui_OutputFcn',  @match2ridge_OutputFcn, ...
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


% --- Executes just before match2ridge is made visible.
function match2ridge_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to match2ridge (see VARARGIN)

% Choose default command line output for match2ridge
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes match2ridge wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = match2ridge_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
originImage = loadImage();
originImage = histogramEqualization(originImage);
originImage = fouriorTranform(originImage,0.45);
originImage = binarization(double(originImage));
[outBound,outArea] = direction(originImage,16,1);
[process1Image,outBound,outArea] = ROIArea(originImage,outBound,outArea,1);
%process2Image = thinning2(process1Image);
process2Image = im2double(bwmorph(process1Image,'thin',Inf));
process2Image = im2double(bwmorph(process2Image,'clean'));
process2Image = im2double(bwmorph(process2Image,'hbreak'));
process2Image = im2double(bwmorph(process2Image,'spur'));
[endList,branchList,ridgeMap,edgeWidth]=markMinutia(process2Image,outBound,outArea,16);
[pathMap,endListReal,branchListReal]=falseMinutiaRemove(process2Image,endList,branchList,outArea,ridgeMap,edgeWidth);
axes(handles.axes4);
showMinutia(process2Image,endListReal,branchListReal);
% --- Executes on button press in pushbutton12.
function pushbutton12_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
originImage = loadImage();
originImage = histogramEqualization(originImage);
originImage = fouriorTranform(originImage,0.45);
originImage = binarization(double(originImage));
[outBound,outArea] = direction(originImage,16,1);
[process1Image,outBound,outArea] = ROIArea(originImage,outBound,outArea,1);
%process2Image = thinning2(process1Image);
process2Image = im2double(bwmorph(process1Image,'thin',Inf));
process2Image = im2double(bwmorph(process2Image,'clean'));
process2Image = im2double(bwmorph(process2Image,'hbreak'));
process2Image = im2double(bwmorph(process2Image,'spur'));
[endList,branchList,ridgeMap,edgeWidth]=markMinutia(process2Image,outBound,outArea,16);
[pathMap,endListReal,branchListReal]=falseMinutiaRemove(process2Image,endList,branchList,outArea,ridgeMap,edgeWidth);
axes(handles.axes5);
showMinutia(process2Image,endListReal,branchListReal);
