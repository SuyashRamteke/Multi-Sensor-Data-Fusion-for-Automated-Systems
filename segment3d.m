function [l,current_label] = segment3d(v,r0,h_thresh)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
load cam2
import java.util.LinkedList
q = LinkedList();
v=[v,zeros(length(v),1)];
x_max=max(v(:,1));
x_min=min(v(:,1));
y_max=max(v(:,2));
y_min=min(v(:,2));
z_max=max(v(:,3));
z_min=min(v(:,3));
cube_faces=[1 0 0
    -1 0 0
    0 1 0
    0 -1 0
    0  0 3
    0  0 -1];
s=size(cube_faces,1);
current_label=0;
for k=z_min:r0:z_max
    for j=y_min:r0:y_max
        for i=x_min:r0:x_max
            point=[i j k];
            [~,~,id,label,forground]=ret_heigth(point,v,r0);
            if(label==0 && forground)
                current_label=current_label+1;
                v(id,5)=current_label;
                q.add(point);
                while(~(q.isEmpty))
                    point=q.remove();
                    close all;
%                    h1=showPointCloud(v(:,1:3),v(:,4));
%                    hold on;
                    [hmax,hmin,id,~,~]=ret_heigth(point,v,r0);
%                    showPointCloud(v(id,1:3),[1 0 0]);
%                    set(h1,'CameraViewAngle',CameraViewAngle)
%                    set(h1,'CameraTarget',CameraTarget)
%                    set(h1,'CameraPosition',CameraPosition)
%                    while(~waitforbuttonpress)
%                    end
%                    CameraViewAngle=h1.CameraViewAngle;
%                     CameraTarget=h1.CameraTarget;
%                     CameraPosition=h1.CameraPosition;
                    for l=1:s
                        
                        [tmax,tmin,ad_id,ad_lab,forground]=ret_heigth(point+cube_faces(l,:)',v,r0);
%                         showPointCloud(v(ad_id,1:3),[0 0 1]);
%                         set(h1,'CameraViewAngle',CameraViewAngle)
%                     set(h1,'CameraTarget',CameraTarget)
%                     set(h1,'CameraPosition',CameraPosition)
%                      while(~waitforbuttonpress)
%                    end
%                        CameraViewAngle=h1.CameraViewAngle;
% CameraTarget=h1.CameraTarget;
% CameraPosition=h1.CameraPosition;
                        if(ad_lab==0 && forground )
                            n=min([abs(tmax-hmin),abs(tmax-hmax),abs(tmin-hmax),abs(tmin-hmin)]);
                            if(n<h_thresh)
%                               showPointCloud(v(ad_id,1:3),[0 1 1]);                                                                                                    
%                               set(h1,'CameraViewAngle',CameraViewAngle)
%                    set(h1,'CameraTarget',CameraTarget)
%                    set(h1,'CameraPosition',CameraPosition)
%                                while(~waitforbuttonpress)
%                                 end
%                                CameraViewAngle=h1.CameraViewAngle;
%                               CameraTarget=h1.CameraTarget;
%                               CameraPosition=h1.CameraPosition;
                                v(ad_id,5)=current_label;
                                q.add(point+cube_faces(l,:)');
                            end
                        end
                    end
                end
            end
        end
    end
end

l=v(:,5);
end

