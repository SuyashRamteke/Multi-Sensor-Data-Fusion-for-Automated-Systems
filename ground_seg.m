function [idx,C,g] = ground_seg(z,k)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
[idx,C]=kmeans(z,k);
m=1:k;
m=m(C<0);
count=zeros(size(m));
for i=m
count(i)=sum(idx==i);
end
[~,g]=max(count);
end

