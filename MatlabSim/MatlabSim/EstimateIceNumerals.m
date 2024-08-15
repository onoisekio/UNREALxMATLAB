% Divide Unreal River segments into ice cells and estimate ice numerals
load('SimEnvironment.mat');
shipType = 3;
% docNode = com.mathworks.xml.XMLUtils.createDocument('IceConcentrations');
% conc = docNode.getDocumentElement;
% conc.setAttribute('version','2.0');

% ICe type probabilities
% prob = [0 0 0 0 1 1 2 2 3 3 4 4 5 6 7 1;
%         0 0 0 1 1 1 2 2 3 3 4 4 5 6 7 1;
%         0 0 1 1 1 2 2 2 3 3 4 4 5 6 7 1;
%         0 0 1 1 1 2 2 2 3 3 4 4 5 6 7 1;
%         0 0 1 1 1 2 2 2 3 3 4 4 5 6 7 1;
%         0 0 1 1 1 2 2 3 3 3 4 4 5 6 7 1;
%         0 0 1 1 1 2 2 3 3 3 4 4 5 6 7 1;
%         0 0 1 1 1 2 2 3 3 3 4 4 5 6 7 1;
%         0 0 1 1 1 2 2 3 3 3 4 4 5 6 7 1;
%         0 0 1 1 1 2 2 3 3 4 4 4 5 6 7 1;
%         0 0 1 1 1 2 2 3 3 3 4 4 5 6 7 1;
%         0 0 1 1 1 2 2 3 3 3 4 4 5 6 7 1;
%         0 0 1 1 1 2 2 3 3 3 4 4 5 6 7 1;
%         0 0 1 1 1 2 2 3 3 3 4 4 5 6 7 1;
%         0 0 1 1 2 2 3 3 4 4 5 5 6 6 6 7;
%         0 0 1 1 2 2 3 3 4 4 5 5 6 6 7 7;
%         0 0 1 1 2 2 3 3 4 4 5 5 6 6 7 7;
%         0 0 1 1 2 2 3 3 4 4 5 5 6 6 7 7];   %probability distribution of ice types
% Env.IceDistProbabilities = prob;

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
% Env.ShipIceTable = table(ID,Description,E_Class,D_Class,C_Class,B_Class,A_Class,CAC4_Class,CAC3_Class,Thickness);  %Ice Table
IceTable = Env.ShipIceTable;

% Ice type thicknesses
t1 = 2:1:9;  % 
t2 = 10:1:15;
t3 = 16:1:30;
t4 = 31:1:70;
t5= 71:1:120;
t6 = 121:1:170;
t7 = 171:1:200;

%Number of divisions per dimension
divs = [40,50,60,70,80];

%Ice Shape
shape = [1 2 3];

len = size(Env.RiverRegions,1);
%Points
Upt = [];  % 1x2 Unreal x,y coordinates
Wpt = [];  % 1x2 World lat,long coordinates
%Regions
RegionS = struct('UnrealPts',[],'WorldPts',[],'SegmentDiv',[],'UnrealSegments',[],'WorldSegments',[],'IceType',[],'IceConcentrations',[]);
IcePatch = struct('A',[],'B',[],'C',[],'D',[],'LatDist',[],'LongDist',[]);
RegionIceSummary = struct('shape',[],'color',[],'numeral',[]);
mymap = Env.IceColorMap;  % color map for Hazard map patches
IceRegions(1,1) = RegionS;
IceNumerals(1,1) = RegionIceSummary;
% Env.IceColorMap = mymap;
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
    % Divide each of the 18 regions into subregions defined by ice pieces
