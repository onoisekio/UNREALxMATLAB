% a = out.pCloud.Data(:,:,:,2304);
% figure,pcshow(a)
% xlabel('x')
% 
% ylabel('y')
% zlabel('z')
% %out.Rotation.Data(:,:,100)
% Location = zeros(1,3);
% for i = 1:size(out.CamLocation.Data,3)
%     Location(i,:) = out.CamLocation.Data(:,:,i);
% end
% 
% i = 1;
% im = out.image.Data(:,:,i);
% %im = rgb2gray(im);
% imshow(im)
% i = i + 1;
% 
% imshow(im)
% Orientation = reshape(out.CamRotation.Data,[size(out.CamRotation.Data,3),size(out.CamRotation.Data,2)*size(out.CamRotation.Data,1)]);
% 
% global fov;
% RotZ = [cos(block.InputPort(3).Data(3)) -sin(block.InputPort(3).Data(3)) 0;sin(block.InputPort(3).Data(3)) cos(block.InputPort(3).Data(3)) 0;0 0 1];
% gdPlane = [0 0 0];
% h = block.InputPort(2).Data - gdPlane;
% dx = h(3)*tan((fov(1)/2)*pi/180);
% dy = h(3)*tan((fov(2)/2)*pi/180);
% RectTf = (RotZ*[block.InputPort(2).Data(1) + dx block.InputPort(2).Data(2) + dy 0; block.InputPort(2).Data(1) + dx block.InputPort(2).Data(2) - dy 0;block.InputPort(2).Data(1) - dx block.InputPort(2).Data(2) - dy 0;block.InputPort(2).Data(1) - dx block.InputPort(2).Data(2) + dy 0]')';
% RectTf(:,3) = 1;
% out1 = double(RectTf * block.InputPort(1).Data);
% WorldOut = out1(:,1:3)./out1(:,3);
% block.OutputPort(1).Data = WorldOut(:,1:2);  %[Long Lat] 


% %% Smoothening out the river segments (1) - Working from Unreal to Geo%%
% load('SimEnvironment.mat')
% pts = Env.RiverRegions;
% len = size(pts,1);
% LeftPts = zeros(1,2);
% RightPts = zeros(1,2);
% l = 1;
% r = 1;
% for i = 1:len
%     LeftPts(l,:) = [Env.UnrealRiverPts(pts(i,1),1)-50 Env.UnrealRiverPts(pts(i,1),2)];
%     l = l + 1;
%     LeftPts(l,:) = [Env.UnrealRiverPts(pts(i,4),1)-50 Env.UnrealRiverPts(pts(i,4),2)];
%     l = l + 1;
% 
%     RightPts(r,:) = [Env.UnrealRiverPts(pts(i,2),1)+50 Env.UnrealRiverPts(pts(i,2),2)];
%     r = r + 1;
%     RightPts(r,:) = [Env.UnrealRiverPts(pts(i,3),1)+50 Env.UnrealRiverPts(pts(i,3),2)];
%     r = r + 1;
% end
% 
% pl = polyfit(LeftPts(:,1),LeftPts(:,2),3);
% pr = polyfit(RightPts(:,1),RightPts(:,2),3);
% minx = min(LeftPts(:,1));
% maxx = max(LeftPts(:,1));
% xPolyL = minx:1:maxx;
% xPolyL = xPolyL';
% yPolyL = pl(1)*xPolyL.^3 + pl(2)*xPolyL.^2 + pl(3)*xPolyL + pl(4);
% 
% minx = min(RightPts(:,1));
% maxx = max(RightPts(:,1));
% xPolyR = minx:1:maxx;
% xPolyR = xPolyR';
% yPolyR = pr(1)*xPolyR.^3 + pr(2)*xPolyR.^2 + pr(3)*xPolyR + pr(4);
% 
% %Transform
% wrlL = [xPolyL yPolyL ones(length(xPolyL),1)]*Env.UnrealToWorldTform;
% wrlL = wrlL./wrlL(:,3);
% 
% wrlR = [xPolyR yPolyR ones(length(xPolyR),1)]*Env.UnrealToWorldTform;
% wrlR = wrlR./wrlR(:,3);
% 
% figure,
% geoplot(wrlR(:,2), wrlR(:,1))
% hold on
% geoplot(wrlL(:,2), wrlL(:,1))
% hold off
% 
% %plot
% figure,plot(LeftPts(:,1), LeftPts(:,2),'+-b')
% hold on
% plot(RightPts(:,1), RightPts(:,2),'+-b')
% plot(xPolyL,yPolyL,'.','color','r')
% plot(xPolyR,yPolyR,'.','color','m')
% hold off
% 
% %% Smoothening out the river segments %% 

% %% Expanding the smooth occupancy pixel boundary +/- 50px 
% load('SimEnvironment.mat','Env')
% shift = 50;
% l = 1;
% r = 1;
% lP = zeros(1,2);
% rP = zeros(1,2);
% [rows, cols] = size(Env.SmoothOccupancyMap);
% im = zeros(rows,cols);
% for i = 1:rows
%     start = 1;
%     stop = cols;
%     fStart = false;
%     j = 1;
%     while j <= cols && ~fStart
%         % look for the start
%         if Env.SmoothOccupancyMap(i,j) < .75
%             start = j;
%             fStart = true;
%             fStop = false;
%         end
%         j = j + 1;
%         % look for the stop
%         if fStart
%             while j <= cols && ~fStop
%                 if Env.SmoothOccupancyMap(i,j) >= 0.75
%                     stop = j - 1;
%                     fStop = true;
%                 end
%                 j = j + 1;
%             end
%             start = start - shift;
%             lP(l,:) = [i,start];
%             l = l + 1;
%             stop = stop + shift;
%             rP(r,:) = [i,stop+shift];
%             r = r + 1;
%             im(i,start) = 1;
%             im(i,stop) = 1;
%         end
%     end
% end
% figure,imshow(im)





%% Smoothening out the river segments (2) - Working from Geo to Unreal%%
% load('SimEnvironment.mat')
% 
% % load smooth boundary segments and transfrom from world to unreal
% % coordinates then to pixel coordinates
% load('LeftRiverGeoPts.mat')
% width = 900;
% height = 700;
% LeftPts = [path(:,2) path(:,1) ones(size(path,1),1)]*Env.WorldToUnrealTform;
% LeftPts = LeftPts./LeftPts(:,3);
% leftPtsPix = (Env.OccupancyPixelMapToUnrealTform*LeftPts' + [width;height])'; % pixels
% 
% 
% load('RightRiverGeoPts.mat')
% RightPts = [path(:,2) path(:,1) ones(size(path,1),1)]*Env.WorldToUnrealTform;
% RightPts = RightPts./RightPts(:,3);
% rightPtsPix = (Env.OccupancyPixelMapToUnrealTform*RightPts' + [width;height])'; %pixels
% 
% 
% 
% pl = polyfit(leftPtsPix(:,1),leftPtsPix(:,2),3);
% pr = polyfit(rightPtsPix(:,1),rightPtsPix(:,2),3);
% c = 1:1:width;
% c = c';
% % minx = min(LeftPts(:,1));
% % maxx = max(LeftPts(:,1));
% % xPolyL = minx:1:maxx;
% % xPolyL = xPolyL';
% % yPolyL = pl(1)*xPolyL.^3 + pl(2)*xPolyL.^2 + pl(3)*xPolyL + pl(4);
% cL = round(pl(1)*c.^3 + pl(2)*c.^2 + pl(3)*c + pl(4));   %columns
% 
% % minx = min(RightPts(:,1));
% % maxx = max(RightPts(:,1));
% % xPolyR = minx:1:maxx;
% % xPolyR = xPolyR';
% % yPolyR = pr(1)*xPolyR.^3 + pr(2)*xPolyR.^2 + pr(3)*xPolyR + pr(4);
% cR = round(pr(1)*c.^3 + pr(2)*c.^2 + pr(3)*c + pr(4));   %columns

%Transform
% wrlL = [xPolyL yPolyL ones(length(xPolyL),1)]*Env.UnrealToWorldTform;
% wrlL = wrlL./wrlL(:,3);
% 
% wrlR = [xPolyR yPolyR ones(length(xPolyR),1)]*Env.UnrealToWorldTform;
% wrlR = wrlR./wrlR(:,3);
% im = zeros(height,width);
% k = [r,cL];
% for i = 1:size(k,1)
%     im(k(i,:)) = 1;
% end
% % im(r,cR) = 1;
% figure,imshow(im)


% geoplot(wrlR(:,2), wrlR(:,1))
% hold on
% geoplot(wrlL(:,2), wrlL(:,1))
% hold off
% 
% %plot
% figure,plot(LeftPts(:,1), LeftPts(:,2),'+-b')
% hold on
% plot(RightPts(:,1), RightPts(:,2),'+-b')
% plot(xPolyL,yPolyL,'.','color','r')
% plot(xPolyR,yPolyR,'.','color','m')
% hold off

%% Smoothening out the river segments %% 



%% Plots

% len = size(out.Translation.Data,3);
% Location = zeros(len,3);
% figure,
% for i = 1:len
%     Location(i,:) = out.Translation.Data(:,:,i);
%     plot(Location(i,1),Location(i,2),'*')
%     hold on
% end

% for i = 1:size(out.UnrealCoordinates.Data,3)
%     pts = out.UnrealCoordinates.Data(:,:,i);
%     plot([pts(:,1);pts(1,1)],[pts(:,2);pts(1,2)],'.-r');
% end

% for i = 2:size(out.WorldCoordinates.Data,3)
%     p = out.WorldCoordinates.Data(:,:,i);
%     shape = geopolyshape([p(4,1);p(3,1);p(2,1);p(1,1)],[p(4,2);p(3,2);p(2,2);p(1,2)]);
%     geoplot([p(4,1);p(3,1);p(2,1);p(1,1);p(4,1)],[p(4,2);p(3,2);p(2,2);p(1,2);p(4,2)]);
%     hold on
% end
 
%% Plots

%% Occupancy Map subsampling and Update %%
% OGridMaxX = 900;
% OGridMaxY = 700;
% dx = 0.2;
% px = 0.2*5;
% OGridX = 0:px:OGridMaxX-px;
% OGridX = OGridX';    % Subsampled occupancy grid horizontal coordinates
% OGridY = 0:px:OGridMaxY-px;
% OGridY = OGridY';    % Subsampled occupancy grid vertical coordinates
% 
% UGridX = Env.OccupancyGridToUnrealTform * [OGridX,zeros(length(OGridX),1),ones(length(OGridX),1)]';
% UGridX = UGridX(1,:)';  % Corresponding unreal grid horizontal coordinates
% UGridY = Env.OccupancyGridToUnrealTform * [zeros(length(OGridY),1),OGridY,ones(length(OGridY),1)]';
% UGridY = UGridY(2,:)';  % Corresponding unreal grid vertical coordinates
% 
% %UGridY = flipud(UGridY); % Flip up down to match with matlab indexing
% 
% values = zeros(length(UGridY),length(UGridX));
% indices = values;
% d = px/dx;    % horizontal and vertical step size
% k = 1;
% for i = 1:length(UGridX)
%     hStart = (i-1)*d+1;
%     hStop = i*d;
%     for j = 1:length(UGridY)
%         vStart = (j-1)*d+1;
%         vStop = j*d;
%         values(j,i) = mean(mean(Env.OccupancyMap(vStart:vStop,hStart:hStop)));
%         indices(j,i) = k;
%         k = k + 1;
%     end
% end

%% Occupancy Map Pixel properties %%
% load('SimEnvironment.mat','Env')
% [r, c] = size(Env.SmoothOccupancyMap);
% k = 1;
% 
% pixelConcInfo = struct('row',[],'col',[],'sum',0,'num',0,'avg',0);
% pixelHeightInfo = struct('row',[],'col',[],'sum',0,'num',0,'avg',0,'type',[],'multiplier',[]);
% 
% for i = 1:r
%     for j = 1:c 
%         if Env.SmoothOccupancyMap(i,j) == 0.001
%             pixelConcInfo(k,1).row = i;
%             pixelConcInfo(k,1).col = j;
%             pixelConcInfo(k,1).sum = 0;
%             pixelConcInfo(k,1).num = 0;
%             pixelConcInfo(k,1).avg = 0;
% 
%             pixelHeightInfo(k,1).row = i;
%             pixelHeightInfo(k,1).col = j;
%             pixelHeightInfo(k,1).sum = 0;
%             pixelHeightInfo(k,1).num = 0;
%             pixelHeightInfo(k,1).avg = 0;
%             pixelHeightInfo(k,1).type = [];
%             pixelHeightInfo(k,1).multiplier = [];
%             k = k + 1;
%         end
%     end
% end

%% Generate Hazard map colours from occupancyMap image to Real world
%% transform

% load('SimEnvironment.mat','Env')
% HazardMapShading =[]; % [Row Column Lat Long Red Green Blue]
% [row, col] = size(Env.SmoothOccupancyMap);
% p =1;
% for i = 1:row
%     zeromat = [];
%     k = 1;
%     for j = 1:col
%         if Env.SmoothOccupancyMap(i,j) == 0.001
%             zeromat(k,:) = [j,i,1];
%             k = k + 1;
%         end
%     end
%     if ~isempty(zeromat)
%         out1 = Env.OccupancyPixelMapToUnrealTform * zeromat';
%         out2 = [out1;ones(1,size(out1,2))]'*Env.UnrealToWorldTform;
%         out2(:,1) = out2(:,1)./out2(:,3);
%         out2(:,2) = out2(:,2)./out2(:,3);%long, lat
%     
%         HazardMapShading(p:p+k-2,1:4) = [zeromat(:,2),zeromat(:,1),out2(:,2),out2(:,1)];
%         HazardMapShading(p:p+k-2,5:7) = 0.5;
%         p = p + k-1;
%     end
% end
% % Segment a region and generate random ice pieces.
% iceWater = [0,1];  % 0 = water, 1 = ice
% sn = [-1,1];
% 
% A = [Env.UnrealRiverPts(Env.RiverRegions(1,1),1) Env.UnrealRiverPts(Env.RiverRegions(1,1),2)];  %[x, y]
% B = [Env.UnrealRiverPts(Env.RiverRegions(1,2),1) Env.UnrealRiverPts(Env.RiverRegions(1,2),2)];
% C = [Env.UnrealRiverPts(Env.RiverRegions(1,3),1) Env.UnrealRiverPts(Env.RiverRegions(1,3),2)];
% D = [Env.UnrealRiverPts(Env.RiverRegions(1,4),1) Env.UnrealRiverPts(Env.RiverRegions(1,4),2)];
% 
% maxx = max(A(1),B(1));
% minx = min(A(1),B(1));
% maxy = max(B(2),C(2));
% miny = min(B(2),C(2));
% wid = maxx -  minx;
% hei = maxy - miny;
% 
% nx = 0:0.01:0.1*wid;    % deviation added
% nx = nx';
% ny = 0:0.01:0.1*hei;    % deviation added
% ny = ny';
% ptsAB = zeros(10,2);
% ptsBC = ptsAB;
% ptsCD = ptsAB;
% ptsDA = ptsAB;
% 
% ptsAB(:,2) = linspace(miny,maxy,10);
% ptsAB(:,1) = minx;
% sns = sn(ceil(rand(10,1)*length(sn)));    % signs
% dx = sns'.*nx(ceil(rand(10,1)*length(nx)));
% ptsAB(:,1) = ptsAB(:,1) + dx;     % deviations
% 
% 
% ptsBC(:,1) = linspace(minx,maxx,10);
% ptsBC(:,2) = maxy;
% sns = sn(ceil(rand(10,1)*length(sn)));    % signs
% dy = sns'.*ny(ceil(rand(10,1)*length(ny)));
% ptsBC(:,2) = ptsBC(:,2) + dy;     % deviations
% 
% ptsCD(:,2) = linspace(maxy,miny,10);
% ptsCD(:,1) = maxx;
% sns = sn(ceil(rand(10,1)*length(sn)));    % signs
% dx = sns'.*nx(ceil(rand(10,1)*length(nx)));
% ptsCD(:,1) = ptsCD(:,1) + dx;     % deviations
% 
% ptsDA(:,1) = linspace(maxx,minx,10);
% ptsDA(:,2) = miny;
% dy = sns'.*ny(ceil(rand(10,1)*length(ny)));
% ptsDA(:,2) = ptsDA(:,2) + dy;     % deviations
% pts = [ptsAB(1:end-1,:);ptsBC(1:end-1,:);ptsCD(1:end-1,:);ptsDA(1:end-1,:)];
% 
% 
% % [Uout, Wout] = BlockSegmentation(width,height,minx,ymin,minD,UWTform)
% % ceil(rand(10,1)*length(divs))
% figure,
% sPlot = geoplot(HazardMapShading(:,3), HazardMapShading(:,4), '.','color',[0.5,0.5,0.5]);
% % dPlot = geoplot(dPts(1), dPts(2), 'o','MarkerFaceColor','r','MarkerEdgeColor','b','MarkerSize',14);
% geolimits([48 50],[-70 -67]);
% geobasemap colorterrain
% 
% figure,imshow(Env.SmoothOccupancyMap)
% figure,plot(pts(:,1),pts(:,2))

%% Generating uncertainties
% unc = [0 20 40 60 80;20 40 60 80 100];
% uncSize = size(unc,2);
% divs = 8;
% uncLow = zeros(divs,uncSize);
% uncHigh = uncLow;
% hazLevel = zeros(divs,1);
% p = 1;
% for i = 1:divs
%     k = 1;
%     grp = zeros(1,uncSize);
%     while k <= uncSize
%         x = ceil(rand(1,1)*uncSize);
%         found = 0;
%         j = 1;
%         while j <= uncSize && found == 0
%             if x == grp(j) && x ~= 0
%                 found = 1;
%             end
%             j = j + 1;
%         end
%         if found == 0
%             grp(k) = x;
%             k = k + 1;
%         end
%     end
%     uncLow(i,:) = unc(1,grp);
%     uncHigh(i,:) = unc(2,grp);
% end
%  x = ceil(rand(1,1)*4);

%  lat = [22.6827 22.6873];
% lon = [-114.0641 114.0704];
% geoplot(lat, lon)
% geobasemap('satellite')
% % Set up a callback for mouse clicks on the map
% set(gcf, 'WindowButtonDownFcn', @clickCallback);
% % Function to handle mouse clicks and draw polygons

%% Generating Hazard-Uncertainty Matrix and pairwise groupings
% Uncertainty = [0 .25 .5 .75;.25 .5 .75 1];  % [low;high]
% Hazard = [.333 .667 1];
% 
% HMatrix = zeros(size(Hazard,2),size(Uncertainty,2));
% ULowMatrix = HMatrix;     % lower uncertainty limit
% UHighMatrix = HMatrix;    % higher uncertainty limit
% 
% [r, c] = size(HMatrix);
% for i = 1:r
%     HMatrix(i,:) = Hazard(r-i+1);
%     ULowMatrix(i,:) = Uncertainty(1,:);
%     UHighMatrix(i,:) = Uncertainty(2,:);
% end
% HUMatrix = HMatrix.*UHighMatrix;
% HUMatrix_ID = zeros(r,c);
% k = 1;
% HU_Unrolled = zeros(r*c,2);
% for i = 1:r
%     p = r - i + 1;
%     for j = 1:c
%         HU_Unrolled(k,:) = [k HUMatrix(p,j)];
%         HUMatrix_ID(p,j) = k;
%         k = k + 1;
%     end
% end
% 
% UMatrix = zeros(r*c,3);
% 
% % Colour codes and uncertainty levels
% colours = [0 0 1;0 1 0;1 1 0;1 0 0];
% HUColours = zeros(r*c,4);
% k = 1;
% for i = 1:r
%     j = 1;
%     for k = (i-1)*c + 1:i*c
%         HUColours(k,1) = k;
%         UMatrix(k,1) = k;
%         HUColours(k,2:4) = colours(i,:);
%         UMatrix(k,2:3) = [ULowMatrix(i,j) UHighMatrix(i,j)];
%         j = j + 1;
%     end
% end
% % 
% % 
% % Generate the X pairings [i, j, score, color]
% HUPairings = zeros(nchoosek(r*c,2),14);
% HUPairings(:,1:2) = nchoosek(HU_Unrolled(:,1),2);
% HUPairings(:,3:4) = [HU_Unrolled(HUPairings(:,1),2), HU_Unrolled(HUPairings(:,2),2)];
% HUPairings(:,5:7) = HUColours(HUPairings(:,1),2:4);
% HUPairings(:,8:10) = HUColours(HUPairings(:,2),2:4);
% HUPairings(:,11:12) = UMatrix(HUPairings(:,1),2:3);
% HUPairings(:,13:14) = UMatrix(HUPairings(:,2),2:3);


% % Plot geomap
% ind = ceil(rand(1,1)*size(HUPairings,1));
% load('TestPairings.mat');
% load('TestShipPath1.mat');
% load('TestShipPath2.mat');
% load('TestTextCoord1.mat');
% load('TestTextCoord2.mat');
% patch1 = geopolyshape(path1(:,1),path1(:,2));
% patch2 = geopolyshape(path2(:,1),path2(:,2));
% col1 = HUPairings(ind,5:7);
% col2 = HUPairings(ind,8:10);
% text1 = strcat(num2str(HUPairings(ind,11)*100),' ', '-', ' ', num2str(HUPairings(ind,12)*100),' ','%');
% text2 = strcat(num2str(HUPairings(ind,13)*100),' ', '-', ' ', num2str(HUPairings(ind,14)*100),' ','%');
% 
% % c = zeros(size(path1,1),3);
% % c(:,1) = 1;
% % c(:,2) = 0;
% % c(:)
% % c(1:end,:) = [1,0,0]
% h = geoplot(patch1,'EdgeColor',[1 0 0],'ColorData',[1 0 0],'FaceAlpha',1)
% text(textcoords1(1,1),textcoords1(1,2),text1);
% hold on
% geoplot(patch2,Color=col2)
% text(textcoords2(1,1),textcoords2(1,2),text2);


% Save the 190 pairings to be used to generate the experiment conditions 
%% Region and Subregion Structures bearing invisible buttons
%i = 0;
% Region = struct('LeftSubregion',[],'RightSubregion',[]);
% LeftSubregion = struct('Latitudes',[],'Longitudes',[],'ButtonID',[],'HazardLevel',[],'UncertaintyLevel',[]);
% RightSubregion = struct('Latitudes',[],'Longitudes',[],'ButtonID',[],'HazardLevel',[],'UncertaintyLevel',[]);
% Regions = [];
% i = i + 1;
% 
% LeftSubregion.Latitudes = pathL(:,1);
% LeftSubregion.Longitudes = pathL(:,2);
% 
% RightSubregion.Latitudes = pathR(:,1);
% RightSubregion.Longitudes = pathR(:,2);
% 
% Region.LeftSubregion = LeftSubregion;
% Region.RightSubregion = RightSubregion;
% Regions(i,1) = Region;
% i = i + 1;
%% Generate unique random numbers from 1 to 66 for random pairings
% load('Run1.mat');
% p = 0;
% len = 66;% size(p,1);
% k = 1;
% i = 1;
% while k <= len
%     x = ceil(len*rand(1,1));
%     if k == 1
%         p(k,1) = x;
%         k = k + 1;
%     else
%         found = 0;
%         i = 1;
%         while found == 0 && i <= length(p)
%             if x == p(i)
%                 found = 1;
%             end
%             i = i + 1;
%         end
%         if found == 0
%             p(k,1) = x;
%             k = k + 1;
%         end
%     end
% end
% % HMatrix and UMatrix
% %VMatrix = reshape(HMatrix,3*4,1);
% VMatrix = [1;2;3;1;2;3;1;2;3;1;2;3];
% 
% for i = 1:size(Regions,1)
%     x = p(i);
%     % left and right indices
%     left = HUPairings(x,1);
%     right = HUPairings(x,2);
% 
%     leftU = UMatrix(left,2:3);
%     leftHaz = VMatrix(left);
% 
%     rightU = UMatrix(right,2:3);
%     rightHaz = VMatrix(right);
%     Regions(i).LeftSubregion.HazardLevel = leftHaz;
%     Regions(i).LeftSubregion.UncertaintyLevel = leftU;
%     Regions(i).RightSubregion.HazardLevel = rightHaz;
%     Regions(i).RightSubregion.UncertaintyLevel = rightU;
% end

%% Update Run Structures with Uncertainty Text and Colour fields 
load('Run3.mat');
for i = 1:size(Regions,1)
    Regions(i).LeftSubregion.Run = 3;
    Regions(i).RightSubregion.Run = 3;
    hLeft = Regions(i).LeftSubregion.HazardLevel;
    uLeft = Regions(i).LeftSubregion.UncertaintyLevel;

    hRight = Regions(i).RightSubregion.HazardLevel;
    uRight = Regions(i).RightSubregion.UncertaintyLevel;


    % set text position and orientation within block
    lat = Regions(i).LeftSubregion.Latitudes;
    lon = Regions(i).LeftSubregion.Longitudes;
    dLat = max(lat) - min(lat);
    dLon = max(lon) - min(lon);
    if dLon/dLat >= 1.5
        Regions(i).LeftSubregion.TextOrientation = 'Normal';
        Regions(i).RightSubregion.TextOrientation = 'Normal';
        
        %left text position
        Regions(i).LeftSubregion.TextPosition = [(max(lat) + min(lat))/2, (max(lon) + min(lon))/2];
        %right text position
        lat = Regions(i).RightSubregion.Latitudes;
        lon = Regions(i).RightSubregion.Longitudes;
        Regions(i).RightSubregion.TextPosition = [(max(lat) + min(lat))/2, (max(lon) + min(lon))/2];
    else
        Regions(i).LeftSubregion.TextOrientation = 'Flipped';
        Regions(i).RightSubregion.TextOrientation = 'Flipped';

        %left text position
        Regions(i).LeftSubregion.TextPosition = [(max(lat) + min(lat))/2, (max(lon) + min(lon))/2];
        %right text position
        lat = Regions(i).RightSubregion.Latitudes;
        lon = Regions(i).RightSubregion.Longitudes;
        Regions(i).RightSubregion.TextPosition = [(max(lat) + min(lat))/2, (max(lon) + min(lon))/2];
    end
    
    % right region
    

    % Left Subregion
    if uLeft(1) >= 0 && uLeft(2) <= .25
        Regions(i).LeftSubregion.UncertaintyText = 'U25';%'U0-25';
        if hLeft == 1   % lowest hazard
            Regions(i).LeftSubregion.HazardColour = [0 1 0];  %green
        elseif hLeft == 2
            Regions(i).LeftSubregion.HazardColour = [1 1 0];  % yellow
        else
            Regions(i).LeftSubregion.HazardColour = [1 0 0];  % red
        end
    elseif uLeft(1) >= .25 && uLeft(2) <= .5
        Regions(i).LeftSubregion.UncertaintyText = 'U50';%'U25-50';
        if hLeft == 1   % lowest hazard
            Regions(i).LeftSubregion.HazardColour = [0 0.78 0];
        elseif hLeft == 2
            Regions(i).LeftSubregion.HazardColour = [0.78 0.78 0];
        else
            Regions(i).LeftSubregion.HazardColour = [0.78 0 0];
        end
    elseif uLeft(1) >= .5 && uLeft(2) <= .75
        Regions(i).LeftSubregion.UncertaintyText = 'U75';%'U50-75';
        if hLeft == 1   % lowest hazard
            Regions(i).LeftSubregion.HazardColour = [0 0.59 0];
        elseif hLeft == 2
            Regions(i).LeftSubregion.HazardColour = [0.59 0.59 0];
        else
            Regions(i).LeftSubregion.HazardColour = [0.59 0 0];
        end
    else 
        Regions(i).LeftSubregion.UncertaintyText = 'U100';%'U75-100';
        if hLeft == 1   % lowest hazard
            Regions(i).LeftSubregion.HazardColour = [0 0.27 0];
        elseif hLeft == 2
            Regions(i).LeftSubregion.HazardColour = [0.27 0.27 0];
        else
            Regions(i).LeftSubregion.HazardColour = [0.27 0 0];
        end
    end


     % Right Subregion
    if uRight(1) >= 0 && uRight(2) <= .25
        Regions(i).RightSubregion.UncertaintyText = 'U25';%'U0-25';
        if hRight == 1   % lowest hazard
            Regions(i).RightSubregion.HazardColour = [0 1 0];  %green
        elseif hRight == 2
            Regions(i).RightSubregion.HazardColour = [1 1 0];  % yellow
        else
            Regions(i).RightSubregion.HazardColour = [1 0 0];  % red
        end
    elseif uRight(1) >= .25 && uRight(2) <= .5
        Regions(i).RightSubregion.UncertaintyText = 'U50';%'U25-50';
        if hRight == 1   % lowest hazard
            Regions(i).RightSubregion.HazardColour = [0 0.78 0];
        elseif hRight == 2
            Regions(i).RightSubregion.HazardColour = [0.78 0.78 0];
        else
            Regions(i).RightSubregion.HazardColour = [0.78 0 0];
        end
    elseif uRight(1) >= .5 && uRight(2) <= .75
        Regions(i).RightSubregion.UncertaintyText = 'U75';%'U50-75';
        if hRight == 1   % lowest hazard
            Regions(i).RightSubregion.HazardColour = [0 0.59 0];
        elseif hRight == 2
            Regions(i).RightSubregion.HazardColour = [0.59 0.59 0];
        else
            Regions(i).RightSubregion.HazardColour = [0.59 0 0];
        end
    else 
        Regions(i).RightSubregion.UncertaintyText = 'U100';%'U75-100';
        if hRight == 1   % lowest hazard
            Regions(i).RightSubregion.HazardColour = [0 0.27 0];
        elseif hRight == 2
            Regions(i).RightSubregion.HazardColour = [0.27 0.27 0];
        else
            Regions(i).RightSubregion.HazardColour = [0.27 0 0];
        end
    end
    
end
save('Run3.mat','Regions')
% p = 0;
% len = 66;% size(p,1);
% k = 1;
% i = 1;
% while k <= len
%     x = ceil(len*rand(1,1));
%     if k == 1
%         p(k,1) = x;
%         k = k + 1;
%     else
%         found = 0;
%         i = 1;
%         while found == 0 && i <= length(p)
%             if x == p(i)
%                 found = 1;
%             end
%             i = i + 1;
%         end
%         if found == 0
%             p(k,1) = x;
%             k = k + 1;
%         end
%     end
% end
% % HMatrix and UMatrix
% %VMatrix = reshape(HMatrix,3*4,1);
% VMatrix = [1;2;3;1;2;3;1;2;3;1;2;3];
% 
% for i = 1:size(Regions,1)
%     x = p(i);
%     % left and right indices
%     left = HUPairings(x,1);
%     right = HUPairings(x,2);
% 
%     leftU = UMatrix(left,2:3);
%     leftHaz = VMatrix(left);
% 
%     rightU = UMatrix(right,2:3);
%     rightHaz = VMatrix(right);
%     Regions(i).LeftSubregion.HazardLevel = leftHaz;
%     Regions(i).LeftSubregion.UncertaintyLevel = leftU;
%     Regions(i).RightSubregion.HazardLevel = rightHaz;
%     Regions(i).RightSubregion.UncertaintyLevel = rightU;
% end


    




