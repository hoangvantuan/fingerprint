%agrument : anh, bi�n, v�ng v�n, block
%return : �iem ket th�c (Termination), �iem re nh�nh (Bifurcation), s� �o v�n,  �o r?ng
%bi�n.
function [end_list,branch_list,ridgeOrderMap,edgeWidth] = markMinutia(in, inBound,inArea,block);

% l?y k�ch th�?c ?nh.
[w,h] = size(in);

%--> tr? l?i s? l�?ng v�n v� s� �? v�n.
[ridgeOrderMap,totalRidgeNum] = bwlabel(in); 

%g�n l?i c�c gi� tr?.
imageBound = inBound;
imageArea = inArea;
blkSize = block;

%t�nh kho?ng c�ch trung b?nh gi?a 2 v�n
edgeWidth = interRidgeWidth(in,inArea);

%kh?i t?o m?ng ch?a �I?M C?T v� �I?M R? NH�NH.
end_list    = [];
branch_list = [];

% v?ng l?p t?ng v�ng v�n.
for n=1:totalRidgeNum
    % tr? l?i v�ng v�n trong �� m : h�ng , n : c?t
   [m,n] = find(ridgeOrderMap==n);
   
   % b l� ma tr?n ch?a v�ng v�n th? n
   b = [m,n];
   
   % l?y s? h�ng c?a tr?n b
   ridgeW = size(b,1);
   
   % v?ng l?p t?ng h�ng l?y t?a �? c?a t?ng �i?m v�n. i,j
   for x = 1:ridgeW
      i = b(x,1);
      j = b(x,2);
      
      %if imageArea(ceil(i/blkSize),ceil(j/blkSize)) == 1 & imageBound(ceil(i/blkSize),ceil(j/blkSize)) ~= 1
      
% ki?m tra xem �i?m v�n c?a ?nh c� n?m trong v�ng quan t�m kh�ng ?
if inArea(ceil(i/blkSize),ceil(j/blkSize)) == 1
    %Kh?i t?o s? l�?ng �i?m v�n l�n c?n, t�nh to�n
      neiborNum = 0;
      %x�t c�c �i?m xung quanh �i?m v�n
       neiborNum = 1/2*(abs(in(i-1,j+1)-in(i-1,j))+abs(in(i,j+1)-in(i-1,j+1)) + abs(in(i+1,j+1)-in(i,j+1)) + abs(in(i+1,j)-in(i+1,j+1)) +  abs(in(i+1,j-1)-in(i+1,j)) +  abs(in(i,j-1)-in(i+1,j-1)) +  abs(in(i-1,j-1)-in(i,j-1)) +  abs(in(i-1,j)-in(i-1,j-1)));
      % tr? �i �i?m ch�nh gi?a ch�nh l� �i?m �ang x�t.
      %neiborNum = neiborNum -1;
    
   % tr�?ng h?p ch? c� 1 �i?m v�n trong kh?i block 3x3 �ang x�t. th? n� l� �i?m k?t th�c 
   if neiborNum == 1 
       % l�u t?a �? c?a �i?m k?t th�c
		end_list =[end_list; [i,j]];
    
   % tr�?ng h?p c� 3 �i?m l�n c?n 
   elseif neiborNum == 3
      %if two neighbors among the three are connected directly
      %there may be three braches are counted in the nearing three cells
      
      % tmp l� block 3x3 l�u c�c gi� tr? quanh i,j
      tmp=in(i-1:i+1,j-1:j+1);
      
      %g�n �i?m ch�nh gi?a, hay �i?m �ang x�t = 0
      tmp(2,2)=0;
      
      % l?y ma tr?n t?a �? c�c �i?m 1 xung quanh �i?m �ang x�t.
      [abr,bbr]=find(tmp==1);
      % t l�u ma tr?n t?a �? c�c �i?m xung quanh �i?m �ang x�t.
      t=[abr,bbr];
      
      %tr�?ng h?p ma tr?n l�u t?a �? nh�nh r?ng.
      if isempty(branch_list)
          % l�u �i?m nh�nh v�o ma tr?n.
         branch_list = [branch_list;[i,j]];
      else   
         
      for p=1:3
          % tr�?ng h?p trong branch list kh�ng r?ng -> ki?m tra xem c�
          % tr�ng kh�ng ?
         cbr=find(branch_list(:,1)==(abr(p)-2+i) & branch_list(:,2)==(bbr(p)-2+j) );
         % tr�?ng h?p tr�ng --> b? qua
         if ~isempty(cbr)
            p=4;
            break;
         end;
      end;
      % p!= 4 --> kh�ng tr�ng th�m �i?m r? nh�nh v�o danh s�ch.
      if p==3
          % l�u t?a �? c?a �i?m r? nh�nh 
         branch_list = [branch_list;[i,j]];
      end;
      
   	end;
   
  	end;	

	end;

end;
end;


