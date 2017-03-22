% kh?p m?u
function [newXY] = MinuOriginTransRidge(real_end,k,ridgeMap)
%  MinuOrigin(real_end,k,ridgeMap)
%	set the k-th minutia as origin and align its direction to zero(along x)
%  and then accommodate all other ridge points connecting to the miniutia to the
%  new coordinaete system
%
% set minutiae k nhý là g?c và  ði?u ch?nh góc ð?nh hý?ng v? 0 theo tr?c x
% và dàn x?p t?t c? các ði?m vân khác k?t n?i các minutiae sang h? t?a ð? m?i 
%
%  Note that the coordination sytem and the angle are different:
%  ---------------------->y
%  |\
%  | \
%  |  \
%  |   \   
%  |thet\a
%  x
%  position value toward bottom, right are positive.
%
%  Góc quay là ngý?c chi?u kim ð?ng h? t? dý?i lên trên sang ph?i là 0->pi
%  và cùng chi?u kim ð?ng h? sang trái là 0->-pi
%
%  angle value(góc quay) are anti-clockwised(ngý?c chi?u kim ð?ng h?) from bottom to the top of the x axis on the right,within [0,pi]
%          and are clockwised from bottom to top of the x axis on the left,within [0,-pi]


        % toán tu quay 1 góc theta
		%construct the affine transform matrix	
		% cos(theta)  -sin(theta)
		% sin(theta)   cos(thea)
		% to rotate angle theta
      
      % lay góc ðinh hýõng cua ðiêm minutiae
      theta = real_end(k,3);
      
      if theta <0
		theta1=2*pi+theta;
		end;

		theta1=pi/2-theta;
        % matran xoay 1 góc theta
      rotate_mat=[cos(theta1),-sin(theta1);sin(theta1),cos(theta1)];
      
      % lay vi trí cua tat ca các ðiem ket noi toi minutia và ðat nó vào form
      %locate all the ridge points connecting to the miniutia
      %and transpose it as the form:
      %x1 x2 x3...
      %y1 y2 y3...
      % mang 1 phan tu chua vi trí thu i
      pathPointForK = find(ridgeMap(:,3)== k);
      % tap hop các ðiem path cua minutiae k . chuyen vi
      toBeTransformedPointSet = ridgeMap(min(pathPointForK):max(pathPointForK),1:2)';
      % chuyen vii trí cua minutiae ve 0 và tat ca các ðiem ket noi toi nó
      % theo nó
      %translate the minutia position (x,y) to (0,0)
      %translate all other ridge points according to the basis 
      % lay so lýong ðiem connect
      tonyTrickLength = size(toBeTransformedPointSet,2);
      % ðiem bat ðau.
      pathStart = real_end(k,1:2)';
      % dich chuyen minutiae ve goc 0 0
      translatedPointSet = toBeTransformedPointSet - pathStart(:,ones(1,tonyTrickLength));
      % quay toàn b? 1 góc theta. v? tr?c x
      %rotate the point sets 
      newXY = rotate_mat*translatedPointSet;
      
     
            
      
      
