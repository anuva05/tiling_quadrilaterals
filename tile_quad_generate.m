%just runs given example
clear
rng default
x = randn(1,4);
y = randn(1,4);
cols = get(gca,'ColorOrder');
patch('XData',x,'YData',y,'FaceColor',cols(1,:))

rng(1913)
[x,y] = random_quad;

cla
axis equal
patch('XData',x,'YData',y,'FaceColor',cols(1,:))

% Points in the convenient form for transforming
pts = [x; y; ones(1,4)];

% Matrix which rotates by 180 degrees
rotmat = [-1  0 0; ...
           0 -1 0; ...
           0  0 1];
% 
% % The center of the first edge
% c = pts(:,1)/2 + pts(:,2)/2;
% 
% % Rotate by 180, and translate into place
% offset = rotmat*c - c;
% xlatmat = [1 0 offset(1); ...
%            0 1 offset(2); ...
%            0 0         1];
% p2 = rotmat*xlatmat*pts;
% 
% % and draw
% patch('XData',p2(1,:),'YData',p2(2,:),'FaceColor',cols(2,:))
% cm = line(c(1),c(2),'Color','black','Marker','o','MarkerSize',12);
% 
% c = pts(:,2)/2 + pts(:,3)/2;
% offset = rotmat*c - c;
% xlatmat = [1 0 offset(1); ...
%            0 1 offset(2); ...
%            0 0         1];
% p2 = rotmat*xlatmat*pts;
% patch('XData',p2(1,:),'YData',p2(2,:),'FaceColor',cols(3,:))
% delete(cm)
% cm = line(c(1),c(2),'Color','black','Marker','o','MarkerSize',12);
% c = pts(:,3)/2 + pts(:,4)/2;
% offset = rotmat*c - c;
% xlatmat = [1 0 offset(1); ...
%            0 1 offset(2); ...
%            0 0         1];
% p2 = rotmat*xlatmat*pts;
% patch('XData',p2(1,:),'YData',p2(2,:),'FaceColor',cols(4,:))
% delete(cm)
% cm = line(c(1),c(2),'Color','black','Marker','o','MarkerSize',12);
% 
% c = pts(:,4)/2 + pts(:,1)/2;
% offset = rotmat*c - c;
% xlatmat = [1 0 offset(1); ...
%            0 1 offset(2); ...
%            0 0         1];
% p2 = rotmat*xlatmat*pts;
% patch('XData',p2(1,:),'YData',p2(2,:),'FaceColor',cols(5,:))
% delete(cm)
% cm = line(c(1),c(2),'Color','black','Marker','o','MarkerSize',12);
% 
% % Rotate around the first side again
% c1 = pts(:,1)/2 + pts(:,2)/2;
% offset = rotmat*c1 - c1;
% xlatmat = [1 0 offset(1); ...
%            0 1 offset(2); ...
%            0 0         1];
% p2 = rotmat*xlatmat*pts;
% 
% % And then rotate that around the second side of the result.
% c2 = p2(:,2)/2 + p2(:,3)/2;
% offset = rotmat*c2 - c2;
% xlatmat = [1 0 offset(1); ...
%            0 1 offset(2); ...
%            0 0         1];
% p3 = rotmat*xlatmat*p2;
% 
% delete(cm)
% patch('XData',p3(1,:),'YData',p3(2,:),'FaceColor',cols(6,:))
% cm = line([c1(1) c2(1)],[c1(2) c2(2)],'Color','black','LineStyle','none','Marker','o','MarkerSize',12);

%% 
%%%%%%%%%%%%%%% large tiling %%%%%%%%%%%%%%%%%%%%%%%%%%%%

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
for i=-7:7
    for j=-5:5
        ci = mod(3*j+2*i,5);
        h = patch('XData',xdata' + i*uvec(1) + j*vvec(1),'YData',ydata' + i*uvec(2) + j*vvec(2));
        h.FaceVertexCData = cols(ci+(1:2),:);
        h.FaceColor = 'flat';
    end
end

