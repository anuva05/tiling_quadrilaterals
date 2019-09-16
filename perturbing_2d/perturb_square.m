function [x, y] = perturb_square(x_corner, y_corner, side)
%% given the corner location and side of a square, this function returns
% a perturbed version of the square. this is used to create a tesselation


% Start with 4 regular vertices points
  x = [ x_corner, x_corner, x_corner+side, x_corner+side];
  y = [y_corner, y_corner+side, y_corner, y_corner+side];

%pick vertex to perturb
to_perturb= 3;

%randomly pick one index
x_new = randi([-5 5]);
y_new = randi([-5 5]);


x(to_perturb) = x(to_perturb) + x_new;
y(to_perturb) = y(to_perturb) + y_new;

% now use this to generate tiling

  % Triangulate them
  t = delaunayTriangulation(x',y');
  % If we found 3 triangles, throw one away
  if size(t,1) > 2
    t = triangulation(t.ConnectivityList(1:2,:),x',y');
  end
  % Return the points in the order of the boundary
  bound = freeBoundary(t);
  bound = bound(:,1);
  x = x(bound);
  y = y(bound);