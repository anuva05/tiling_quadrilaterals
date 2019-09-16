%regular cube
clear
vert = [0 0 0;1 0 0;1 1 0;0 1 0;0 0 1;1 0 1;1 1 1;0 1 1];
fac = [1 2 6 5;2 3 7 6;3 4 8 7;4 1 5 8;1 2 3 4;5 6 7 8];
patch('Vertices',vert,'Faces',fac,...
      'FaceVertexCData',hsv(6),'FaceColor','flat')
  
  
  %perturbed cube
  vert = 5*vert;
  perturbation = [randi([-2 2]) randi([-2 2]) randi([-2 2]) ];
  
  vert(4,:) =vert(4,:) + perturbation; 
  fac = [1 2 6 5;2 3 7 6;3 4 8 7;4 1 5 8;1 2 3 4;5 6 7 8];
patch('Vertices',vert,'Faces',fac,...
      'FaceVertexCData',hsv(6),'FaceColor','flat')
  

  % tesselate by rotating and repeating
  