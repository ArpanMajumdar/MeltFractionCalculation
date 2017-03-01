function [ filtered_img ] = MeanFilter(noisy_img,windowsize)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
k=windowsize;
h=ones(k,k)./(k*k);
filtered_img=conv2(double(noisy_img),h,'same');
filtered_img=uint8(filtered_img);
end

