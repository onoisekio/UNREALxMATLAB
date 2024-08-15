function SimulationControl(block, i)
%MSFUNTMPL_BASIC A Template for a Level-2 MATLAB S-Function
%   The MATLAB S-function is written as a MATLAB function with the
%   same name as the S-function. Replace 'msfuntmpl_basic' with the 
%   name of your S-function.

%   Copyright 2003-2018 The MathWorks, Inc.

%%
%% The setup method is used to set up the basic attributes of the
%% S-function such as ports, parameters, etc. Do not add any other
%% calls to the main body of the function.
%%
setup(block);

%endfunction

%% Function: setup ===================================================
%% Abstract:
%%   Set up the basic characteristics of the S-function block such as:
%%   - Input ports
%%   - Output ports
%%   - Dialog parameters
%%   - Options
%%
%%   Required         : Yes
%%   C MEX counterpart: mdlInitializeSizes
%%
function setup(block)

% Register number of ports
%i = 0;
block.NumInputPorts  = 1;
block.NumOutputPorts = 1;

% Setup port properties to be inherited or dynamic
block.SetPreCompInpPortInfoToDynamic;
block.SetPreCompOutPortInfoToDynamic;

%Override input port properties
block.InputPort(1).Dimensions        = 1;   % Direction to change state
block.InputPort(1).DatatypeID  = 0;  
block.InputPort(1).Complexity  = 'Real';
block.InputPort(1).DirectFeedthrough = true;

% block.InputPort(2).Dimensions        = 3;
% block.InputPort(2).DatatypeID  = 1;  % single
% block.InputPort(2).Complexity  = 'Real';
% block.InputPort(2).DirectFeedthrough = true;


% Override output port properties
block.OutputPort(1).Dimensions       = 1;   % Current state
block.OutputPort(1).DatatypeID  = 0; 
block.OutputPort(1).Complexity  = 'Real';
block.OutputPort(1).SamplingMode = 'Sample';

% Override output port properties
% block.OutputPort(2).Dimensions       = 1;
% block.OutputPort(2).DatatypeID  = 0; % double
% block.OutputPort(2).Complexity  = 'Real';
% block.OutputPort(2).SamplingMode = 'Sample';


% 
% block.OutputPort(4).Dimensions       = 1;
% block.OutputPort(4).DatatypeID  = 0; % double
% block.OutputPort(4).Complexity  = 'Real';
% Register parameters
block.NumDialogPrms     = 0;

% Register sample times
%  [0 offset]            : Continuous sample time
%  [positive_num offset] : Discrete sample time
%
%  [-1, 0]               : Inherited sample time
%  [-2, 0]               : Variable sample time
block.SampleTimes = [-1 0];

% Specify the block simStateCompliance. The allowed values are:
%    'UnknownSimState', < The default setting; warn and assume DefaultSimState
%    'DefaultSimState', < Same sim state as a built-in block
%    'HasNoSimState',   < No sim state
%    'CustomSimState',  < Has GetSimState and SetSimState methods
%    'DisallowSimState' < Error out when saving or restoring the model sim state
block.SimStateCompliance = 'DefaultSimState';

%% -----------------------------------------------------------------
%% The MATLAB S-function uses an internal registry for all
%% block methods. You should register all relevant methods
%% (optional and required) as illustrated below. You may choose
%% any suitable name for the methods and implement these methods
%% as local functions within the same file. See comments
%% provided for each function for more information.
%% -----------------------------------------------------------------

block.RegBlockMethod('PostPropagationSetup',    @DoPostPropSetup);
block.RegBlockMethod('InitializeConditions', @InitializeConditions);
block.RegBlockMethod('Start', @Start);
block.RegBlockMethod('Outputs', @Outputs);     % Required
block.RegBlockMethod('Update', @Update);
block.RegBlockMethod('Derivatives', @Derivatives);
block.RegBlockMethod('Terminate', @Terminate); % Required
block.RegBlockMethod('SetInputPortSamplingMode', @SetInputPortSamplingMode);

