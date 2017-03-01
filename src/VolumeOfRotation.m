

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


a=stats.Centroid(1);
b=stats.Centroid(2);

Volume=(pi/2)*(sum((x_min-a).^2)+sum((x_max-a).^2));
