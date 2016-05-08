function [roiImg,roiBound,roiArea] = ROIArea(in,inBound,inArea)

%l?y k�ch th�?c c?a ?nh theo pixel
[iw,ih]=size(in);
tmplate = zeros(iw,ih);

%l?y k�ch th�?c c?a ?nh theo block
[w,h] = size(inArea);
tmp=zeros(iw,ih);
%ceil(iw/16) n�n = w
%ceil(ih/16) n�n = h

%c�c v? tr� tr�n, d�?i, tr�i, ph?i c?a ?nh theo block.
left = 1;
right = h;
upper = 1;
bottom = w;
% lo?i c�c ph?n r?a c?a ?nh.
% t?ng c�c gi� tr? theo c?t
le2ri = sum(inBound);

%1 m?ng mang gi� tr? th? t? c?a c�c c?t >0 v� d? [1,2,4,7,4,0,3]
%-->[1,2,3,4,5,6]
roiColumn = find(le2ri>0);

% l?y v? tr� tr�i ph?i c?a v�ng quan t�m
left = min(roiColumn);
right = max(roiColumn);

% �?o v�ng 
tr_bound = inBound';

% l?y v? tr� tr�n d�?i c?a v�ng quan t�m.
up2dw=sum(tr_bound);
roiRow = find(up2dw>0);
upper = min(roiRow);
bottom = max(roiRow);

%cut out the ROI region image

%show background,bound,innerArea with different gray intensity:0,100,200

for i = upper:1:bottom
   for j = left:1:right
      if inBound(i,j) == 1
          %v�ng bi�n c?a v�n tay m�u g?n tr?ng
         tmplate(16*i-15:16*i,16*j-15:16*j) = 200;
         tmp(16*i-15:16*i,16*j-15:16*j) = 1;
       %v�ng v�n tay m�u x�m
      elseif inArea(i,j) == 1 & inBound(i,j) ~=1
         tmplate(16*i-15:16*i,16*j-15:16*j) = 100;
         tmp(16*i-15:16*i,16*j-15:16*j) = 1;
         
      end;
   end;
end;

%nh�n ?nh v?i v�ng v�n tay.-->l?c b?t c�c nhi?u kh�ng thu?c v�ng v�n tay.
in=in.*tmp;


%?nh m?i.
roiImg = in(16*upper-15:16*bottom,16*left-15:16*right);

%g�n l?i c�c gi� tr? bound v� area
roiBound = inBound(upper:bottom,left:right);
roiArea = inArea(upper:bottom,left:right);


        
%inner area --> c�c gi� tr? c?a v? tr� bi�n = -1
roiArea = im2double(roiArea) - im2double(roiBound);

if nargin == 3
	colormap(gray);
   imagesc(tmplate);
end;


