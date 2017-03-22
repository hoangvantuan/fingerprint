function showMinutia(image,end_list,branch_list);

%show the image of all points in the list

colormap(gray);imagesc(image);
hold on;

% tr�?ng h?p end list kh�ng r?ng
if ~isempty(end_list)

% v? c�c �i?m k?t th�c m�u �?
plot(end_list(:,2),end_list(:,1),'*r');

% tr�?ng h?p c� th�m g�c �?nh h�?ng. --> m�u xanh l�
if size(end_list,2) == 3
   hold on
	[u,v] = pol2cart(end_list(:,3),10);
	quiver(end_list(:,2),end_list(:,1),u,v,0,'g');
end;
end;

% tr�?ng h?p branch list kh�ng r?ng
if ~isempty(branch_list)
hold on
% v? c�c �i?m r? nh�nh m�u v�ng
plot(branch_list(:,2),branch_list(:,1),'+y');
end;

hold off ;

	
