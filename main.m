clear all
clc

Image1= im2double(imread('image1.bmp'));
Image2= im2double(imread('image2.bmp'));
im3=im2double( imread('image3.bmp'));
Im4=im2double( imread('image4.bmp'));
im4=Im4';

%IMAGE ENTROPY
IM1ENTROPY=ENTROPY(Image1);
IM2ENTROPY=ENTROPY(Image2);

%HUFFMAN CODING
 HUFFC(Image1);
  HUFFC(Image2);

%%ARITHMETIC CODING
format longG
im1Ari=ARITH(Image1);
im2Ari=ARITH(Image2);

%LZW CODING
LZWFIND(Image1);
LZWFIND(Image2);

%IMAGE PERMUTATION
im=IMRETRIEVE(im3);

 figure, subplot(2,2,1); imshow(im3);
title('shifted image 3')
subplot(2,2,2); imshow(im); 
title('retrieved image 3')

im=IMRETRIEVE(im4);

  subplot(2,2,3); imshow(Im4);
title('shifted image 4')
subplot(2,2,4); imshow(im'); %rotate the retrieved image once more to get the original image
title('retrieved image 4')

guide

function [out]=ENTROPY(I1e)

%calculation entropy for  image
I1e=im2double(I1e);%convert to double
pI1 = hist(I1e(:), linspace(0,1,256)); %create vector with gray values
pI1(pI1==0) = []; %remove 0 elements
pI1 = pI1/numel(I1e); %create vector with gray values and their probabilities
out= -sum(pI1.*log2(pI1)); %perfom entropy calculation

end


function LZWFIND(Img1)

a1=Img1(1,:); %convert image to vector
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

end


%Perform Huffman coding


function HUFFC(Image1)


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


end





%retrieve Images



function [im]= IMRETRIEVE(im3)
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
%imwrite(im,'new3.bmp');

end


%ARITHMETIC CODING

function [out]= ARITH(I2e)

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
disp(strcat('arithmetic code for is image',' = ',num2str(ko))); 
 

end










    

