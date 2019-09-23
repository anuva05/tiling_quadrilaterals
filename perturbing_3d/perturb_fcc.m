%perturb fcc 
clear
close all
%% works:
mask = boolean(zeros(64,64,64));
%centers of spheres
mask(32,32,1) = 1; %first face
mask(1,32,1)=1
mask(64,32,1) = 1
mask(32,32,64) = 1;  %last face
mask(1,32,64)=1
mask(64,32,64) = 1

mask(16,1,1) = 1
mask(48,1,1) = 1

mask(16,64,1) = 1
mask(48,64,1) = 1

mask(16,1,64) = 1
mask(48,1,64) = 1

mask(16,64,64) = 1
mask(48,64,64) = 1


dt = bwdist(mask);
ws = watershed(dt);
figure
imagesc(ws(:,:,1))
figure

isosurface(ws,0)


%% to perturb (but only perturbs the sizes of cubes..)
[xc yc zc] = ind2sub(size(mask),find(mask==1))

for p = 1:length(xc)
    %swap with slightly pertubed point
    pert1 = randi(10);
    pert2 = randi(10); %use if needed
    pert3  = randi(3); %use if needed
    center= [xc(p) yc(p) zc(p)];
    perturbed_center= [xc(p)+pert1 yc(p)+pert2 zc(p)];
    
    temp = mask(perturbed_center);
    mask(perturbed_center) = mask(center);
    mask(center) = temp;
end


dt = bwdist(mask);
ws = watershed(dt);
figure
imagesc(ws(:,:,1))


%to get vertices 
[xc yc zc] = ind2sub(size(mask),find(mask==1));
 [v, c] = voronoin([xc,yc,zc]);