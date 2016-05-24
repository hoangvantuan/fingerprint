function [id_max num_max percent_max] = onevsall(filePath, template)
addpath('match');
if nargin == 1
template=load(char(filePath));
else nargin == 2 
 template = filePath;
end
listTemplate = dir('match');
k = size(listTemplate);
percent_max = 0;
id_max=0;
num_max=0;
for i =3 : k
id = str2double(char(listTemplate(i).name(1:3)));
num = str2double(char(listTemplate(i).name(5)));
template2 = load(char(strcat('match/',listTemplate(i).name)));

percent = match_end(template,template2,10);

if percent > percent_max & percent ~=100
id_max = id;
num_max = num;
percent_max = percent;
end
str_id = num2str(id);
str_num = num2str(num);
id_num = strcat(str_id,'_',str_num);
fprintf('%s \t %5.2f\n',id_num,percent);

end
fprintf('\n\n%d \t %d \t %f\n',id_max,num_max,percent_max)
end
