function [ volume ] = calcVolume2( img ,axis)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
height=sum(img);
dist_from_axis=1:length(height);
dist_from_axis=dist_from_axis-round(axis);
index=height~=0;
height=height(index);
dist_from_axis=abs(dist_from_axis(index));
volume=pi*(height*dist_from_axis');

end

