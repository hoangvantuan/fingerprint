function [] = saveFinger(pathMap, endListReal)

[filename,pathname] = uiputfile( ...
 {'*.dat';'*.*'}, ...
 'Luu du lieu van tay','match'); 
if isequal([filename,pathname],[0,0])
 return
 else
% Construct the full path and save
file = fullfile(pathname,filename);
save(file,'endListReal','pathMap','-ASCII');
end

end