%     region = docNode.createElement('Region');
    A = [Env.UnrealRiverPts(Env.RiverRegions(i,1),1) Env.UnrealRiverPts(Env.RiverRegions(i,1),2)];  %[x, y]
    B = [Env.UnrealRiverPts(Env.RiverRegions(i,2),1) Env.UnrealRiverPts(Env.RiverRegions(i,2),2)];
    C = [Env.UnrealRiverPts(Env.RiverRegions(i,3),1) Env.UnrealRiverPts(Env.RiverRegions(i,3),2)];
    D = [Env.UnrealRiverPts(Env.RiverRegions(i,4),1) Env.UnrealRiverPts(Env.RiverRegions(i,4),2)];

    Aw = [Env.RealWorldRiverPts(Env.RiverRegions(i,1),1) Env.RealWorldRiverPts(Env.RiverRegions(i,1),2)]; %[Lat, Long]
    Bw = [Env.RealWorldRiverPts(Env.RiverRegions(i,2),1) Env.RealWorldRiverPts(Env.RiverRegions(i,2),2)];
    Cw = [Env.RealWorldRiverPts(Env.RiverRegions(i,3),1) Env.RealWorldRiverPts(Env.RiverRegions(i,3),2)];
    Dw = [Env.RealWorldRiverPts(Env.RiverRegions(i,4),1) Env.RealWorldRiverPts(Env.RiverRegions(i,4),2)];

    RegionS.UnrealPts = [A;B;C;D];
    RegionS.WorldPts = [Aw;Bw;Cw;Dw];
    
    % get width
    maxx = max(A(1),B(1));
    minx = min(A(1),B(1));
    maxy = max(B(2),C(2));
    miny = min(B(2),C(2));
    wid = maxx -  minx;
    hei = maxy - miny;
    d = divs(1);%divs(ceil(rand(1,1)*length(divs)));
    RegionS.SegmentDiv = [d,d];
    [Useg, Wseg] = BlockSegmentation(wid,hei,minx,miny,d,Env.UnrealToWorldTform);   % Structural Array of division points
    RegionS.UnrealSegments = Useg;
    RegionS.WorldSegments = Wseg;
    tk = 0;
    IceConcentrations = zeros(length(ID),3);
    IceConcentrations(:,1) = ID;
    % write ice pieces into xml nodes
    it = zeros(length(Useg),1);
    area = 0;
    for j = 1:length(Useg)
        % ice type
        sArea = abs(Useg(j).A(1)-Useg(j).B(1))*abs(Useg(j).B(2)-Useg(j).C(2));
        area = area + sArea;
        icetype = Env.IceDistProbabilities(i,ceil(length(Env.IceDistProbabilities(i,:))*rand(1,1)));
        if icetype == 1
            IceConcentrations(7,2) = IceConcentrations(7,2) + sArea;
            tk = t1;
        elseif icetype ==2
            IceConcentrations(6,2) = IceConcentrations(6,2) + sArea;
            tk = t2;
        elseif  icetype ==3
            IceConcentrations(5,2) = IceConcentrations(5,2) + sArea;
            tk = t3;
        elseif icetype == 4
            IceConcentrations(4,2) = IceConcentrations(4,2) + sArea;
            tk = t4;
        elseif icetype ==5
            IceConcentrations(3,2) = IceConcentrations(3,2) + sArea;
            tk = t5;
        elseif icetype ==6
            IceConcentrations(2,2) = IceConcentrations(2,2) + sArea;
            tk = t6;
        elseif icetype ==7
            IceConcentrations(1,2) = IceConcentrations(1,2) + sArea;
            tk = t7;
        else
            IceConcentrations(8,2) = IceConcentrations(8,2) + sArea;
        end


        it(j) = icetype;
        iceThickness = tk(ceil(rand(1,1)*length(tk)));
        iceShape = shape(ceil(rand(1,1)*length(shape)));
        iceWidth = abs(Useg(j).A(1)-Useg(j).B(1));
        iceHeight = abs(Useg(j).C(2)-Useg(j).B(2));
        iceCentreX = Useg(j).E(1);
        iceCentreY = Useg(j).E(2);

        %Create XML nodes
%         ice = docNode.createElement('IcePiece');
%         type = docNode.createElement('Type');
%         XLoc = docNode.createElement('XLoc');
%         YLoc = docNode.createElement('YLoc');
%         ZLoc = docNode.createElement('ZLoc');
%         XSpan = docNode.createElement('XSpan');
%         YSpan = docNode.createElement('YSpan');
%         Depth = docNode.createElement('ZSpan');

        % Assign Values to nodes
%         type.appendChild(docNode.createTextNode(num2str(icetype)));
%         XLoc.appendChild(docNode.createTextNode(num2str(iceCentreX)));
%         YLoc.appendChild(docNode.createTextNode(num2str(iceCentreY)));
%         ZLoc.appendChild(docNode.createTextNode('0'));
%         XSpan.appendChild(docNode.createTextNode(num2str(iceWidth)));
%         YSpan.appendChild(docNode.createTextNode(num2str(iceHeight)));
%         Depth.appendChild(docNode.createTextNode(num2str(iceThickness)));

        % Arrange XML nodes
        % <IceConcentrations>
        %       <Region>
        %           <IcePiece>
        %               <XLoc></XLoc>
        %               <YLoc></YLoc>
        %               <ZLoc></ZLoc>
        %               <XSpan></XSpan>
        %               <YSpan></YSpan>
        %               <ZSpan></ZSpan>
        %           </IcePiece>
        %       </Region>
        % </IceConcentrations>
%         ice.appendChild(type);
%         ice.appendChild(XLoc);
%         ice.appendChild(YLoc);
%         ice.appendChild(ZLoc);
%         ice.appendChild(XSpan);
%         ice.appendChild(YSpan);
%         ice.appendChild(Depth);
%         region.appendChild(ice);
    end
    RegionS.IceType = it;
    %conc.appendChild(region); 
    IceConcentrations(:,3) = IceConcentrations(:,2)/area;
    RegionS.IceConcentrations = IceConcentrations;
    IceRegions(i,1) = RegionS;

    % Calculate ice numerals 
    IN = 0; 
    Lats = [IceRegions(i).WorldPts(1,1);IceRegions(i).WorldPts(4,1);IceRegions(i).WorldPts(3,1);IceRegions(i).WorldPts(2,1);IceRegions(i).WorldPts(1,1)];
    Longs = [IceRegions(i).WorldPts(1,2);IceRegions(i).WorldPts(4,2);IceRegions(i).WorldPts(3,2);IceRegions(i).WorldPts(2,2);IceRegions(i).WorldPts(1,2)];
    %shape = geopolyshape(Lats,Longs);
    for j = 1:length(it)  % uce types
        success = 0;
        ty = it(j);
        k = 1;
        while success == 0 && k <= size(IceRegions(i).IceConcentrations,1)
            if ty == IceRegions(i).IceConcentrations(k,1)
                conc = IceRegions(i).IceConcentrations(k,3);
                success = 1;
            end
            k = k + 1;
        end
        val = table2array(IceTable(8-ty,shipType));
        IN = IN + conc*val;
    end