%end setup

%%
%% PostPropagationSetup:
%%   Functionality    : Setup work areas and state variables. Can
%%                      also register run-time methods here
%%   Required         : No
%%   C MEX counterpart: mdlSetWorkWidths
%%
function DoPostPropSetup(block)
block.NumDworks = 1;
  
  block.Dwork(1).Name            = 'x1';
  block.Dwork(1).Dimensions      = 1;
  block.Dwork(1).DatatypeID      = 0;      % double
  block.Dwork(1).Complexity      = 'Real'; % real
  block.Dwork(1).UsedAsDiscState = true;


%%
%% InitializeConditions:
%%   Functionality    : Called at the start of simulation and if it is 
%%                      present in an enabled subsystem configured to reset 
%%                      states, it will be called when the enabled subsystem
%%                      restarts execution to reset the states.
%%   Required         : No
%%   C MEX counterpart: mdlInitializeConditions
%%
function InitializeConditions(block)

%end InitializeConditions

function SetInputPortSamplingMode(block, idx, fd)
 block.InputPort(idx).SamplingMode = fd;
  block.OutputPort(1).SamplingMode  = fd;
  %block.OutputPort(2).SamplingMode = fd;
 

%end SetInputPortSamplingMode

%%
%% Start:
%%   Functionality    : Called once at start of model execution. If you
%%                      have states that should be initialized once, this 
%%                      is the place to do it.
%%   Required         : No
%%   C MEX counterpart: mdlStart
%%
function Start(block)
global i;
global StartTime;
global State;

load("SimEnvironment.mat",'Env')
%% Occupancy Map Pixel properties %%
% [r, c] = size(Env.SmoothOccupancyMap);
% k = 1;
% PixelConcInfo = struct('row',[],'col',[],'sum',0,'num',0,'avg',0);
% PixelHeightInfo = struct('row',[],'col',[],'sum',0,'num',0,'avg',0);
% for i = 1:r
%     for j = 1:c
%         if Env.SmoothOccupancyMap(i,j) == 0.001
%             PixelConcInfo(k,1).row = i;
%             PixelConcInfo(k,1).col = j;
%             PixelConcInfo(k,1).sum = 0;
%             PixelConcInfo(k,1).num = 0;
%             PixelConcInfo(k,1).avg = 0;
% 
%             PixelHeightInfo(k,1).row = i;
%             PixelHeightInfo(k,1).col = j;
%             PixelHeightInfo(k,1).sum = 0;
%             PixelHeightInfo(k,1).num = 0;
%             PixelHeightInfo(k,1).avg = 0;
%             k = k + 1;
%         end
%     end
% end
% save('PixelConcInfo.mat','PixelConcInfo')
% save('PixelHeightInfo.mat','PixelHeightInfo')

State = 0;
StartTime = tic;


%block.Dwork(1).Data = 0;
%State = Machine.State;
 %block.InputPort(1).Data = 0;
%block.OutputPort(1).Data = State;
% WriteHazardMap(block);


