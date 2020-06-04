function spinImgs = SpinImages(model, radius, imgW, minNeighbors)
% Computer spin images
%
% model - N x 3 matrix of points
% radius - radius of spin image
% imgW - number of bins
% minNeighbors - minimum number of neighbors before returning a valid (non-empty) spin image

imgH = imgW/2;
N = size(model,1);
[~,~ ,root] = kdtree(model, []);

spinImgs = zeros(2*imgH,imgW,N);
neighborRadius = radius * sqrt(2); % neighbor search radius has to be larger because the spin image is cylindrical

% loop over points
for i=1:N
   %[ i N]
   pt = model(i,:);
   %pt = model(:,i)';
   spinImg = spinImgs(:,:,i);
   
   % calculate neighbors of current point
   neighbors = kdrangequery(root,pt,neighborRadius - 1e-7);

   if size(neighbors,1) >= minNeighbors
      % first we compute the normal vector
      % compute PCA
      %coeff = princomp(neighbors);
      
      cov_mat = (1/size(neighbors,1))*(neighbors')*(neighbors);
      [u,~,~] = svd(cov_mat);
       u_reduce = u(:,1:3);
      coeff = transpose(u_reduce)*neighbors;
      
      % third component is surface normal
      normal = coeff(:,3);
      if dot(normal, pt) < 0
         normal = -normal;
      end

      % now we compute the spin image
      nn = length(neighbors);
      diffs = (neighbors - repmat(pt,nn,1))./radius;
      lens = sqrt(dot(diffs',diffs'))';

      % y-coord is dot prod between normal and vector to neighbor
      beta = dot(repmat(normal',nn,1),diffs,2);
      
      % x-coord is distance of the neighbor to the normal line
      alpha = sqrt(lens.^2 - beta.^2);

      % only add points if they are actually in the spin image
      alph_beta = [alpha beta];
      alph_beta = alph_beta(abs(alpha) < 1 & abs(beta) < 1,:);
      nPts = length(alph_beta);
      alpha = alph_beta(:,1); beta = alph_beta(:,2);
      xInds = round(alpha.*(imgW-1))+1;
      yInds = imgH + round(beta.*(imgH-1))+1;

      if(nnz(xInds < imgW & yInds < 2*imgH) == 0)
          disp(pt);
         disp('error computing spin image!');
      else
         inds = sub2ind(size(spinImg),xInds,yInds);
         for j=1:length(inds)
            spinImg(inds(j)) = spinImg(inds(j)) + 1;
         end
      end 
      
      % if only 1 bin is occupied, then this corresponds to the query point
      % --> neighborhood is too sparse, i.e. no spin image
      if(nnz(spinImg >= 1) == 1)
%          spinImg = zeros(2*imgH,imgW); Removed zeros matrix for too
%          sparse data... we can adjust the threshold for determining how
%          many minimum points are required to determine sparseness
      else
         % normalize spin image
         spinImg = spinImg./nPts;
         spinImgs(:,:,i) = spinImg;  % here i  will be count only spin images which are not too sparse jst like idx you asked for..KU
      end
      
   else
      disp('not enough neighbors!');
      
   end
end

% clear the kd tree
kdtree([],[],root);



 