%     patchesm(Lats(:,1),Longs(:,1),'b')
    shape = geopolyshape(Lats,Longs);
    RegionIceSummary.shape = shape;
    RegionIceSummary.numeral = IN; 
    success = 0;
    if IN <= mymap(1,1)
        RegionIceSummary.color = mymap(1,2:4);  % <= -3
    elseif IN > mymap(1,1) && IN <= mymap(2,1)  % >-3 <=-2
        RegionIceSummary.color = mymap(2,2:4);
    elseif IN > mymap(2,1) && IN <= mymap(3,1) % >-2 <=-1
        RegionIceSummary.color = mymap(3,2:4);
    elseif IN > mymap(3,1) && IN <= mymap(4,1) % >-1 <=0
        RegionIceSummary.color = mymap(4,2:4);
    elseif IN > mymap(4,1) && IN <= mymap(5,1) % >0 <=1
        RegionIceSummary.color = mymap(5,2:4);
    elseif IN > mymap(5,1) && IN <= mymap(6,1) % >1 <=2
        RegionIceSummary.color = mymap(6,2:4);
    else
        RegionIceSummary.color = mymap(7,2:4); % >= 2
    end
    IceNumerals(i,1) = RegionIceSummary;

end
%xmlwrite('IceConcentrations.xml',docNode);
%type('infoUAT.xml');



len = length(IceRegions);
%IceNumerals = zeros(len,1);

figure,geoplot(IceRegions(1).WorldSegments(1).A(2), IceRegions(1).WorldSegments(1).A(1), 'o', 'color', 'r');
geobasemap colorterrain

hold on

% for i = 1:len
%     icetype = IceRegions(i).IceType;
%     IN = 0;
%     Lats = [IceRegions(i).WorldPts(1,1);IceRegions(i).WorldPts(4,1);IceRegions(i).WorldPts(3,1);IceRegions(i).WorldPts(2,1);IceRegions(i).WorldPts(1,1)];
%     Longs = [IceRegions(i).WorldPts(1,2);IceRegions(i).WorldPts(4,2);IceRegions(i).WorldPts(3,2);IceRegions(i).WorldPts(2,2);IceRegions(i).WorldPts(1,2)];
%     %shape = geopolyshape(Lats,Longs);
%     for j = 1:length(icetype)
%         success = 0;
%         ty = icetype(j);
%         k = 1;
%         while success == 0 && k <= size(IceRegions(i).IceConcentrations,1)
%             if ty == IceRegions(i).IceConcentrations(k,1)
%                 conc = IceRegions(i).IceConcentrations(k,3);
%                 success = 1;
%             end
%             k = k + 1;
%         end
%         val = table2array(IceTable(8-ty,shipType));
%         IN = IN + conc*val;
%     end
% %     patchesm(Lats(:,1),Longs(:,1),'b')
%     shape = geopolyshape(Lats,Longs);
%     RegionIceSummary.shape = shape;
%     RegionIceSummary.numeral = IN; 
%     success = 0;
%     if IN <= mymap(1,1)
%         RegionIceSummary.color = mymap(1,2:4);  % <= -3
%     elseif IN > mymap(1,1) && IN <= mymap(2,1)  % >-3 <=-2
%         RegionIceSummary.color = mymap(2,2:4);
%     elseif IN > mymap(2,1) && IN <= mymap(3,1) % >-2 <=-1
%         RegionIceSummary.color = mymap(3,2:4);
%     elseif IN > mymap(3,1) && IN <= mymap(4,1) % >-1 <=0
%         RegionIceSummary.color = mymap(4,2:4);
%     elseif IN > mymap(4,1) && IN <= mymap(5,1) % >0 <=1
%         RegionIceSummary.color = mymap(5,2:4);
%     elseif IN > mymap(5,1) && IN <= mymap(6,1) % >1 <=2
%         RegionIceSummary.color = mymap(6,2:4);
%     else
%         RegionIceSummary.color = mymap(7,2:4); % >= 2
%     end
%     IceNumerals(i,1) = RegionIceSummary;
% end

% plot the map
% hold on
for i = 1:len
    geoplot(IceNumerals(i).shape,'FaceColor',IceNumerals(i).color,'LineStyle','none')
end
