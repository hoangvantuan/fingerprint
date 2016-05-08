function [pathMap, final_end,final_branch] =falseMinutiaRemove(in,end_list,branch_list,inArea,ridgeOrderMap,edgeWidth)

	
%l?y size c?a ?nh 
[w,h] = size(in);

% kh?i t?o m?ng 
final_end = [];
final_branch =[];
direct = [];
pathMap = [];

%kh?i t?o c?t th? 3 cho end list là 0 và branch list = 1
%ðánh d?u ðâu là ði?m c?t, ðâu là ði?m r? nhánh
end_list(:,3) = 0;
branch_list(:,3) = 1;

% m?ng ch?a các ði?m minutiae
minutiaeList = [end_list;branch_list];
finalList = minutiaeList;

% l?y s? lý?ng minutiae và dummy là v? trí và góc c?a ði?m.
[numberOfMinutia,dummy] = size(minutiaeList);
suspectMinList = [];
%% T?m ki?m các ði?m ð?c trýng kh? nghi
% so sánh các minutiae v?i nhau.
for i= 1:numberOfMinutia-1
   for j = i+1:numberOfMinutia
       %tính kho?ng cách gi?a 2 vân
      d =( (minutiaeList(i,1) - minutiaeList(j,1))^2 + (minutiaeList(i,2)-minutiaeList(j,2))^2)^0.5;
      % so sánh kho?ng cách v?i kho?ng cách trung b?nh gi?a 2 vân n?u < -->
      % thêm vào m?ng vân kh? nghi
      if d < edgeWidth
          % 2 ði?m minutiae c?t i và c?t j b? kh? nghi là nhi?u.
         suspectMinList =[suspectMinList;[i,j]];
      end;
   end;
end;

%l?y s? lý?ng vân kh? nghi.
[totalSuspectMin,dummy] = size(suspectMinList);
%totalSuspectMin
%% xét các ði?m ð?c trýng kh? nghi
for k = 1:totalSuspectMin
    
    %t?ng giá tr? c?t 3 c?a ði?m ð?c trýng sai : ði?m kêt thúc là 0 , ði?m
    %r? nhánh là 1 
   typesum = minutiaeList(suspectMinList(k,1),3) + minutiaeList(suspectMinList(k,2),3);
   
   %trý?ng h?p i là r? nhánh j là c?t ho?c ngý?c l?i --> 1+0 or 0+1
   if typesum == 1
      % branch - end pair. Ti?n hành s?a.
      % ki?m tra trong sõ ð? vân. n?u ði?m minutiae 1 có giá tr? = v?i ði?m
      % minutiae 2 --> cùng 1 vùng vân
      if ridgeOrderMap(minutiaeList(suspectMinList(k,1),1),minutiaeList(suspectMinList(k,1),2) ) ==  ridgeOrderMap(minutiaeList(suspectMinList(k,2),1),minutiaeList(suspectMinList(k,2),2) )
          %gán t?a ð? cho các minutia là -1 
          finalList(suspectMinList(k,1),1:2) = [-1,-1];
	      finalList(suspectMinList(k,2),1:2) = [-1,-1];
      end;
      % trý?ng h?p i là r? nhánh j là r? nhánh
   elseif typesum == 2
      % branch - branch pair
      if ridgeOrderMap(minutiaeList(suspectMinList(k,1),1),minutiaeList(suspectMinList(k,1),2) ) ==  ridgeOrderMap(minutiaeList(suspectMinList(k,2),1),minutiaeList(suspectMinList(k,2),2) )
         finalList(suspectMinList(k,1),1:2) = [-1,-1];
	      finalList(suspectMinList(k,2),1:2) = [-1,-1];
      end;
      %trý?ng h?p là 2 ði?m c?t.
   elseif typesum == 0
      % end - end pair
      % l?y t?a ð? 2 ði?m minutiae c?t
      a = minutiaeList(suspectMinList(k,1),1:3);
      b = minutiaeList(suspectMinList(k,2),1:3);
     
      % n?u 2 ði?m c?t không n?m trên 1 vùng vân
      if ridgeOrderMap(a(1),a(2)) ~=  ridgeOrderMap(b(1),b(2))
          
         % l?y góc ð?nh hý?ng c?c b? c?a ðo?n c?t và path c?a nó.
         [thetaA,pathA,dd,mm] = getLocalTheta(in,a,edgeWidth); 
         [thetaB,pathB,dd,mm] = getLocalTheta(in,b,edgeWidth); 
         
         %the connected line between the two points
         
         thetaC = atan2( (pathA(1,1)-pathB(1,1)), (pathA(1,2) - pathB(1,2)) );
         
         
         angleAB = abs(thetaA-thetaB);
         angleAC = abs(thetaA-thetaC);
         
        % n?u góc ð?nh hý?ng nh? hõn ngý?ng pi/3 -> lo?i ra 
         if ( (or(angleAB < pi/3, abs(angleAB -pi)<pi/3 )) & (or(angleAC < pi/3, abs(angleAC - pi) < pi/3)) )  
            finalList(suspectMinList(k,1),1:2) = [-1,-1];
            finalList(suspectMinList(k,2),1:2) = [-1,-1];
         end;
         
         %n?u 2 ði?m c?t n?m trên 1 vùng vân
         %remove short ridge later
      elseif  ridgeOrderMap(a(1),a(2)) ==  ridgeOrderMap(b(1),b(2))        
         finalList(suspectMinList(k,1),1:2) = [-1,-1];
         finalList(suspectMinList(k,2),1:2) = [-1,-1];

      end;
   end;
