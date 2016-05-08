function showMinutia(image,end_list,branch_list);

%show the image of all points in the list

colormap(gray);imagesc(image);
hold on;

% trý?ng h?p end list không r?ng
if ~isempty(end_list)

% v? các ði?m k?t thúc màu ð?
plot(end_list(:,2),end_list(:,1),'*r');

% trý?ng h?p có thêm góc ð?nh hý?ng. --> màu xanh lá
if size(end_list,2) == 3
   hold on
	[u,v] = pol2cart(end_list(:,3),10);
	quiver(end_list(:,2),end_list(:,1),u,v,0,'g');
end;
end;

% trý?ng h?p branch list không r?ng
if ~isempty(branch_list)
hold on
% v? các ði?m r? nhánh màu vàng
plot(branch_list(:,2),branch_list(:,1),'+y');
end;

hold off ;

	
