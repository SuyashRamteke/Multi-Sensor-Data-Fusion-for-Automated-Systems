function [h_max,h_min,id,l,forground] = ret_heigth(point,v,r0)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
id=(v(:,1)>=point(1) & v(:,1)<(point(1)+r0))& (v(:,2)>=point(2) & v(:,2)<(point(2)+r0)) & (v(:,3)>=point(3) & v(:,3)<(point(3)+r0));
         h_max=max(v(id,3));
         h_min=min(v(id,3));
         if(sum(id)>2)
             forground=1;
             l=v(id,5);
             l=l(1);
         else
            forground=0;
            l=0;
         end
         

end

