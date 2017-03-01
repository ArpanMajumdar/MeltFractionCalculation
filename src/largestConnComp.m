function [ img_largestConnComp ] = largestConnComp(img)
%   Detailed explanation goes here
    
img_largestConnComp=zeros(size(img));
CC=bwconncomp(img);
numPixels = cellfun(@numel,CC.PixelIdxList);
[biggest,idx] = max(numPixels);
img_largestConnComp(CC.PixelIdxList{idx}) = 1;
img_largestConnComp=(img_largestConnComp==1);

end

