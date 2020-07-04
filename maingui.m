function varargout = HW3gui(varargin)
% HW3GUI MATLAB code for HW3gui.fig
%      HW3GUI, by itself, creates a new HW3GUI or raises the existing
%      singleton*.
%
%      H = HW3GUI returns the handle to a new HW3GUI or the handle to
%      the existing singleton*.
%
%      HW3GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in HW3GUI.M with the given input arguments.
%
%      HW3GUI('Property','Value',...) creates a new HW3GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before HW3gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to HW3gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help HW3gui

% Last Modified by GUIDE v2.5 20-Jan-2019 16:28:50

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @HW3gui_OpeningFcn, ...
                   'gui_OutputFcn',  @HW3gui_OutputFcn, ...
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


% --- Executes just before HW3gui is made visible.
function HW3gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to HW3gui (see VARARGIN)

% Choose default command line output for HW3gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes HW3gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = HW3gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
global Image1
Image1= im2double(imread('image1.bmp'));
axes(handles.axes1);

imshow(Image1);
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
clc

global Image1


[row1 column1] = size(Image1); 
[cp1 pxVL1] = imhist(Image1); 
ind1 = find(cp1>0); %Find non 0 gray level

Li1 = length(ind1); 

Pgrade = pxVL1(ind1); % new Gray level 
freq1 = cp1(ind1)./(row1*column1); % gray level frequency

freq1 = freq1'; 
fq = freq1;   
row1 = zeros(Li1-1,Li1);   
for i=1:Li1-1   
   [fq,mark] = sort(fq);   
   row1(Li1-i,1:Li1-i+1) = mark(1:Li1-i+1); 
   fq = [fq(1)+fq(2) ,fq(3:Li1) ,1];   
end
%store element in cell
CELL1 = cell(Li1-1,Li1);
CELL1(1,1)={'0'};   
CELL1(1,2)={'1'}; 
%perform cell operation 
for i=2:Li1-1   
   ind1 = find(row1(i-1,:) == 1); 
   tp1 = char(CELL1(i-1,ind1)); 
   CELL1(i,1) = {[tp1,'0']}; 
   CELL1(i,2) = {[tp1,'1']}; 
   snc = find(row1(i-1,:) ~= 1); 
   for j=3:i+1 
       cp1 = snc(j-2); 
       CELL1(i,j) = CELL1(i-1,cp1); 
      
   end 
end    
codeL1 = [];  
for i=1:Li1 
    ind1 = find(row1(Li1-1,:) == i); 
    code1 = char(CELL1(Li1-1,ind1)); 
    codeL1(i) = length(code1); 
    %display huffman coding results
    disp(strcat('Pixel gray value for image 1 = ',num2str(Pgrade(i)),' Huffman coding value for image 1: ',code1)); 
end 
avgL1 = 0; 
for i=1:Li1   
    avgL1 = avgL1 + freq1(i)*codeL1(i);   
end  

%print out the results
disp(strcat('Average length for image 1',' = ',num2str(avgL1))); 
ratio = 8/avgL1; 
disp(strcat('Compression ratio for image 1',' = ',num2str(ratio))); 




% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clc
global Image1
I2e=Image1;
format longG 

%get image to vector form with probabilities
pI2 = hist(I2e(:), linspace(0,1,256)); 
pI2(pI2==0) = []; 
pI2 = pI2/numel(I2e); 

%Get size of vector for loop creation
[M1 N1]=size(pI2);
z=0;
%create cell with probability intervals
for tr=1: N1
H{tr}=[z z+pI2(tr)];
 
z=z+pI2(tr);
end
%start encoding process
msg1=[1:N1]; %vector with the sequence that will ne analysed

yt=1;
H1=H;
J1=N1-1;
for rt=1:J1
    yt=msg1(rt); %get next value to be used for the sequence
    z=min(H1{yt});%lower bound
  tz=max(H1{yt}); %upper bound
  
  hjj= tz-z; %upper bound and lower bound diference
  
  %compute new intervals
 for tr=1:N1 %z<tz
   hj=pI2(tr).*hjj; %create new interval
   dz=z; %value will be used to compute sequence code
z2=z+hj; 

H1{tr}=[z z2]; %store interval 

z=z2; 

 end

end
format longG  
ko=(dz+tz)./2; %final value for arithmetic code

out=ko;

format longG 
disp(strcat('arithmetic code for is the image',' = ',num2str(ko))); 
 


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clc
global Image1
a1=Image1(1,:); %convert image to vector
lzwPP1=zeros(size(a1)); %Get vector to be used for dictionary
[r1 t1]= size(a1); %get size of image
lzwCELL1={}; %cell


new1=1; %to be used for writing values in lzwCELL1

