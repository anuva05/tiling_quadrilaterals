%function stellatedRhomboDodecahedron2
%Rhombododecahedron
fac = 4; %scales the side
vert = fac*[0 0 2;
        1 -1 1;
        1 1 1;
        -1 1 1;
        -1 -1 1;
        2 0 0;
        0 2 0;
        -2 0 0;
        0 -2 0;
        1 -1 -1;
        1 1 -1;
        -1 1 -1;
        -1 -1 -1;
        0 0 -2];
    
% try perturbation
perturb =[ randi(3), randi(3), randi(3)];

vert(6,:) = vert(6,:) + perturb; 

% 


face=[2     1     3     6
     9     5     1     2
     3     1     4     7
     4     1     5     8
     9     2     6    10
     6     3     7    11
     7     4     8    12
     8     5     9    13
    10     6    11    14
    14    11     7    12
    14    12     8    13
    13     9    10    14 ];

load stellaRhombicDodecaData   
colors=hsv(12);
ind=[1];
%ind=[6 7 8 9];
%ind=[4 5 10 11 12 13];
%ind=[2 3 4 5 14 15 16 17];


for n=1:length(face)
    v=vert(face(n,:),:);
    center=mean(v)%center of each face


    R=v(1,:)-center;
    R=R/sqrt(sum(R.^2));
    S=cross(R,center);
    S=S/sqrt(sum(S.^2));
  
    for m=1:length(ind)
        [faceTheta,faceR]=cart2pol(fac*facetMapVert{ind(m)}(:,1),fac*facetMapVert{ind(m)}(:,2));%theta(facetIndex(:))-deg2rad(18);
        faceTheta=faceTheta+offSetAngle(n);
        
        qx=center(1)+faceR.*cos(faceTheta).*R(1)+faceR.*sin(faceTheta).*S(1);
        qy=center(2)+faceR.*cos(faceTheta).*R(2)+faceR.*sin(faceTheta).*S(2);
        qz=center(3)+faceR.*cos(faceTheta).*R(3)+faceR.*sin(faceTheta).*S(3);

     patch('vertices',[qx qy qz],'faces',facetMapFace{ind(m)},'facecolor',colors(n,:));
         hold on
         
    % scatter3(2,2,0,20,20)
     xlabel('x')
     ylabel('y')
     zlabel('z')
         % patch('vertices',[qx+2 qy qz],'faces',facetMapFace{ind(m)},'facecolor',colors(n,:));
      % fill3(vert(:,1),vert(:,2),vert(:,3),1)
        
    end
end

%patch('faces',face,'vertices',vert,'facecolor','y');
set(gcf,'renderer','zbuffer');
axis equal
view(3)