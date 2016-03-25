function image=loadImage

[imagefile1 , pathname]= uigetfile('*.bmp;*.BMP;*.tif;*.TIF;*.jpg','Open An Fingerprint image'); 
if imagefile1 ~= 0 
image=double(imread(fullfile(pathname, imagefile1)));
image = 255 - double(image);

end;


