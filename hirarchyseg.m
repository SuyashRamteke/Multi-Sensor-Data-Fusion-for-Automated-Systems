v=velo(velo(:,3)>max(z_ax(idx==g)),:);
v=v((v(:,1)<=20 & v(:,1)>=-20) & (v(:,2)<=20 & v(:,2)>=-15),:,:,:);
[l,current_label] = segment3d_ad(v,1,0.3);
showPointCloud(v(:,1:3),v(:,4));
hold on
for i=1:current_label
id=(l==i);
showPointCloud(v(id,1:3),hsv2rgb([(i-1)/current_label 0.75+(mod(i,current_label/4))/current_label 4*(mod(i,(current_label+1)/4))/(current_label+1)]));
i
end

v=v(l==32,1:4);
[l,current_label] = segment3d_ad(v,.5,0.1);
figure;
 showPointCloud(v(:,1:3),v(:,4));
hold on
for i=1:current_label
id=(l==i);showPointCloud(v(id,1:3),hsv2rgb([(i-1)/current_label 0.75+(mod(i,current_label/4))/current_label 4*(mod(i,(current_label+1)/4))/(current_label+1)]));
i
end
