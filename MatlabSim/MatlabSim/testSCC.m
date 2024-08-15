%% SCC graphics
% longMin = -75;
% longMax = -70;
% latMin = 44;
% latMax = 46;
% p = plot([],[])
% grid("on")
% % xlim([longMin,longMax])
% % ylim([latMin, latMax])
% h = gcf;
% % h.MenuBar = "none";
% % h.ToolBar = "none";
% h.WindowState = 'fullscreen';
% ax = gca;
% %ax.XTick = [1 2 3 4]
% ax.XTickLabel = {'A','B','C','D'}
% A_Grid = GeoGrid;
% A_Grid.GridIndex = 00;
% A_Grid.MinimumLat = 48;
% A_Grid.MaximumLat = 48.1;
% A_Grid.MinimumLong = -69.6;
% A_Grid.MaximumLong = -69.5;
% Lats = [49;49;49;49;49;49;49];
% Longs = [-68.5;-68.33;-68.17;-67.96;-67.75;-67.5;-67.1];
% %[A_Grid.LatGrid,A_Grid.LongGrid]=A_Grid.GenerateLatLongGrid(A_Grid,A_Grid.MinimumLat,A_Grid.MaximumLat,A_Grid.MinimumLong,A_Grid.MaximumLong);
% geoplot(Lats, Longs,'*')
% 
% 
% OriginA = Harbour;
% OriginA.Latitude = 48.0;
% OriginA.Longitude = -63.0001;
% 
% OriginB = Harbour;
% OriginB.Latitude = 48.0;
% OriginB.Longitude = -63.0002;
% 
% OriginC = Harbour;
% OriginC.Latitude = 50.0;
% OriginC.Longitude = -66.0;
% 
% OriginD = Harbour;
% OriginD.Latitude = 50.0;
% OriginD.Longitude = -76.0;
% 
% portA = Harbour;
% portB = Harbour;
% portA.Latitude = 48.0000;
% portA.Longitude = -63.0000;
% portB.Latitude = 48.0000;
% portB.Longitude = -63.0000;
% wgs84 = wgs84Ellipsoid("m");
% [d12,az12] = distance(Lats(1),Longs(1),Lats(2),Longs(2),wgs84);
% [d43,az43] = distance(Lats(4),Longs(4),Lats(3),Longs(3),wgs84);
% [d37,az37] = distance(Lats(3),Longs(3),Lats(7),Longs(7),wgs84);
% [dBC,azBC] = distance(OriginB.Latitude,OriginB.Longitude,OriginC.Latitude,OriginC.Longitude,wgs84);
% [dCD,azCD] = distance(OriginC.Latitude,OriginC.Longitude,OriginD.Latitude,OriginD.Longitude,wgs84);
% [dDA,azDA] = distance(OriginD.Latitude,OriginD.Longitude,OriginA.Latitude,OriginA.Longitude,wgs84);
% 
% Reg1 = [48 -69.6;48 -69.5;48.1 -69.5;48.1 -69.6];
% Reg2 = [48.1 -69.6;48.1 -69.5;48.1 -69.35;48.16 -69.35;48.16 -69.5;48.16 -69.6];
% Reg3 = [];
% index = [1;2;3;4;5;6;7;8;9;10;11;12;13;14;15;16;17;18;19;20;21;22;23;24;25;26;27;28;29;30;31;32;33;34;35;36;37;38;39;40;41;42;43;44;45;46;47;48;49;50;51;52;53;54;55;56;57;58;59;60;61;62];
% Lats = [48;48;48.1;48.1;48.16;48.16;48.1;48.16;48.2;48.16;48.2;48.25;48.25;48.33;48.33;48.33;48.33;48.42;48.42;48.42;48.5;48.5;48.5;
% 48.5;48.58;48.58;48.58;48.58;48.67;48.67;48.67;48.75;48.75;48.75;48.75;48.83;48.83;48.83;48.83;48.92;48.92;49;49;49;49;49.17;49.17;
% 49.17;49.3;49.3;49.3;49.3;49.5;49.5;49.75;49.75;49.75;50;50;50;50.2;50.2];
% 
% Longs = [-69.6;-69.5;-69.5;-69.6;-69.5;-69.6;-69.35;-69.35;-69.5;-69.2;-69.2;-69.5;-69.35;-69.35;-69.2;-69.25;-68.95;-69.25;-68.95;-68.67;
% -69.25;-69.08;-68.67;-68.5;-69.08;-68.95;-68.5;-68.33;-68.95;-68.33;-68.17;-68.95;-68.83;-68.17;-67.95;-68.83;-68.5;-67.95;-67.75;-68.5;
% -67.75;-68.5;-68.17;-67.75;-67.1;-68.17;-67.33;-66.5;-67.33;-66.5;-64.7;-67.1;-67.1;-64.7;-67.1;-66.8;-64.7;-66.8;-65.9;-64.7;-65.9;-64.7];
% 
% 
% vertices = [1 2 3 4;4 7 8 6;5 11 12 10;10 16 17 13;14 18 22 19;1 23 27 24;24 29 35 30;1 36 41 37;
% 
%     38 42 47 43;43 48 54 49;50 55 61 56;58 62 67 63;63 67 73 69;71 75 80 76;80 82 85 83;83 88 93 89;89 93 98 94;1 98 103 99;101 103 106 104];
% 
% vert = [1 2 3 4];
p = [48	-69.6;
48	-69.5;
48.1	-69.5;
48.1	-69.6;
48.1	-69.6;
48.1	-69.35;
48.16	-69.35;
48.16	-69.6;
48.16	-69.5;
48.16	-69.2;
48.2	-69.2;
48.2	-69.5;
48.2	-69.5;
48.2	-69.13;
48.25	-69.13;
48.25	-69.5;
48.25	-69.35;
48.25	-69.03;
48.33	-69.03;
48.33	-69.35;
48.33	-69.31;
48.33	-68.95;
48.42	-68.95;
48.42	-69.31;
48.42	-69.25;
48.42	-68.7;
48.5	-68.7;
48.5	-69.25;
48.5	-69.08;
48.5	-68.6;
48.58	-68.6;
48.58	-69.08;
48.58	-69;
48.58	-68.4;
48.67	-68.4;
48.67	-69;
48.67	-68.9;
48.67	-68.2;
48.75	-68.2;
48.75	-68.9;
48.75	-68.83;
48.75	-68;
48.83	-68;
48.83	-68.83;
48.83	-68.5;
48.83	-67.75;
48.92	-67.75;
48.92	-68.5;
48.92	-68.2;
48.92	-67.3;
49	-67.3;
49	-68.2;
49	-68.15;
49	-67.25;
49.17	-67.25;
49.17	-68.15;
49.17	-67.5;
49.17	-66.5;
49.3	-66.5;
49.3	-67.5;
49.3	-67.1;
49.3	-64.7;
49.5	-64.7;
49.5	-67.1;
49.5	-67.1;
49.5	-64.7;
49.75	-64.7;
49.75	-67.1;
49.75	-66.8;
49.75	-64.7;
50	-64.7;
50	-66.8];

