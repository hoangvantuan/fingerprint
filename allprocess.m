function [pathMap endListReal process2Image branchListReal] = allprocess(originImage)

originImage = histogramEqualization(originImage);
originImage = fouriorTranform(originImage,0.45);
originImage = binarization(double(originImage));
[outBound,outArea] = direction(originImage,16,1);
[process1Image,outBound,outArea] = ROIArea(originImage,outBound,outArea,1);
%process2Image = thinning2(process1Image);
process2Image = im2double(bwmorph(process1Image,'thin',Inf));
process2Image = im2double(bwmorph(process2Image,'clean'));
process2Image = im2double(bwmorph(process2Image,'hbreak'));
process2Image = im2double(bwmorph(process2Image,'spur'));
[endList,branchList,ridgeMap,edgeWidth]=markMinutia(process2Image,outBound,outArea,16);
[pathMap,endListReal,branchListReal]=falseMinutiaRemove(process2Image,endList,branchList,outArea,ridgeMap,edgeWidth);
end
