function [p,z] = direction(image,blocksize)


[w,h] = size(image);
direct = zeros(w,h);
gradient_times_value = zeros(w,h);
gradient_sq_minus_value = zeros(w,h);
gradient_for_bg_under = zeros(w,h);

W = blocksize;
theta = 0;
sum_value = 1;
bg_certainty = 0;

blockIndex = zeros(ceil(w/W),ceil(h/W));
%directionIndex = zeros(ceil(w/W),ceil(h/W));


times_value = 0;
minus_value = 0;

center = [];

%Note that the image coordinate system is
%x axis towards bottom and y axis towards right

%filter_gradient = fspecial('sobel');
filter_gradient = [-1 0 1 ; -2 0 2 ; -1 0 1];
%to get x gradient
I_horizontal = filter2(filter_gradient,image);
x = I_horizontal;
%to get y gradient
filter_gradient = [1 2 1 ; 0 0 0 ; -1 -2 -1];
I_vertical = filter2(filter_gradient,image);
y = I_vertical;

gradient_times_value=I_horizontal.*I_vertical;
gradient_sq_minus_value=(I_vertical-I_horizontal).*(I_vertical+I_horizontal);
gradient_for_bg_under = (I_horizontal.*I_horizontal) + (I_vertical.*I_vertical);


for i=1:W:w
    for j=1:W:h
      if j+W-1 < h & i+W-1 < w
		    times_value = sum(sum(gradient_times_value(i:i+W-1, j:j+W-1)));
          minus_value = sum(sum(gradient_sq_minus_value(i:i+W-1, j:j+W-1)));
          sum_value = sum(sum(gradient_for_bg_under(i:i+W-1, j:j+W-1)));
          gn = sum(sum(2.*x(i:i+W-1,j:j+W-1).*y(i:i+W-1,j:j+W-1)));
          gd = sum(sum(x(i:i+W-1,j:j+W-1).^2 - y(i:i+W-1,j:j+W-1).^2));
          theta = 0;
          
          if sum_value ~= 0 & times_value ~=0
             %if sum_value ~= 0 & minus_value ~= 0 & times_value ~= 0
             %bg_certainty = (times_value*times_value + minus_value*minus_value)/(W*W*sum_value);
             bg_certainty = sqrt((gn.^2+gd.^2)/(W*W*sum_value));
             % kiem tra block co nam tren vung van khong
             if bg_certainty > 0.05 
               %block nam tren vung van
             blockIndex(ceil(i/W),ceil(j/W)) = 1;
             
             %tan_value = atan2(minus_value,2*times_value);
             %tan_value = atan2(2*times_value,minus_value);
             tan_value = atan2(gd,gn);
                   %goc dinh huong cua block 
				theta = (tan_value)/2 ;
				%theta = theta+pi/2;
            %now the theta is within [0,pi]
            
            %directionIndex(ceil(i/W),ceil(j/W)) = theta;
            %center = [center;[round(i + (W-1)/2),round(j + (W-1)/2),theta,bg_certainty]];
            %trong tam va goc dinh huong cua block
             center = [center;[round(i + (W-1)/2),round(j + (W-1)/2),theta]];
        		end;
        end;
    end;
 			 times_value = 0;
          minus_value = 0;
          sum_value = 0;
          
   end;
end;


%show direction

    imagesc(direct);
	hold on;
	[u,v] = pol2cart(center(:,3),8);
    quiver(center(:,2),center(:,1),u,v,0,'g');
    hold off;

% ma tran 16x16 the hien cac khoi nam tren vung van
x = bwlabel(blockIndex,4);
%map = [0 0 0;jet(3)];
%figure
%imshow(x+1,map,'notruesize')

y = bwmorph(x,'close');
%figure
%imshow(y,map,'notruesize');

%z is the region of interest (ROI)
%with the index format 
%area
z = bwmorph(y,'open');
%figure
%imshow(z,map,'notruesize');

%p is the bound of ROI
%bound - tra lai chu vi theo bitmap
p = bwperim(z);
%figure,
%imshow(p,map,'notruesize');

%directMap = directionIndex;