end;

    % v?ng l?p s? lý?ng minutiae
   for k =1:numberOfMinutia
       % trý?ng h?p nó không là vân ð? b? lo?i
      if finalList(k,1:2) ~= [-1,-1]
          % là vân c?t
         if finalList(k,3) == 0
             % l?y góc ð?nh hý?ng c?c b? c?a vân c?t
            [thetak,pathk,dd,mm] = getLocalTheta(in,finalList(k,:),edgeWidth);
            % trý?ng h?p ð? dài c?a path > ð? r?ng vân
            if size(pathk,1) >= edgeWidth
                % thêm vào danh sách
            	final_end=[final_end;[finalList(k,1:2),thetak]];
                %l?y s? lý?ng ði?m ð?c trýng vân c?t
            	[id,dummy] = size(final_end);
                %thêm id vào path
            	pathk(:,3) = id;
                % thêm path c?a vân c?t vào pathmap
            	pathMap = [pathMap;pathk];
            end;
            
          % là ði?m r? nhánh
         else
          
            % l?y path và góc ð?nh hý?ng c?a ði?m r? nhánh
            [thetak,path1,path2,path3] = getLocalTheta(in,finalList(k,:),edgeWidth);
            % n?u ð? dài c?a các path >= ð? r?ng vân th? thêm vào final end
            if size(path1,1)>=edgeWidth & size(path2,1)>=edgeWidth & size(path3,1)>=edgeWidth
              % thêm vào vào m?ng nhánh 
            final_branch=[final_branch;finalList(k,1:2)];
            % thêm góc ð?nh hý?ng và t?a ð? c?a path1
            final_end=[final_end;[path1(1,1:2),thetak(1)]];
            % l?y s? lý?ng minutiae
            [id,dummy] = size(final_end);
            % gán id
            path1(:,3) = id;
            %thêm vào pathmap
            pathMap = [pathMap;path1];
           
             % thêm góc ð?nh hý?ng và t?a ð? c?a path2
            final_end=[final_end;[path2(1,1:2),thetak(2)]];
            path2(:,3) = id+1;
            pathMap = [pathMap;path2];
           
             % thêm góc ð?nh hý?ng và t?a ð? c?a path3
            final_end=[final_end;[path3(1,1:2),thetak(3)]];
				path3(:,3) = id+2;
            pathMap = [pathMap;path3];
           
         	end;
         % final_end: lýu t?a ð? và góc ð?nh hý?ng c?a ði?m ð?c trýng
         % path_map: lýu ð?ng d?n và id c?a ði?m ð?c trýng
            
         end;
      end;
   end;
   
   %final_end
   %pathMap
   %edgeWidth      
  
       
         
