function template=fingerTemplateRead
%dialog for opening fingerprint files
%Honors Project 2001~2002
%wuzhili 99050056
%comp sci HKBU
%last update 19/April/2002

[templatefile , pathname]= uigetfile('*.dat','Open An Fingerprint template file'); 
if templatefile ~= 0
templatefile = fullfile(pathname,templatefile);
cd(pathname);
template=load(char(templatefile));
end;
