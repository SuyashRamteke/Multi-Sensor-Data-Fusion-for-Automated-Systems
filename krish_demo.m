clear all
warning off
load cam
img_idx =0;
root_dir = 'E:\';
data_set = 'training';
% get sub-directories
cam = 2; % 2 = left color camera
image_dir = fullfile(root_dir,[data_set '/image_' num2str(cam)]);
label_dir = fullfile(root_dir,[data_set '/label_' num2str(cam)]);
calib_dir = fullfile(root_dir,[data_set '/calib']);
img_idx=0;
nimages = length(dir(fullfile(image_dir, '*.png')));
flag=1;
while 1
    if(flag==1)
        flag=0;
        fid = fopen(sprintf('%s/training/velodyne/%06d.bin',root_dir,img_idx),'rb');
        velo = fread(fid,[4 inf],'single')';
        fclose(fid);
        img=imread(sprintf('%s/%06d.png',image_dir,img_idx));
        imshow(img);
        figure (2);
        h1=showPointCloud(velo(:,1:3),velo(:,4));
        hold on;
        z_ax=velo(:,3);
        figure(3);
        [idx,C,g] = ground_seg(z_ax,4);
        h2=showPointCloud(velo(velo(:,3)>max(z_ax(idx==g)),1:3),velo(velo(:,3)>max(z_ax(idx==g)),4));
        [R,T] = readCalib_velo(calib_dir,img_idx);
        objects = readLabels(label_dir,img_idx);
        for obj_idx=1:numel(objects)
            object=objects(obj_idx);
            [corners_3D,face_idx] = krish_compute_3D(object);
            corners_3D=R*(corners_3D-repmat(T,1,size(corners_3D,2)));
            corner.x=corners_3D(1,:);
            corner.y=corners_3D(2,:);
            corner.z=corners_3D(3,:);
            figure(2)
            draw_box;
            figure(3)
            draw_box;
        end
        set(h1,'CameraViewAngle',CameraViewAngle)
        set(h1,'CameraTarget',CameraTarget)
        set(h1,'CameraPosition',CameraPosition)
        set(h2,'CameraViewAngle',CameraViewAngle)
        set(h2,'CameraTarget',CameraTarget)
        set(h2,'CameraPosition',CameraPosition)
        
    end
        waitforbuttonpress;
        key = get(gcf,'CurrentCharacter');
        
        switch lower(key)
            case 'n', img_idx=min(img_idx+1,  nimages-1),flag=1,close all;
        end
end
close all