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


times_value = 0;
minus_value = 0;

center = [];



filter_gradient = [-1 0 1 ; -2 0 2 ; -1 0 1];
%to get x gradient
x = filter2(filter_gradient,image);

%to get y gradient
filter_gradient = [1 2 1 ; 0 0 0 ; -1 -2 -1];
 y = filter2(filter_gradient,image);


gradient_times_value=x.*y;
gradient_sq_minus_value=(x-y).*(x+y);
gradient_for_bg_under = (x.*x) + (y.*y);


for i=1:W:w
    for j=1:W:h
      if j+W-1 < h & i+W-1 < w
		  gn = sum(sum(2.*gradient_times_value(i:i+W-1, j:j+W-1)));
          gd = sum(sum(gradient_sq_minus_value(i:i+W-1, j:j+W-1)));
          gs = sum(sum(gradient_for_bg_under(i:i+W-1, j:j+W-1)));
          theta = 0;
          
          if gs ~= 0 & gn ~=0
             %if sum_value ~= 0 & minus_value ~= 0 & times_value ~= 0
             bg_certainty = (gn*gn + gd*gd)/(W*W*gs);
             % kiem tra block co nam tren vung van khong
             if bg_certainty > 0.05 
               %block nam tren vung van, block n?m trên vùng vân --> 1 
             blockIndex(ceil(i/W),ceil(j/W)) = 1;
             
             tan_value = atan2(gn,gd);
             %tan_value = atan2(2*times_value,minus_value);
             %tan_value = atan(gn/gd);
                   %goc dinh huong cua block ,góc ð?nh hý?ng c?a block
				theta = (tan_value)/2 ;
                theta = theta+pi/2;
            %now the theta is within [0,pi]
           
            %trong tam va goc dinh huong cua block, g?c c?a hý?ng. 
             center = [center;[round(i + (W-1)/2),round(j + (W-1)/2),theta]];
        		end;
        end;
    end;
 			 times_value = 0;
          minus_value = 0;
          sum_value = 0;
          
   end;
end;


%show direction, hi?n th? trý?ng ð?nh hý?ng c?a vân tay

    imagesc(direct);
	hold on;
	[u,v] = pol2cart(center(:,3),8);
    quiver(center(:,2),center(:,1),u,v,0,'g');
    hold off;

% ma tran 16x16 the hien cac khoi nam tren vung van
x = bwlabel(blockIndex,4);
y = bwmorph(x,'close');
%area vùng quan tr?ng theo bitmap.
z = bwmorph(y,'open');
%bound - tra lai chu vi theo bitmap- bao quanh vùng quan tr?ng
p = bwperim(z);