geoplot(p(:,1), p(:,2),'*')
uu = unique(p,'rows');
origin = [48.67 -68.4];

dist = zeros(size(uu,1),6);
len = size(uu,1);
wgs84 = wgs84Ellipsoid("m");
for i = 1:len 
    la1 = uu(i,1);   % latitude
    lo1 = uu(i,2);   % longitude
    % latitude distance: keep longitude constant
    [dY,azY] = distance(origin(1),origin(2),la1,origin(2),wgs84);
    [dX,azX] = distance(la1,origin(2),la1,lo1,wgs84);
    dist(i,1:4) = [la1 lo1 dX dY]; 
    if lo1 >= origin(2)
        dist(i,5) = dX;
    else
        dist(i,5) = -dX;
    end
    if la1 > origin(1)
        dist(i,6) = -dY;
    else
        dist(i,6) = dY;
    end
end

testOutRaw = zeros(size(dist,1),7);
testOut = testOutRaw;
tform = estimateGeometricTransform2D(dist(:,1:2),dist(:,5:6),"projective");
for i = 1:size(dist, 1)
    x = [dist(i,1:2) 1];
    out = x*tform.T;
    testOutRaw(i,:) = [uu(i,:), out(1) out(2) out(3) dist(i,5:6)];
    testOut(i,:) = [uu(i,:), out(1)/out(3) out(2)/out(3) out(3)/out(3) dist(i,5:6)];
end

X = [testOut(35,5) testOut(35,6) -19924.000000 7691.000000;
    testOut(52,5) testOut(52,6) -1271.000000, -1044.000000;
    testOut(65,5) testOut(65,6) 41842.000000 -21333.000000;
    testOut(3,5) testOut(3,6) -39312.000000 23869.000000];

dXw = abs(X(:,1:2)-X(1,1:2));
dXu = abs(X(:,3:4)-X(1,3:4));
S = dXw(2:4,:)./dXu(2:4,:);
Smean = mean(S);
uPositions = zeros(size(uu,1),3);
uPositions(:,1) = (testOut(:,3)-testOut(35,3))/Smean(1) + X(1,3);
uPositions(:,2) = (testOut(:,4)-testOut(35,4))/Smean(2) + X(1,4);




% +49.00,-67.25(X=-1271.000000,Y=-1044.000000,Z=0.000000)
% +48.67,-68.40(X=-19924.000000,Y=7691.000000,Z=1572.000000)
% +49.75,-64.70(X=41842.000000,Y=-21333.000000,Z=0.000000)
% +48.10,-69.60(X=-39312.000000,Y=23869.000000,Z=0.000000)

% calculate distance to latitude
% for i = 1:
% for i = 1:size(vert,1)
%     la = Lats(vert(i,:));
%     lo = Longs(vertices(i,:));
%     geoplot(Lats, Longs,'*')
%     hold on
% end

% StLawrenceCoords;
% % la = 48;
% % lo = -69.5;
% geoplot(Lats,Longs,'*', 'color','k')
% dAB = dAB;
% dBC = dBC*100;
% dCD = dCD*100;
% dDA = dDA*100;

% hold on
% geoplot([OriginC.Latitude OriginD.Latitude], [OriginC.Longitude OriginD.Longitude],'*')

% pos = [2 4 2 2]; 
% rectangle('Position',pos,'Curvature',[1 1], 'FaceColor',[1,0,0],'EdgeColor',[0,1,0])
% axis equal

% theta = 0:0.01:pi;
% for i = 1:r
%     x = cx+round(i*cos(theta));
%     y = cy+round(i*sin(theta));
%     im(y,x) = 1;
% end
% figure,imshow(im)
% longs = -70:.001:-69;
% lats = 48:.001:48.001;
% []
% longs = longs';
% lats = lats';
% dists = zeros(2,length(longs));
% lat1 = 48;
% long1 = longs(1);
% wgs84 = wgs84Ellipsoid("m");