% load('SimEnvironment.mat','Env');
% shipType = 3;
% IceTable = Env.ShipIceTable;
% 
% % Ice type thicknesses
% t1 = 2:1:9;  % 
% t2 = 10:1:15;
% t3 = 16:1:30; 
% t4 = 31:1:70;
% t5= 71:1:120;
% t6 = 121:1:170;
% t7 = 171:1:200;
% 
% %Number of divisions per dimension
% divs = [40,50,60,70,80];
% 
% %Ice Shape
% shape = [1 2 3];
% 
% len = size(Env.RiverRegions,1);
% RegionS = struct('UnrealPts',[],'WorldPts',[],'SegmentDiv',[],'UnrealSegments',[],'WorldSegments',[],'IceType',[],'IceConcentrations',[]);
% %IcePatch = struct('A',[],'B',[],'C',[],'D',[],'LatDist',[],'LongDist',[]);
% RegionIceSummary = struct('shape',[],'color',[],'numeral',[]);
% mymap = Env.IceColorMap;  % color map for Hazard map patches
% IceRegions(1,1) = RegionS;
% IceNumerals(1,1) = RegionIceSummary;
% % Divide each of the 18 regions into subregions defined by ice pieces
% for i = 1:len
%     
% %     region = docNode.createElement('Region');
%     A = [Env.UnrealRiverPts(Env.RiverRegions(i,1),1) Env.UnrealRiverPts(Env.RiverRegions(i,1),2)];  %[x, y]
%     B = [Env.UnrealRiverPts(Env.RiverRegions(i,2),1) Env.UnrealRiverPts(Env.RiverRegions(i,2),2)];
%     C = [Env.UnrealRiverPts(Env.RiverRegions(i,3),1) Env.UnrealRiverPts(Env.RiverRegions(i,3),2)];
%     D = [Env.UnrealRiverPts(Env.RiverRegions(i,4),1) Env.UnrealRiverPts(Env.RiverRegions(i,4),2)];
% 
%     Aw = [Env.RealWorldRiverPts(Env.RiverRegions(i,1),1) Env.RealWorldRiverPts(Env.RiverRegions(i,1),2)]; %[Lat, Long]
%     Bw = [Env.RealWorldRiverPts(Env.RiverRegions(i,2),1) Env.RealWorldRiverPts(Env.RiverRegions(i,2),2)];
%     Cw = [Env.RealWorldRiverPts(Env.RiverRegions(i,3),1) Env.RealWorldRiverPts(Env.RiverRegions(i,3),2)];
%     Dw = [Env.RealWorldRiverPts(Env.RiverRegions(i,4),1) Env.RealWorldRiverPts(Env.RiverRegions(i,4),2)];
% 
%     RegionS.UnrealPts = [A;B;C;D];
%     RegionS.WorldPts = [Aw;Bw;Cw;Dw];
%     
%     % get width
%     maxx = max(A(1),B(1));
%     minx = min(A(1),B(1));
%     maxy = max(B(2),C(2));
%     miny = min(B(2),C(2));
%     wid = maxx -  minx;
%     hei = maxy - miny;
%     d = divs(1);%divs(ceil(rand(1,1)*length(divs)));
%     RegionS.SegmentDiv = [d,d];
%     [Useg, Wseg] = BlockSegmentation(wid,hei,minx,miny,d,Env.UnrealToWorldTform);   % Structural Array of division points
%     RegionS.UnrealSegments = Useg;
%     RegionS.WorldSegments = Wseg;
%     tk = 0;
%     IceConcentrations = zeros(length(Env.ShipIceTable.ID),3);
%     IceConcentrations(:,1) = Env.ShipIceTable.ID;
%     % write ice pieces into xml nodes
%     it = zeros(length(Useg),1);
%     area = 0;
%     for j = 1:length(Useg)
%         % ice type
%         sArea = abs(Useg(j).A(1)-Useg(j).B(1))*abs(Useg(j).B(2)-Useg(j).C(2));
%         area = area + sArea;
%         icetype = Env.IceDistProbabilities(i,ceil(length(Env.IceDistProbabilities(i,:))*rand(1,1)));
%         if icetype == 1
%             IceConcentrations(7,2) = IceConcentrations(7,2) + sArea;
%             tk = t1;
%         elseif icetype ==2
%             IceConcentrations(6,2) = IceConcentrations(6,2) + sArea;
%             tk = t2;
%         elseif  icetype ==3
%             IceConcentrations(5,2) = IceConcentrations(5,2) + sArea;
%             tk = t3;
%         elseif icetype == 4
%             IceConcentrations(4,2) = IceConcentrations(4,2) + sArea;
%             tk = t4;
%         elseif icetype ==5
%             IceConcentrations(3,2) = IceConcentrations(3,2) + sArea;
%             tk = t5;
%         elseif icetype ==6
%             IceConcentrations(2,2) = IceConcentrations(2,2) + sArea;
%             tk = t6;
%         elseif icetype ==7
%             IceConcentrations(1,2) = IceConcentrations(1,2) + sArea;
%             tk = t7;
%         else
%             IceConcentrations(8,2) = IceConcentrations(8,2) + sArea;
%         end
% 
% 
%         it(j) = icetype;
%         iceThickness = tk(ceil(rand(1,1)*length(tk)));
%         iceShape = shape(ceil(rand(1,1)*length(shape)));
%         iceWidth = abs(Useg(j).A(1)-Useg(j).B(1));
%         iceHeight = abs(Useg(j).C(2)-Useg(j).B(2));
%         iceCentreX = Useg(j).E(1);
%         iceCentreY = Useg(j).E(2);
%     end
%     RegionS.IceType = it;
%     %conc.appendChild(region); 
%     IceConcentrations(:,3) = IceConcentrations(:,2)/area;
%     RegionS.IceConcentrations = IceConcentrations;
%     IceRegions(i,1) = RegionS;
% 
%     % Calculate ice numerals 
%     IN = 0; 
%     Lats = [IceRegions(i).WorldPts(1,1);IceRegions(i).WorldPts(4,1);IceRegions(i).WorldPts(3,1);IceRegions(i).WorldPts(2,1);IceRegions(i).WorldPts(1,1)];
%     Longs = [IceRegions(i).WorldPts(1,2);IceRegions(i).WorldPts(4,2);IceRegions(i).WorldPts(3,2);IceRegions(i).WorldPts(2,2);IceRegions(i).WorldPts(1,2)];
%     %shape = geopolyshape(Lats,Longs);
%     for j = 1:length(it)  % uce types
%         success = 0;
%         ty = it(j);
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
%   
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
% 
% end
% 
% % Add IceNumerals field to Env Structure and save the SimEnvironment file
% Env.IceNumerals = IceNumerals;
% save('SimEnvironment.mat','Env');
% State = 1;
% save('Machine.mat','State');


