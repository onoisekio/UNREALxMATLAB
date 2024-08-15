% Develop Navigation Path

StartRegion = [1;4;7;10;13;16];
StopRegion = [4;7;10;13;16;18];
UnrealStartX = [];
UnrealStartY = [];
UnrealStopX = [];
UnrealStopY = [];
WorldStartLat = [];
WorldStartLong = [];
WorldStopLat = [];
WorldStopLong = [];
MapStartX = [];
MapStartY = [];
MapStopX = [];
MapStopY = [];
len = size(Env.RiverRegions,1);
AllPts = zeros(len,14);

for i = 1:len
 A = [Env.UnrealRiverPts(Env.RiverRegions(i,1),1) Env.UnrealRiverPts(Env.RiverRegions(i,1),2)];
 B = [Env.UnrealRiverPts(Env.RiverRegions(i,2),1) Env.UnrealRiverPts(Env.RiverRegions(i,2),2)];
 C = [Env.UnrealRiverPts(Env.RiverRegions(i,3),1) Env.UnrealRiverPts(Env.RiverRegions(i,3),2)];
 D = [Env.UnrealRiverPts(Env.RiverRegions(i,4),1) Env.UnrealRiverPts(Env.RiverRegions(i,4),2)];
 x = (A(1)+B(1))/2;
 y = (B(2)+C(2))/2;
 p = [x y 1]*Env.UnrealToWorldTform;
 p1 = p/p(3);   % World lat and long coordinates
 m = Env.UnrealToOccupancyGridTform*[x;y;1];
 AllPts(i,:) = [A(1) A(2) B(1) B(2) C(1) C(2) D(1) D(2) x y p1(2) p1(1) m(1) m(2)];
end
for i = 1:length(StartRegion)
    UnrealStartX(i,1) = AllPts(StartRegion(i),9);
    UnrealStartY(i,1) = AllPts(StartRegion(i),10);
    UnrealStopX(i,1) = AllPts(StopRegion(i),9);
    UnrealStopY(i,1) = AllPts(StopRegion(i),10);
    WorldStartLat(i,1) = AllPts(StartRegion(i),11);
    WorldStartLong(i,1) = AllPts(StartRegion(i),12);
    WorldStopLat(i,1) = AllPts(StopRegion(i),11);
    WorldStopLong(i,1) = AllPts(StopRegion(i),12);
    MapStartX(i,1) = AllPts(StartRegion(i),13);
    MapStartY(i,1) = AllPts(StartRegion(i),14);
    MapStopX(i,1) = AllPts(StopRegion(i),14);
    MapStopY(i,1) = AllPts(StopRegion(i),14);
end

SurveyTable = table(StartRegion,StopRegion,UnrealStartX,UnrealStartY,UnrealStopX,UnrealStopY,WorldStartLat,WorldStartLong,WorldStopLat,WorldStopLong, ...
    MapStartX,MapStartY,MapStopX,MapStopY);

i = 1;

plot([AllPts(SurveyTable.StartRegion(i),1);AllPts(SurveyTable.StartRegion(i),3);AllPts(SurveyTable.StartRegion(i),5);AllPts(SurveyTable.StartRegion(i),7);AllPts(SurveyTable.StartRegion(i),1)],...
    [AllPts(SurveyTable.StartRegion(i),2);AllPts(SurveyTable.StartRegion(i),4);AllPts(SurveyTable.StartRegion(i),6);AllPts(SurveyTable.StartRegion(i),8);AllPts(SurveyTable.StartRegion(i),2)],'.-b');
    hold on

    plot([AllPts(SurveyTable.StopRegion(i),1);AllPts(SurveyTable.StopRegion(i),3);AllPts(SurveyTable.StopRegion(i),5);AllPts(SurveyTable.StopRegion(i),7);AllPts(SurveyTable.StopRegion(i),1)],...
    [AllPts(SurveyTable.StopRegion(i),2);AllPts(SurveyTable.StopRegion(i),4);AllPts(SurveyTable.StopRegion(i),6);AllPts(SurveyTable.StopRegion(i),8);AllPts(SurveyTable.StopRegion(i),2)],'.-b');

    plot([SurveyTable.UnrealStartX(i),SurveyTable.UnrealStopX(i)],[SurveyTable.UnrealStartY(i),SurveyTable.UnrealStopY(i)],'*-r');
    i = i + 1;


