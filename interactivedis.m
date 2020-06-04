showPointCloud(v(:,1:3),v(:,4));
hold on
for i=1:current_label
 
id=(l==i);h1=showPointCloud(v(id,1:3),hsv2rgb([(i-1)/current_label ,0.75+(mod(i,current_label/4))/current_label ,4*(mod(i,current_label/4))/current_label]));
i
showPointCloud(v(id,1:3),[1 0 0]);
                   set(h1,'CameraViewAngle',CameraViewAngle)
                   set(h1,'CameraTarget',CameraTarget)
                   set(h1,'CameraPosition',CameraPosition)
  while(~waitforbuttonpress)
  end
 CameraViewAngle=h1.CameraViewAngle;
                    CameraTarget=h1.CameraTarget;
                    CameraPosition=h1.CameraPosition;

end