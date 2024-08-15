function [UnrealOut, WorldOut] = RotateCamera(fovXY, PosXYZ, RotXYZ)

         % Calculate the projection of a camera with its currenct position
         % XYZ after rotating through RotXYZ degrees
         % CamPts = 5 x 3 Matrix of camera points with zero rotation
         % CamPts(1,:) = [x, y, z] location of center of camera 
         % CamPts(2,:) = [Ax, Ay, Az] location of camera plane point A
         % CamPts(3,:) = [Bx, By, Bz] location of camera plane point B
         % CamPts(4,:) = [Cx, Cy, Cz] location of camera plane point C
         % CamPts(5,:) = [Dx, Dy, Dz] location of camera plane point D
         % PosXYZ = 1 x 3 Matrix of current location of camera center
         % RotXYZ = 1 x 3 Matrix of current camera rotation
         % order = order of rotation + translation (1 <= order <= 12)
         load("SimEnvironment.mat");
         RadXYZ = RotXYZ*pi/180;
%          RotX = [1 0 0;0 cos(RadXYZ(1)) -sin(RadXYZ(1));0 sin(RadXYZ(1)) cos(RadXYZ(1))];
%          RotY = [cos(RadXYZ(2)) 0 sin(RadXYZ(2));0 1 0;-sin(RadXYZ(2)) 0 cos(RadXYZ(2))];
         RotZ = [cos(RadXYZ(3)) -sin(RadXYZ(3)) 0;sin(RadXYZ(3)) cos(RadXYZ(3)) 0;0 0 1];
         gdPlane = [0 0 0];
         h = PosXYZ - gdPlane;
         dx = h(3)*tan((fovXY(1)/2)*pi/180);
         dy = h(3)*tan((fovXY(2)/2)*pi/180);
         RectTf = (RotZ*[PosXYZ(1) + dx PosXYZ(2) + dy 0; PosXYZ(1) + dx PosXYZ(2) - dy 0;PosXYZ(1) - dx PosXYZ(2) - dy 0;PosXYZ(1) - dx PosXYZ(2) + dy 0]')';
         UnrealOut = RectTf;
         RectTf(:,3) = 1;
         out1 = RectTf * Env.UnrealToWorldTform;
         WorldOut = out1(:,1:3)./out1(:,3);




         % Set up rotation matrix around X
         


%          switch(order)
%              case 1  % Translation, Roll, Pitch, Yaw (Y, X, Z)
% 
%              case 2 % Translation, Roll, Yaw, Pitch (Y, Z, X)
% 
%              case 3 % Translation, Pitch, Roll, Yaw (X, Y, Z)
% 
%              case 4 % Translation, Pitch, Yaw, Roll (X, Z, Y)
% 
%              case 5 % Translation, Roll, Yaw, Pitch (Y, Z, X)
% 
%              case 6 % Translation, Roll, Pitch, Yaw (Y, X, Z)
% 
%              case 7 % Roll, Pitch, Yaw (Y, X, Z), Translation
% 
%              case 8 % 
%              case 9
%              case 10
%              case 11
%              case 12
%          end
% 





end