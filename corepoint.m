function x = corepoint(end_list)
n = size(end_list,1);
x = zeros(1,2);
x = [(end_list(1,1)+end_list(2,1))/2,(end_list(1,2)+end_list(2,2))/2];
for k = 3 : n
    x = [(x(1,1)+end_list(k,1))/k,(x(1,2)+end_list(k,2))/k];
end;
end