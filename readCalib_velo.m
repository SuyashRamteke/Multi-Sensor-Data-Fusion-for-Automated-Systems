function [R,T] = readCalib_velo(calib_dir,img_idx)

  % load 3x4 projection matrix
  P = dlmread(sprintf('%s/%06d.txt',calib_dir,img_idx),' ',0,1);
  P = P(6,:);
  P = reshape(P ,[4,3])';
  R=P(:,3);
  R=inv(R);
  T=P(:,4);
end
