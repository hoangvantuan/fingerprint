%agrument : anh, biên, vùng vân, block
%return : ðiem ket thúc (Termination), ðiem re nhánh (Bifurcation), sõ ðo vân,  ðo r?ng
%biên.
function [end_list,branch_list,ridgeOrderMap,edgeWidth] = markMinutia(in, inBound,inArea,block);

% l?y kích thý?c ?nh.
[w,h] = size(in);

%--> tr? l?i s? lý?ng vân và sõ ð? vân.
[ridgeOrderMap,totalRidgeNum] = bwlabel(in); 

%gán l?i các giá tr?.
imageBound = inBound;
imageArea = inArea;
blkSize = block;

%tính kho?ng cách trung b?nh gi?a 2 vân
edgeWidth = interRidgeWidth(in,inArea);

%kh?i t?o m?ng ch?a ÐI?M C?T và ÐI?M R? NHÁNH.
end_list    = [];
branch_list = [];

% v?ng l?p t?ng vùng vân.
for n=1:totalRidgeNum
    % tr? l?i vùng vân trong ðó m : hàng , n : c?t
   [m,n] = find(ridgeOrderMap==n);
   
   % b là ma tr?n ch?a vùng vân th? n
   b = [m,n];
   
   % l?y s? hàng c?a tr?n b
   ridgeW = size(b,1);
   
   % v?ng l?p t?ng hàng l?y t?a ð? c?a t?ng ði?m vân. i,j
   for x = 1:ridgeW
      i = b(x,1);
      j = b(x,2);
      
      %if imageArea(ceil(i/blkSize),ceil(j/blkSize)) == 1 & imageBound(ceil(i/blkSize),ceil(j/blkSize)) ~= 1
      
% ki?m tra xem ði?m vân c?a ?nh có n?m trong vùng quan tâm không ?
if inArea(ceil(i/blkSize),ceil(j/blkSize)) == 1
    %Kh?i t?o s? lý?ng ði?m vân lân c?n, tính toán
      neiborNum = 0;
      %xét các ði?m xung quanh ði?m vân
       neiborNum = 1/2*(abs(in(i-1,j+1)-in(i-1,j))+abs(in(i,j+1)-in(i-1,j+1)) + abs(in(i+1,j+1)-in(i,j+1)) + abs(in(i+1,j)-in(i+1,j+1)) +  abs(in(i+1,j-1)-in(i+1,j)) +  abs(in(i,j-1)-in(i+1,j-1)) +  abs(in(i-1,j-1)-in(i,j-1)) +  abs(in(i-1,j)-in(i-1,j-1)));
      % tr? ði ði?m chính gi?a chính là ði?m ðang xét.
      %neiborNum = neiborNum -1;
    
   % trý?ng h?p ch? có 1 ði?m vân trong kh?i block 3x3 ðang xét. th? nó là ði?m k?t thúc 
   if neiborNum == 1 
       % lýu t?a ð? c?a ði?m k?t thúc
		end_list =[end_list; [i,j]];
    
   % trý?ng h?p có 3 ði?m lân c?n 
   elseif neiborNum == 3
      %if two neighbors among the three are connected directly
      %there may be three braches are counted in the nearing three cells
      
      % tmp là block 3x3 lýu các giá tr? quanh i,j
      tmp=in(i-1:i+1,j-1:j+1);
      
      %gán ði?m chính gi?a, hay ði?m ðang xét = 0
      tmp(2,2)=0;
      
      % l?y ma tr?n t?a ð? các ði?m 1 xung quanh ði?m ðang xét.
      [abr,bbr]=find(tmp==1);
      % t lýu ma tr?n t?a ð? các ði?m xung quanh ði?m ðang xét.
      t=[abr,bbr];
      
      %trý?ng h?p ma tr?n lýu t?a ð? nhánh r?ng.
      if isempty(branch_list)
          % lýu ði?m nhánh vào ma tr?n.
         branch_list = [branch_list;[i,j]];
      else   
         
      for p=1:3
          % trý?ng h?p trong branch list không r?ng -> ki?m tra xem có
          % trùng không ?
         cbr=find(branch_list(:,1)==(abr(p)-2+i) & branch_list(:,2)==(bbr(p)-2+j) );
         % trý?ng h?p trùng --> b? qua
         if ~isempty(cbr)
            p=4;
            break;
         end;
      end;
      % p!= 4 --> không trùng thêm ði?m r? nhánh vào danh sách.
      if p==3
          % lýu t?a ð? c?a ði?m r? nhánh 
         branch_list = [branch_list;[i,j]];
      end;
      
   	end;
   
  	end;	

	end;

end;
end;