%end Start

% function WriteHazardMap(block)
% global State
% 
% load('SimEnvironment.mat','Env');
% shipType = 3;
% IceTable = Env.ShipIceTable;
% 
% % Ice type thicknesses
% t1 = 2:1:9;  % 
% t2 = 10:1:15;
% t3 = 16:1:30;
% t4 = 31:1:70;
% t5= 71:1:120;
% t6 = 121:1:170;
% t7 = 171:1:200;
% 
% %Number of divisions per dimension
% divs = [40,50,60,70,80];
% 
% %Ice Shape
% shape = [1 2 3];
% 
% len = size(Env.RiverRegions,1);
% RegionS = struct('UnrealPts',[],'WorldPts',[],'SegmentDiv',[],'UnrealSegments',[],'WorldSegments',[],'IceType',[],'IceConcentrations',[]);
% %IcePatch = struct('A',[],'B',[],'C',[],'D',[],'LatDist',[],'LongDist',[]);
% RegionIceSummary = struct('shape',[],'color',[],'numeral',[]);
% mymap = Env.IceColorMap;  % color map for Hazard map patches
% IceRegions(1,1) = RegionS;
% IceNumerals(1,1) = RegionIceSummary;
% % Divide each of the 18 regions into subregions defined by ice pieces
% for i = 1:len
%     
% %     region = docNode.createElement('Region');
%     A = [Env.UnrealRiverPts(Env.RiverRegions(i,1),1) Env.UnrealRiverPts(Env.RiverRegions(i,1),2)];  %[x, y]
%     B = [Env.UnrealRiverPts(Env.RiverRegions(i,2),1) Env.UnrealRiverPts(Env.RiverRegions(i,2),2)];
%     C = [Env.UnrealRiverPts(Env.RiverRegions(i,3),1) Env.UnrealRiverPts(Env.RiverRegions(i,3),2)];
%     D = [Env.UnrealRiverPts(Env.RiverRegions(i,4),1) Env.UnrealRiverPts(Env.RiverRegions(i,4),2)];
% 
%     Aw = [Env.RealWorldRiverPts(Env.RiverRegions(i,1),1) Env.RealWorldRiverPts(Env.RiverRegions(i,1),2)]; %[Lat, Long]
%     Bw = [Env.RealWorldRiverPts(Env.RiverRegions(i,2),1) Env.RealWorldRiverPts(Env.RiverRegions(i,2),2)];
%     Cw = [Env.RealWorldRiverPts(Env.RiverRegions(i,3),1) Env.RealWorldRiverPts(Env.RiverRegions(i,3),2)];
%     Dw = [Env.RealWorldRiverPts(Env.RiverRegions(i,4),1) Env.RealWorldRiverPts(Env.RiverRegions(i,4),2)];
% 
%     RegionS.UnrealPts = [A;B;C;D];
%     RegionS.WorldPts = [Aw;Bw;Cw;Dw];
%     
%     % get width
%     maxx = max(A(1),B(1));
%     minx = min(A(1),B(1));
%     maxy = max(B(2),C(2));
%     miny = min(B(2),C(2));
%     wid = maxx -  minx;
%     hei = maxy - miny;
%     d = divs(1);%divs(ceil(rand(1,1)*length(divs)));
%     RegionS.SegmentDiv = [d,d];
%     [Useg, Wseg] = BlockSegmentation(wid,hei,minx,miny,d,Env.UnrealToWorldTform);   % Structural Array of division points
%     RegionS.UnrealSegments = Useg;
%     RegionS.WorldSegments = Wseg;
%     tk = 0;
%     IceConcentrations = zeros(length(ID),3);
%     IceConcentrations(:,1) = ID;
%     % write ice pieces into xml nodes
%     it = zeros(length(Useg),1);
%     area = 0;
%     for j = 1:length(Useg)
%         % ice type
%         sArea = abs(Useg(j).A(1)-Useg(j).B(1))*abs(Useg(j).B(2)-Useg(j).C(2));
%         area = area + sArea;
%         icetype = Env.IceDistProbabilities(i,ceil(length(Env.IceDistProbabilities(i,:))*rand(1,1)));
%         if icetype == 1
%             IceConcentrations(7,2) = IceConcentrations(7,2) + sArea;
%             tk = t1;
%         elseif icetype ==2
%             IceConcentrations(6,2) = IceConcentrations(6,2) + sArea;
%             tk = t2;
%         elseif  icetype ==3
%             IceConcentrations(5,2) = IceConcentrations(5,2) + sArea;
%             tk = t3;
%         elseif icetype == 4
%             IceConcentrations(4,2) = IceConcentrations(4,2) + sArea;
%             tk = t4;
%         elseif icetype ==5
%             IceConcentrations(3,2) = IceConcentrations(3,2) + sArea;
%             tk = t5;
%         elseif icetype ==6
%             IceConcentrations(2,2) = IceConcentrations(2,2) + sArea;
%             tk = t6;
%         elseif icetype ==7
%             IceConcentrations(1,2) = IceConcentrations(1,2) + sArea;
%             tk = t7;
%         else
%             IceConcentrations(8,2) = IceConcentrations(8,2) + sArea;
%         end
% 
% 
%         it(j) = icetype;
%         iceThickness = tk(ceil(rand(1,1)*length(tk)));
%         iceShape = shape(ceil(rand(1,1)*length(shape)));
%         iceWidth = abs(Useg(j).A(1)-Useg(j).B(1));
%         iceHeight = abs(Useg(j).C(2)-Useg(j).B(2));
%         iceCentreX = Useg(j).E(1);
%         iceCentreY = Useg(j).E(2);
%     end
%     RegionS.IceType = it;
%     %conc.appendChild(region); 
%     IceConcentrations(:,3) = IceConcentrations(:,2)/area;
%     RegionS.IceConcentrations = IceConcentrations;
%     IceRegions(i,1) = RegionS;
% 
%     % Calculate ice numerals 
%     IN = 0; 
%     Lats = [IceRegions(i).WorldPts(1,1);IceRegions(i).WorldPts(4,1);IceRegions(i).WorldPts(3,1);IceRegions(i).WorldPts(2,1);IceRegions(i).WorldPts(1,1)];
%     Longs = [IceRegions(i).WorldPts(1,2);IceRegions(i).WorldPts(4,2);IceRegions(i).WorldPts(3,2);IceRegions(i).WorldPts(2,2);IceRegions(i).WorldPts(1,2)];
%     %shape = geopolyshape(Lats,Longs);
%     for j = 1:length(it)  % uce types
%         success = 0;
%         ty = it(j);
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
%   
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
% 
% end
% 
% % Add IceNumerals field to Env Structure and save the SimEnvironment file
% Env.IceNumerals = IceNumerals;
% save('SimEnvironment.mat','Env');
% State = 0;
%xmlwrite('IceConcentrations.xml',docNode);
%type('infoUAT.xml');
% 
% 
% 
% len = length(IceRegions);
% %IceNumerals = zeros(len,1);
% 
% figure,geoplot(IceRegions(1).WorldSegments(1).A(2), IceRegions(1).WorldSegments(1).A(1), 'o', 'color', 'r');
% geobasemap colorterrain
% 
% hold on
% 
% for i = 1:len
%     geoplot(IceNumerals(i).shape,'FaceColor',IceNumerals(i).color,'LineStyle','none')
% end


