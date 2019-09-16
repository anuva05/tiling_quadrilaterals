%perturb each cube in a tessellation of cubes by moving the voronoi center
%of the cubic cell a little bit
% this is implemented using the watershed algorithm 
clear

%% try out using voronoiDiagram, did not work well 
% X= randi(100,[ 10 10 10]);
% Y= randi(100,[ 10 10 10]);
% Z= randi(100,[ 10 10 10]);
% %[ X Y Z] = meshgrid(50:5:100);
% %DT=delaunayTriangulation([X(:) Y(:) Z(:)]);
% %[v,r]= voronoiDiagram(DT);
% [V,R] = voronoin([X(:) Y(:) Z(:)]);
% 
% %FOR some cell
% XR10 = V(R{2},:);
% K = convhull(XR10(2:end,:));
% defaultFaceColor  = [0.6875 0.8750 0.8984];
% trisurf(K, XR10(:,1) ,XR10(:,2) ,XR10(:,3) , ...
%         'FaceColor', defaultFaceColor, 'FaceAlpha',0.8)
% title('3-D Voronoi Region')

%% works:
mask = zeros(10,10,10);
mask(2:4:end, 2:4:end, 2:4:end) = 1;
dt = bwdist(mask);
ws = watershed(dt);
figure
imagesc(ws(:,:,1))
figure

isosurface(ws,0)


%% to perturb (but only perturbs the sizes of cubes..)
mask = zeros([50 50 50]);
seqn = 5:10:50;
% perturb1 = randn([ 1, length(seqn)]);
% seqn1 = ceil(seqn+perturb1);
% 
% perturb2 = randn([ 1, length(seqn)]);
% seqn2 = ceil(seqn+perturb2);
% 
% perturb3 = randn([ 1, length(seqn)]);
% seqn3 = ceil(seqn+perturb3);
% mask(seqn1,seqn2,seqn3) = 1;


for i= seqn
    for j=seqn
        for k=seqn
            
            p1 = randn; %one is perturbed more
            p2 = rand;
            p3 = rand;
            
            mask(ceil(i+p1), ceil(j+p2), ceil(k+p3))= 1;
            
        end
    end
end

            


dt = bwdist(mask);
ws = watershed(dt);
figure
imagesc(ws(:,:,5))