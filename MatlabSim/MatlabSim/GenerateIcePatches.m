% Divide Unreal River segments into ice cells and define in an XML file
load('SimEnvironment.mat');

ID = [7;6;5;4;3;2;1;0];   % ice types
% Description = {'Old';'Thick First yr';'Medium First yr';'Thin First yr';'Grey-White';'Grey';'New';'Clear water'};
% E_Class = [-4;-3;-2;-1;-1;1;2;2];
% D_Class = [-4;-3;-2;-1;1;2;2;2];
% C_Class = [-4;-3;-2;-1;1;2;2;2];
% B_Class = [-4;-2;-1;1;1;2;2;2];
% A_Class = [-4;-1;1;2;2;2;2;2];
% CAC4_Class = [-3;1;2;2;2;2;2;2];
% CAC3_Class = [-1;2;2;2;2;2;2;2];
% Thickness = [170;120;70;30;15;10;9;0];
%IceTable = table(ID,Description,E_Class,D_Class,C_Class,B_Class,A_Class,CAC4_Class,CAC3_Class,Thickness);  %Ice Table
IceTable = Env.ShipIceTable;


% Ice type thicknesses
t1 = 2:1:9;  % 
t2 = 10:1:15;
t3 = 16:1:30;
t4 = 31:1:70;
t5 = 71:1:120;
t6 = 121:1:170;
t7 = 171:1:200;

%Number of divisions per dimension
divs = [4,5,6,7,8];

%Ice Shape
shape = [1 2 3];

len = size(Env.RiverRegions,1);
%Points
Upt = [];  % 1x2 Unreal x,y coordinates
Wpt = [];  % 1x2 World lat,long coordinates
%Regions
%RegionS = struct('UnrealPts',[],'WorldPts',[],'SegmentDiv',[],'UnrealSegments',[],'WorldSegments',[],'IceType',[],'IceConcentrations',[]);
RegionS = struct('UnrealPts',[],'WorldPts',[]);
%IcePatch = struct('OccMapBlob',[],'GeoMapBlob',[],'OccMapRect',[],'GeoMapRect',[]);

IceRegions(1,1) = RegionS;
% 
% Env.UnrealRiverPts(Env.RiverRegions(i,2),2) = Env.UnrealRiverPts(Env.RiverRegions(i,1),2);  %B(2) = A(2)
% Env.UnrealRiverPts(Env.RiverRegions(i,3),1) = Env.UnrealRiverPts(Env.RiverRegions(i,2),1); %C(1) = B(1)
% Env.UnrealRiverPts(Env.RiverRegions(i,4),1) = Env.UnrealRiverPts(Env.RiverRegions(i,1),1); %D(1) = A(1)
% Env.UnrealRiverPts(Env.RiverRegions(i,4),2) = Env.UnrealRiverPts(Env.RiverRegions(i,3),2); % D(2) = C(2)
% 
% % Env.UnrealRiverPts(Env.RiverRegions(3,1),2) = Env.UnrealRiverPts(Env.RiverRegions(2,4),2);
% % Env.UnrealRiverPts(Env.RiverRegions(3,2),2) = Env.UnrealRiverPts(Env.RiverRegions(3,1),2);
% 
% A = [Env.UnrealRiverPts(Env.RiverRegions(i,1),1) Env.UnrealRiverPts(Env.RiverRegions(i,1),2)];  %[x, y]
%     B = [Env.UnrealRiverPts(Env.RiverRegions(i,2),1) Env.UnrealRiverPts(Env.RiverRegions(i,2),2)];
%     C = [Env.UnrealRiverPts(Env.RiverRegions(i,3),1) Env.UnrealRiverPts(Env.RiverRegions(i,3),2)];
%     D = [Env.UnrealRiverPts(Env.RiverRegions(i,4),1) Env.UnrealRiverPts(Env.RiverRegions(i,4),2)];
% 
% plot([A(1);B(1);C(1);D(1);A(1)],[A(2);B(2);C(2);D(2);A(2)])
% hold on
% i = i + 1;

for i = 1:len
    A = [Env.UnrealRiverPts(Env.RiverRegions(i,1),1) Env.UnrealRiverPts(Env.RiverRegions(i,1),2)];  %[x, y]
    B = [Env.UnrealRiverPts(Env.RiverRegions(i,2),1) Env.UnrealRiverPts(Env.RiverRegions(i,2),2)];
    C = [Env.UnrealRiverPts(Env.RiverRegions(i,3),1) Env.UnrealRiverPts(Env.RiverRegions(i,3),2)];
    D = [Env.UnrealRiverPts(Env.RiverRegions(i,4),1) Env.UnrealRiverPts(Env.RiverRegions(i,4),2)];

    Aw = [Env.RealWorldRiverPts(Env.RiverRegions(i,1),1) Env.RealWorldRiverPts(Env.RiverRegions(i,1),2)]; %[Lat, Long]
    Bw = [Env.RealWorldRiverPts(Env.RiverRegions(i,2),1) Env.RealWorldRiverPts(Env.RiverRegions(i,2),2)];
    Cw = [Env.RealWorldRiverPts(Env.RiverRegions(i,3),1) Env.RealWorldRiverPts(Env.RiverRegions(i,3),2)];
    Dw = [Env.RealWorldRiverPts(Env.RiverRegions(i,4),1) Env.RealWorldRiverPts(Env.RiverRegions(i,4),2)];

    %RegionS.UnrealPts = [A;B;C;D];
    %RegionS.WorldPts = [Aw;Bw;Cw;Dw];
    
    % get width
    maxx = max(A(1),B(1));
    minx = min(A(1),B(1));
    maxy = max(B(2),C(2));
    miny = min(B(2),C(2));
    wid = maxx -  minx;
    hei = maxy - miny;
    d = divs(ceil(rand(1,1)*length(divs)));%20
    %RegionS.SegmentDiv = [d,d];
    [Useg, Wseg] = FuzzyBlockSegmentation(wid,hei,minx,miny,d,Env.UnrealToWorldTform);   % Structural Array of division points
    RegionS.UnrealPts = Useg;
    RegionS.WorldPts = Wseg;
    IceRegions(i,1) = RegionS;
end
% % xmlwrite('IceConcentrations.xml',docNode);
% %type('infoUAT.xml');
% len = size(RegionS.UnrealSegments,1);
% a = zeros(len,4);
% b = a;
% 
% for i = 1:len
%     a(i,:) = [RegionS.UnrealSegments(i).A(1),RegionS.UnrealSegments(i).B(1),RegionS.UnrealSegments(i).C(1),RegionS.UnrealSegments(i).D(1)]; 
%     b(i,:) = [RegionS.UnrealSegments(i).A(2),RegionS.UnrealSegments(i).B(2),RegionS.UnrealSegments(i).C(2),RegionS.UnrealSegments(i).D(2)];
% end
% for i = 1:len
%     patch(a(i,:),b(i,:),'b');
%     hold on
% end
len = size(IceRegions(1).UnrealPts,1);
figure,
for i = 1:len
    patch(IceRegions(1).UnrealPts(i).PatchPts(:,1),IceRegions(1).UnrealPts(i).PatchPts(:,2),'y')
    hold on
end
hold off