lzwCELL1{1}= a1(1);%write first value in cell
lzwh1=1; %set for loop to be values in CELL
   lzwg1=a1(1); %used to get values in a1
   lzwz1=1;%number of columns
   
   lzwk1=1;
   lzwidk1=0;

 while t1>lzwk1
     %compare new sequence with used sequences
     for lzwh1=1:new1
    what=strfind(lzwCELL1{lzwh1},lzwg1); %see if the sequence was used
  id=(sum(what./what))-(isequal(lzwk1,t1)).*length(a1); 
  lzwidk1=lzwidk1+id;
  
     end
  if lzwidk1 ==0        
  new1=new1+1;
   lzwCELL1{new1}=lzwg1; %write new sequences in Cell
  
   lzwg1=a1(lzwk1);
   lzwz1=lzwk1;
  else if lzwidk1 >0
   
  lzwk1=lzwk1+1;
lzwg1=[lzwg1 a1(lzwk1)];
 
      else
         
      end
      
  end
  lzwidk1=0;
  

 end
%dispay cell values and create dictionary
for yuy=1:new1
    disp(lzwCELL1{yuy});
    nel=numel(lzwCELL1{yuy});
    if nel==1
    lzwPP1(yuy)=lzwCELL1{yuy};    
    else
        lzwPP1(yuy)=1+r1;
        r1=r1+1;
    end
      lzwPP1(lzwPP1==0) = []; 
    yuy=yuy+1;
  
end

% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
global im3
im3=im2double( imread('image3.bmp'));
axes(handles.axes2);
imshow(im3);
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
global im4
im4=im2double( imread('image4.bmp'));
axes(handles.axes3);
imshow(im4);
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im3
Im3=im3;
trt = ones(size(Im3(1,:))); %create 1d vector with same number of rows 
tr = zeros(size(Im3)); %create vector with same dimensions
I=Im3;
 [r3, c3] = size(Im3); %get the values for row and column of image
I1= ones(size(Im3)); 

% Prepare for loop 
 add1=1; 
 r3=r3-1; % make row 1 less  
 pp=1; 
for add1=1:r3 
zoo1= add1+1;

 x0a= Im3(add1,:); %get the associated row
 x1a=Im3(zoo1,:);  %get the row after x0a
 x11a=x1a; %take same value as x1a to be used later
 
  pp=1;
  %compare all row with all shifted versions of the following row 
 for pp=1:c3
     
 t=x0a-x1a; %row differences
  t1= sum(abs(t)); % make values positive and add them
  %1=norm(x0-x1);
  trt(1,pp)=t1; %place value in a new vector
x1a=circshift(x1a,1); % perform 1 right shift 
 pp=pp+1;
 end
 ere=min(trt); % minimum value
 [gl,lg]=find(trt== ere); %get the location of the min value
 lg=lg-1; %make it one less to avoid mistakes
Im3(zoo1,:)= circshift(x11a,lg); %shift the row in the original image by lg
add1=add1+1; %go to next  row

end

im=Im3;
axes(handles.axes5)
imshow(im);

% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
global Image1
Image1= im2double(imread('image2.bmp'));
axes(handles.axes1);
imshow(Image1);

% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im4
Im3=im4';
trt = ones(size(Im3(1,:))); %create 1d vector with same number of rows 
tr = zeros(size(Im3)); %create vector with same dimensions
I=Im3;
 [r3, c3] = size(Im3); %get the values for row and column of image
I1= ones(size(Im3)); 

% Prepare for loop 
 add1=1; 
 r3=r3-1; % make row 1 less  
 pp=1; 
for add1=1:r3 
zoo1= add1+1;

 x0a= Im3(add1,:); %get the associated row
 x1a=Im3(zoo1,:);  %get the row after x0a
 x11a=x1a; %take same value as x1a to be used later
 
  pp=1;
  %compare all row with all shifted versions of the following row 
 for pp=1:c3
     
 t=x0a-x1a; %row differences
  t1= sum(abs(t)); % make values positive and add them
  %1=norm(x0-x1);
  trt(1,pp)=t1; %place value in a new vector
x1a=circshift(x1a,1); % perform 1 right shift 
 pp=pp+1;
 end
 ere=min(trt); % minimum value
 [gl,lg]=find(trt== ere); %get the location of the min value
 lg=lg-1; %make it one less to avoid mistakes
Im3(zoo1,:)= circshift(x11a,lg); %shift the row in the original image by lg
add1=add1+1; %go to next  row

end

im=Im3;
axes(handles.axes6)
imshow(im');

% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
clc
global Image1
I1e=im2double(Image1);%convert to double
pI1 = hist(I1e(:), linspace(0,1,256)); %create vector with gray values
pI1(pI1==0) = []; %remove 0 elements
pI1 = pI1/numel(I1e); %create vector with gray values and their probabilities
out= -sum(pI1.*log2(pI1)); %perfom entropy calculation
disp(strcat('The entropy is',' = ',num2str(out)));


% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function uipanel2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uipanel2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



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



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton12.
function pushbutton12_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
