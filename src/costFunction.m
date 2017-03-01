function [ cost ] = costFunction( population,data )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

m=size(data,1);
n=size(data,2);
[row ,col]=meshgrid(1:n,1:m);

popsize=size(population,1);
cost=zeros(popsize,1);

    for k=1:popsize
        a=population(k,1);
        b=population(k,2);
        radius=population(k,3);
        circle_mask=sqrt((row-a).^2+(col-b).^2)<=radius;
        mask=(circle_mask & data);
        cost(k)=-sum(mask(:));
    end
end

