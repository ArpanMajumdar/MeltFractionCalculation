function [ volume ] = calcVolume( binImg ,axis)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
img_edge=edge(binImg);

[y,x]=find(img_edge);
[~,index]=sort(y);
y=y(index);x=x(index);

y_begin=min(y);
y_end=max(y);
x_min=zeros(y_end-y_begin+1,1);
x_max=zeros(y_end-y_begin+1,1);
for k=y_begin:y_end
    index=y==k;
    
    if ~isempty(index)
        x_cur=x(index);
        x_min(k-y_begin+1)=min(x_cur);
        x_max(k-y_begin+1)=max(x_cur);
    end
end


volume=(pi/2)*(sum((x_min-axis).^2)+sum((x_max-axis).^2));

end

