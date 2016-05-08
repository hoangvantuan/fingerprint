function [roiImg,roiBound,roiArea] = ROIArea(in,inBound,inArea)

%l?y kích thý?c c?a ?nh theo pixel
[iw,ih]=size(in);
tmplate = zeros(iw,ih);

%l?y kích thý?c c?a ?nh theo block
[w,h] = size(inArea);
tmp=zeros(iw,ih);
%ceil(iw/16) nên = w
%ceil(ih/16) nên = h

%các v? trí trên, dý?i, trái, ph?i c?a ?nh theo block.
left = 1;
right = h;
upper = 1;
bottom = w;
% lo?i các ph?n r?a c?a ?nh.
% t?ng các giá tr? theo c?t
le2ri = sum(inBound);

%1 m?ng mang giá tr? th? t? c?a các c?t >0 ví d? [1,2,4,7,4,0,3]
%-->[1,2,3,4,5,6]
roiColumn = find(le2ri>0);

% l?y v? trí trái ph?i c?a vùng quan tâm
left = min(roiColumn);
right = max(roiColumn);

% ð?o vùng 
tr_bound = inBound';

% l?y v? trí trên dý?i c?a vùng quan tâm.
up2dw=sum(tr_bound);
roiRow = find(up2dw>0);
upper = min(roiRow);
bottom = max(roiRow);

%cut out the ROI region image

%show background,bound,innerArea with different gray intensity:0,100,200

for i = upper:1:bottom
   for j = left:1:right
      if inBound(i,j) == 1
          %vùng biên c?a vân tay màu g?n tr?ng
         tmplate(16*i-15:16*i,16*j-15:16*j) = 200;
         tmp(16*i-15:16*i,16*j-15:16*j) = 1;
       %vùng vân tay màu xám
      elseif inArea(i,j) == 1 & inBound(i,j) ~=1
         tmplate(16*i-15:16*i,16*j-15:16*j) = 100;
         tmp(16*i-15:16*i,16*j-15:16*j) = 1;
         
      end;
   end;
end;

%nhân ?nh v?i vùng vân tay.-->l?c b?t các nhi?u không thu?c vùng vân tay.
in=in.*tmp;


%?nh m?i.
roiImg = in(16*upper-15:16*bottom,16*left-15:16*right);

%gán l?i các giá tr? bound và area
roiBound = inBound(upper:bottom,left:right);
roiArea = inArea(upper:bottom,left:right);


        
%inner area --> các giá tr? c?a v? trí biên = -1
roiArea = im2double(roiArea) - im2double(roiBound);

if nargin == 3
	colormap(gray);
   imagesc(tmplate);
end;


