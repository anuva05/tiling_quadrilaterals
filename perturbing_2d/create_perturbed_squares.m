%% Creates 2d tesselation of quadrilateral as explained in
% tiling_quadrilaterals.mlx. Uses function random_quad.m
% the seed used, rng(1970),fixes the shape of the quadrilateral 
% during re-runs of this code. Currently, an approx trapezoidal
% shape is used

close all
clear


%% generate perturbed square
cols = get(gca,'ColorOrder');
[x,y] = perturb_square(10,20,30);
cla
axis equal
patch('XData',x,'YData',y,'FaceColor',cols(1,:))




%% tesselate
% Points in the convenient form for transforming
pts = [x; y; ones(1,4)];

% Matrix which rotates by 180 degrees
rotmat = [-1  0 0; ...
           0 -1 0; ...
           0  0 1];

% The center of the first edge
c = pts(:,1)/2 + pts(:,2)/2;


%% %%%%%%%%%%%%%% large tiling %%%%%%%%%%%%%%%%%%%%%%%%%%%%

cla
axis off
set(gca,'Position',[0 0 1 1])
xdata = pts(1,:);
ydata = pts(2,:);

c = [(pts(1:2,1) + pts(1:2,2))/2; 1];
offset = rotmat*c - c;
xlatmat = [1 0 offset(1); ...
           0 1 offset(2); ...
           0 0         1];
p2 = rotmat*xlatmat*pts;
xdata(2,:) = p2(1,:);
ydata(2,:) = p2(2,:);

dark = [.75 .75 .75];
light = [.875 .875 .875];
patch('XData',xdata','YData',ydata','FaceColor',dark)
 uvec = pts(:,1) - pts(:,3);
 vvec = pts(:,2) - pts(:,4);
cla
patch('XData',xdata'+uvec(1),'YData',ydata'+uvec(2),'FaceColor',light,'EdgeColor',dark)
patch('XData',xdata'+vvec(1),'YData',ydata'+vvec(2),'FaceColor',light,'EdgeColor',dark)
patch('XData',xdata','YData',ydata','FaceColor',light)
line(pts(1,1) + [0 uvec(1)],pts(2,1) + [0 uvec(2)],'Color',cols(1,:),'LineWidth',2)
line(pts(1,1) + [0 vvec(1)],pts(2,1) + [0 vvec(2)],'Color',cols(2,:),'LineWidth',2)
cla
for i=-7:7
    for j=-5:5
        ci = mod(3*j+2*i,5);
        h = patch('XData',xdata' + i*uvec(1) + j*vvec(1),'YData',ydata' + i*uvec(2) + j*vvec(2));
        h.FaceVertexCData = cols(ci+(1:2),:);
        h.FaceColor = 'flat';
    end
end

%% In a given mesh grid, create mask using 'inpolygon'. this 
%% makes it usable as a microstructure. current data is 2D only.
[Xg Yg] =meshgrid(-50:50);
mask= zeros(size(Xg));
xv=[]
yv=[]
count=1;
for i=-3:3
    for j=-3:3
        ci = mod(3*j+2*i,5);
        xv= xdata' + i*uvec(1) + j*vvec(1);
        yv =ydata' + i*uvec(2) + j*vvec(2);
       
        
            for a=1:length(Xg)
                for b=1:length(Yg)
                    [in,on] = inpolygon(Xg(a,b),Yg(a,b),xv(:,1)',yv(:,1)');
                   if in==1||on==1
                       mask(a,b)=count;
                   end
                 [in,on] = inpolygon(Xg(a,b),Yg(a,b),xv(:,2)',yv(:,2)');
                   if in==1||on==1
                       mask(a,b)=count+1;
                   end
                    
                end
            end
            count= count+2;
            
           
    end
end

figure
imagesc(mask)
