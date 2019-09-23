
%% adds random noise to perturb a grid of regular squares. voronoi map
%% gives the tessellation of the new shapes

[x y] = meshgrid(1:10:100);
voronoi(x,y) %regular grid

%add random perturbation
[xrand] = randn(10);
x=x+xrand;
%see perturbed grid
voronoi(x,y)

%get vertices to convert this to an image/microstructure
[vx vy] = voronoi(x,y);

%not sure if right..
[vx vy] = voronoi(x(:),y(:));
vx(vx<0) = 0;
vx(vx>100) = 100;
vy(vy<0) = 0;
vy(vy>100) = 100;
scatter(vx(1,:),vy(1,:))
hold on
scatter(vx(2,:),vy(2,:))



mask = zeros([100,100]);

x(x<=1)= 1;
x(x>100)=100;
mask = voronoi2mask(x,y,[100 100]);
figure
imagesc(mask)


figure
voronoi(x(:),y(:))
hold on
scatter(vx(2,:),vy(2,:))