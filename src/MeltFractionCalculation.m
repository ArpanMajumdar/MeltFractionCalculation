img=imread('fig7.jpg');
img=rgb2gray(img);

[level,beaker_img]=thresh_tool(img);
[level,ice_img]=thresh_tool(img);

%%
% Keep only the largest connecetd component
beaker_img=largestConnComp(beaker_img);
ice_img=largestConnComp(ice_img);
ice_img=imfill(ice_img,'holes');
%%
[~,index]=max(ice_img);

overlap=zeros(size(ice_img));
for m=1:length(index)
    if index(m)~=1
        overlap(index(m):end,m) = 1;
    end
end
ice_img= overlap & beaker_img;
%%
stats_beaker=regionprops(beaker_img,'Centroid','MajorAxisLength','MinorAxisLength','Area');
axis=stats_beaker.Centroid(1);

beakerVolume=calcVolume2(beaker_img,axis);
iceVolume=calcVolume2(ice_img,axis);
meltFrac=(beakerVolume-iceVolume)/beakerVolume;
%%
%Publishing the Results
final_img = zeros(size(img,1),size(img,2),3);
final_img(:,:,1)=(beaker_img)*255;
final_img(:,:,2)=ice_img*255;
figure;
subplot(121),imshow(img)
subplot(122),imshow(final_img)
title(['Melt fraction=' num2str(meltFrac*100) ' %']);
