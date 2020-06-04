import java.util.LinkedList
q = LinkedList();
v=velo(velo(:,3)>max(z_ax(idx==g)),:);
v=[v,zeros(length(v),1)];
x_max=max(v(:,1));
x_min=min(v(:,1));
y_max=max(v(:,2));
y_min=min(v(:,2));
z_max=max(v(:,3));
z_min=min(v(:,3));
h_thresh=0.3;
r0=1;
cube_faces=[1 0 0
    -1 0 0
    0 1 0
    0 -1 0
    0  0 1
    0  0 -1];
s=size(cube_faces,1);
current_label=0;
for k=z_min:r0:z_max
    for j=-10:r0:0
        for i=0:r0:10
            point=[i j k];
            [hmax,hmin,id,label,forground]=ret_heigth(point,v);
            if(label==0 && forground)
                current_label=current_label+1;
                v(id,5)=current_label;
                q.add(point);
                while(~(q.isEmpty))
                    point=q.remove();
                    [hmax,hmin,id,~,~]=ret_heigth(point,v);
                    for l=1:s
                        [tmax,tmin,ad_id,ad_lab,forground]=ret_heigth(point+cube_faces(l,:)',v);
                        if(ad_lab==0 && forground )
                            n=min([abs(tmax-hmin),abs(tmax-hmax),abs(tmin-hmax),abs(tmin-hmin)]);
                            if(n<h_thresh)
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