%end WriteHazardMap

%%
%% Derivatives:
%%   Functionality    : Called to update derivatives of
%%                      continuous states during simulation step
%%   Required         : No
%%   C MEX counterpart: mdlDerivatives
%%

%%
%% Outputs:
%%   Functionality    : Called to generate block outputs in
%%                      simulation step
%%   Required         : Yes
%%   C MEX counterpart: mdlOutputs
%%
function Outputs(block, i)
global i
global State
global StartTime

val = block.InputPort(1).Data;
ElapsedTime = toc(StartTime);
if State == 0 
    if ElapsedTime >= 2
        %ElapsedTime
        State = 1;
    end
elseif State == 1
    if val == -1
        State = 1;
    elseif val == 0
        State = 1;
    elseif val == 1
        State = 2;
    end
elseif State == 2
    if val == -1
        State = 1;
    elseif val == 0
        State = 2;
    elseif val == 1
        State = 3;
    end
end                                            
% if State == 1
%     if block.InputPort(1).Data == 1 % state change permitted
%         State = 2;
%         block.OutputPort(1).Data = uint8(State);
%     end
% end
block.OutputPort(1).Data = State;
%State

% Output the current state
%block.OutputPort(1).Data = State;

%end Outputs

%%
%% Update:
%%   Functionality    : Called to update discrete states
%%                      during simulation step
%%   Required         : No
%%   C MEX counterpart: mdlUpdate
%%
function Update(block)

%block.Dwork(1).Data = block.InputPort(1).Data;

%end Update

%%
%% Derivatives:
%%   Functionality    : Called to update derivatives of
%%                      continuous states during simulation step
%%   Required         : No
%%   C MEX counterpart: mdlDerivatives
%%
function Derivatives(block)

%end Derivatives

%%
%% Terminate:
%%   Functionality    : Called at the end of simulation for cleanup
%%   Required         : Yes
%%   C MEX counterpart: mdlTerminate
%%
%function PlanPath(block, )
function Terminate(block)

%end Terminate

