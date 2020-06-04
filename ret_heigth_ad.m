function [x_max,x_min,y_max,y_min,id,l,forground] = ret_heigth_ad(point,v,r0)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
id=((v(:,1)>=point(1) & v(:,1)<(point(1)+r0)) & (v(:,2)>=point(2) & v(:,2)<(point(2)+r0)));
         x_max=max(v(id,1));
         x_min=min(v(id,1));
         y_max=max(v(id,2));
         y_min=min(v(id,2));
         if(sum(id)>5)
             forground=1;
             l=v(id,5);
             l=l(1);
         else
            forground=0;
            l=0.5;
         end
         

end

