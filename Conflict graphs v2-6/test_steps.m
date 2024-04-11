function varargout = test_steps(varargin)
% TEST_STEPS MATLAB code for test_steps.fig
%      TEST_STEPS, by itself, creates a new TEST_STEPS or raises the existing
%      singleton*.
%
%      H = TEST_STEPS returns the handle to a new TEST_STEPS or the handle to
%      the existing singleton*.
%
%      TEST_STEPS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TEST_STEPS.M with the given input arguments.
%
%      TEST_STEPS('Property','Value',...) creates a new TEST_STEPS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before test_steps_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to test_steps_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help test_steps

% Last Modified by GUIDE v2.5 16-Oct-2017 19:28:45

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @test_steps_OpeningFcn, ...
                   'gui_OutputFcn',  @test_steps_OutputFcn, ...
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

% --- Executes just before test_steps is made visible.
function test_steps_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to test_steps (see VARARGIN)

% Choose default command line output for test_steps
handles.output = hObject;
handles.simparameters = setparameters;
handles.currentmap = handles.simparameters.start_state;
% Update handles structure
guidata(hObject, handles);

% This sets up the initial plot - only do when we are invisible
% so window can get raised using test_steps.
if strcmp(get(hObject,'Visible'),'off')
    updateWindow(hObject, handles)
end

% UIWAIT makes test_steps wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = test_steps_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in buttonStep.
function buttonStep_Callback(hObject, eventdata, handles)
% hObject    handle to buttonStep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[handles.currentmap , status] = turnstep(handles.currentmap, handles.simparameters);
if status == 0
    msgbox('Peace has been achieved.')
else
    updateWindow(hObject, handles)
end
guidata(hObject, handles);



% --------------------------------------------------------------------
function FileMenu_Callback(hObject, eventdata, handles)
% hObject    handle to FileMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function OpenMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to OpenMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
file = uigetfile('*.fig');
if ~isequal(file, 0)
    open(file);
end

% --------------------------------------------------------------------
function PrintMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to PrintMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
printdlg(handles.figure1)

% --------------------------------------------------------------------
function CloseMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to CloseMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
selection = questdlg(['Close ' get(handles.figure1,'Name') '?'],...
                     ['Close ' get(handles.figure1,'Name') '...'],...
                     'Yes','No','Yes');
if strcmp(selection,'No')
    return;
end

delete(handles.figure1)

% --- Executes on button press in buttonRestart.
function buttonRestart_Callback(hObject, eventdata, handles)
% hObject    handle to buttonRestart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.currentmap = handles.simparameters.start_state;
updateWindow(hObject, handles)
guidata(hObject, handles);


function updateWindow(hObject, handles)
plot(handles.currentmap);
compatibilitystatus = iscompatible(handles.currentmap, handles.simparameters.end_state, handles.simparameters);
if compatibilitystatus == 1
    handles.textCompatible.String = 'Compatible with end state.';
else
    handles.textCompatible.String = 'Not compatible with end state.';
end
guidata(hObject, handles);


% --- Executes on button press in buttonEndstate.
function buttonEndstate_Callback(hObject, eventdata, handles)
% hObject    handle to buttonEndstate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.currentmap  = handles.simparameters.end_state;
updateWindow(hObject, handles)
guidata(hObject, handles);


