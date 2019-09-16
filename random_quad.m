function [x, y] = random_quad()
  % Start with 4 random points
  x = randn(1,4);
  y = randn(1,4);

  
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