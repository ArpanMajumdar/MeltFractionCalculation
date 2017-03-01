clc,clear,close all, warning off
% Read image
fig1=imread('fig1.JPG');
fig1=rgb2gray(fig1);
figure(1)
imshow(fig1)
title('Original image')

% Choose proper threshold such that beaker is completely visible

%[level,img_bw]=thresh_tool(fig1);
img_bw=im2bw(fig1,67/255);

% Perform noise removal
img_clean=bwareaopen(img_bw,100);
img_fill=imfill(img_clean,'holes');

% Select the largest connected component(which represents beaker)
img_largestConnComp=zeros(size(img_fill));
CC=bwconncomp(img_fill);
numPixels = cellfun(@numel,CC.PixelIdxList);
[biggest,idx] = max(numPixels);
img_largestConnComp(CC.PixelIdxList{idx}) = 1;
img_largestConnComp=(img_largestConnComp==1);

%% Try to calculate approximate centre and radius of the circle

stats=regionprops(img_largestConnComp,'Centroid','MajorAxisLength','MinorAxisLength');
%imshow(img_largestConnComp)
centers=stats.Centroid ;
radius=(stats.MajorAxisLength+stats.MinorAxisLength)/4;

% Draw circle
figure(2)
imshow(img_largestConnComp)
title('Approximate circle fit')
h = viscircles(centers,radius);

%% Circle fitting by Backtracking Search Algorithm (For finding exact centre and radius of circle)
low=[centers(1)-(radius/8) ,centers(2)-(radius/8) ,15*(radius/16)];
up=[centers(1)+(radius/8) ,centers(2)+(radius/8) ,17*(radius/16)];
data=img_largestConnComp;
bsa('costFunction',data,15,3,1,low,up,25);

%%
a=globalminimizer(1);
b=globalminimizer(2);
r=globalminimizer(3);
figure(3)
imshow(img_largestConnComp)
title('Accurate circle fit using Backtraking Search Algorithm')
h = viscircles([a b],r);

%%
m=size(data,1);
n=size(data,2);
[row ,col]=meshgrid(1:n,1:m);
circle_mask=sqrt((row-a).^2+(col-b).^2)<=r;
img_cropped=fig1;
img_cropped(~circle_mask)=0;
figure(4)
imshow(img_cropped)
title('Beaker segmented from background')

%%
% img_meanfilter=fig1;
% for k=1:5
%     img_meanfilter=MeanFilter(img_meanfilter,20);
% end
% imshow(img_meanfilter)


