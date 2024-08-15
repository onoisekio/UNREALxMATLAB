function HazardMapDisplay(block, i)
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
block.NumInputPorts  = 4;
block.NumOutputPorts = 0;

% Setup port properties to be inherited or dynamic
block.SetPreCompInpPortInfoToDynamic;
block.SetPreCompOutPortInfoToDynamic;

% Override input port properties
block.InputPort(1).Dimensions        = [1 3];  % Vessel geo position
block.InputPort(1).DatatypeID  = 0;  % double
block.InputPort(1).Complexity  = 'Real';
block.InputPort(1).DirectFeedthrough = true;

% Override input port properties
block.InputPort(2).Dimensions        = [1 3];  % Drone geo position
block.InputPort(2).DatatypeID  = 0;  % double
block.InputPort(2).Complexity  = 'Real';
block.InputPort(2).DirectFeedthrough = true;

% % Camera FOV
block.InputPort(3).Dimensions        = 1;   % Unreal to World Transform (2,:)
block.InputPort(3).DatatypeID  = 0; 
block.InputPort(3).Complexity  = 'Real';
block.InputPort(3).DirectFeedthrough = true;

block.InputPort(4).Dimensions        = 1;   % Unreal to World Transform (2,:)
block.InputPort(4).DatatypeID  = 0;  
block.InputPort(4).Complexity  = 'Real';
block.InputPort(4).DirectFeedthrough = true;

% Unreal X Y inputs 
% block.InputPort(3).Dimensions        = 1;    % XY
% block.InputPort(3).DatatypeID  = 0;  % double
% block.InputPort(3).Complexity  = 'Real';
% block.InputPort(3).DirectFeedthrough = true;

% 
% block.InputPort(3).Dimensions        = 3;    % Y
% block.InputPort(3).DatatypeID  = 1;  % single
% block.InputPort(3).Complexity  = 'Real';
% block.InputPort(3).DirectFeedthrough = true;


% Override output port properties
% block.OutputPort(1).Dimensions       = 1;    % state
% block.OutputPort(1).DatatypeID  = 0; % double
% block.OutputPort(1).Complexity  = 'Real';
% block.OutputPort(1).SamplingMode = 'Sample';

% block.OutputPort(2).Dimensions       = 1;   % unreal to world transform
% block.OutputPort(2).DatatypeID  = 0; % double
% block.OutputPort(2).Complexity  = 'Real';
% block.OutputPort(2).SamplingMode  = 'Sample';

% block.OutputPort(3).Dimensions       = 3;  % Occupancy grid to unreal transform
% block.OutputPort(3).DatatypeID  = 0; % double
% block.OutputPort(3).Complexity  = 'Real';
% block.OutputPort(3).SamplingMode  = 'Sample';
% 
% block.OutputPort(4).Dimensions       = 3;   % Unreal to occupancy grid transform
% block.OutputPort(4).DatatypeID  = 0; % double
% block.OutputPort(4).Complexity  = 'Real';
% block.OutputPort(4).SamplingMode = 'Sample';

% block.OutputPort(5).Dimensions       = 1;
% block.OutputPort(5).DatatypeID  = 0; % double
% block.OutputPort(5).Complexity  = 'Real';
% block.OutputPort(5).SamplingMode  = 'Sample';
% 
% block.OutputPort(6).Dimensions       = 1;
% block.OutputPort(6).DatatypeID  = 0; % double
% block.OutputPort(6).Complexity  = 'Real';
% block.OutputPort(6).SamplingMode  = 'Sample';
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
% block.RegBlockMethod('SetInputPortSamplingMode', @SetInputPortSamplingMode);

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


%%
%% Start:
%%   Functionality    : Called once at start of model execution. If you
%%                      have states that should be initialized once, this 
%%                      is the place to do it.
%%   Required         : No
%%   C MEX counterpart: mdlStart
%%
function Start(block)


% env = load('SimEnvironment.mat');
% 
% start = [-271 111 pi/2];      % unreal coordinates
% fin = [180 -330 0];            % unreal coordinates
% wlp = [start(1), start(2), 1] * env.Env.UnrealToWorldTform;
% wrl = [wlp(2)/wlp(3) wlp(1)/wlp(3)];  % lat and long
global ax1
global ax2
global x
global nFrames
global ET
global hMap
global hMapShip
global hMapDrone
global hShipPath
% global hMapShade
global UtoW
global shipPathUpdate
global hazardUpdate
global hRed
global hYellow
global hGreen
global hBlue
global sPoint
global hShipTrail

sPoint = [];%zeros(1,2);
shipPathUpdate = 0; % number of ship path updates
hazardUpdate = 0; % number of hazards updates

load('SimEnvironment.mat','Env')
UtoW = Env.UnrealToWorldTform;

% len = length(Env.IceNumerals);
f = figure;
hMap = geoaxes;
set(f,'MenuBar','none','NumberTitle','off','units','normalized','outerposition',[-1 0 1 1]);%.WindowState = 'maximized';

% geoplot(hMap, Env.IceNumerals(1).shape,'FaceColor',Env.IceNumerals(1).color,'LineStyle','none');
geolimits(hMap, [47.9 50.1],[-70 -65.5]);
set(hMap, 'NextPlot','add');
geobasemap colorterrain
%hold on

hYellow = geoplot(hMap, Env.HazardMapShading1(:,3), Env.HazardMapShading1(:,4), '.', 'Color', [1,1,0]); % Patch
hGreen = geoplot(hMap, Env.HazardMapShading1(:,3), Env.HazardMapShading1(:,4), '.', 'Color', [0,1,0]); % Patch
hBlue = geoplot(hMap, Env.HazardMapShading1(:,3), Env.HazardMapShading1(:,4), '.', 'Color', [0,0,1]); % Patch
hRed = geoplot(hMap, Env.HazardMapShading1(:,3), Env.HazardMapShading1(:,4), '.', 'Color', [1,0,0]); % Patch


% hMapShade = geoplot(hMap, Env.HazardMapShading1(:,3), Env.HazardMapShading1(:,4), '.', 'Color', Env.HazardMapShading1(1,5:7)); % Patch

dWayPts = [Env.UnrealEndPoints(:,1),Env.UnrealEndPoints(:,2),ones(size(Env.UnrealEndPoints,1),1)];
dWayPts = dWayPts * UtoW;
dWayPts(:,1) = dWayPts(:,1)./dWayPts(:,3);
dWayPts(:,2) = dWayPts(:,2)./dWayPts(:,3);
dWayPlot = geoplot(hMap, dWayPts(:,2), dWayPts(:,1), '-+w', 'LineWidth', 2);  % Waypoint for drone
hShipPath = geoplot(hMap, dWayPts(:,2), dWayPts(:,1), 'color','k');
hShipPath.LatitudeData = [];
hShipPath.LongitudeData = [];



shipPos = [-350, 200, 1] * UtoW;
shipPos = [shipPos(2)/shipPos(3) shipPos(1)/shipPos(3)];  % lat and long
hMapShip = geoplot(hMap, shipPos(1), shipPos(2), 'o', 'MarkerFaceColor', 'k', 'MarkerSize',10,'MarkerEdgeColor','w');
dronePos = [-350, 200, 1] * UtoW;
dronePos = [dronePos(2)/dronePos(3) dronePos(1)/dronePos(3)];  % lat and long
hMapDrone = geoplot(hMap, dronePos(1), dronePos(2), 'o', 'MarkerFaceColor', [1,1,1], 'MarkerSize',10,'MarkerEdgeColor',[0,0,0]);
hShipTrail = geoplot(hMap, shipPos(1), shipPos(2), '.', 'Color', 'b', 'MarkerSize',2);
sPoint(1,:) = [shipPos(1) shipPos(2)];

%legend('Safe 1','Safe 2','Safe 3','Peril','Pre-Planned Survey Path','Ship','Survey Drone','Ship Safe Path','TextColor',[1,1,1],'Color',[0.5,0.5,0.5])

% hold on
% for i = 2:len
%     geoplot(Env.IceNumerals(i).shape,'FaceColor',Env.IceNumerals(i).color,'LineStyle','none')
%     drawnow
% end
% hold off

% wlp1 = [block.InputPort(2).Data(1), block.InputPort(2).Data(2), 1] * E;
% wrl1 = [wlp1(2)/wlp1(3) wlp1(1)/wlp1(3)];  % lat and long
% figure,geoplot(wrl1(1), wrl1(2), 'o', 'color', 'k');
% geobasemap colorterrain
% ax2 = gca;



nFrames = 0;
% figure,geoplot(block.InputPort(1).Data(2), block.InputPort(1).Data(1), 'o', 'color', 'r');
% geolimits([48 50],[-70 -67]);
% ax = gca;
% x = 1;
% If State = 0, read the environment and 

%end Start

%%
%% Outputs:
%%   Functionality    : Called to generate block outputs in
%%                      simulation step
%%   Required         : Yes
%%   C MEX counterpart: mdlOutputs
%%
function Outputs(block)
global ax1
global ax2
% global x
global nFrames    % number of frames
global ETf
global hMapShip
global hMapDrone
global hShipPath
% global hMapShade
global UtoW

global shipPathUpdate
global hazardUpdate
global hRed
global hGreen
global hYellow
global hBlue
global oldLatSize
global oldLongSize
global sPoint
global hShipTrail


shipPos = [block.InputPort(1).Data(1), block.InputPort(1).Data(2), 1] * UtoW;
shipPos = [shipPos(2)/shipPos(3) shipPos(1)/shipPos(3)];  % lat and long
s = size(sPoint,1)
sPoint(s+1,:) = [shipPos(1),shipPos(2)];
hShipTrail.LatitudeData = sPoint(:,1);
hShipTrail.LongitudeData = sPoint(:,2);
hMapShip.LatitudeData = shipPos(1);
hMapShip.LongitudeData = shipPos(2);
dronePos = [block.InputPort(2).Data(1), -block.InputPort(2).Data(2), 1] * UtoW;
dronePos = [dronePos(2)/dronePos(3) dronePos(1)/dronePos(3)];  % lat and long
hMapDrone.LatitudeData = dronePos(1);
hMapDrone.LongitudeData = dronePos(2);

drawnow;
if block.InputPort(3).Data == 1   % new occupancy map available
    if hazardUpdate == 0
        hMapDrone.Visible = 'off';
        load('OccMap.mat','outMap')
        red = find((outMap(:,5) == 1) & (outMap(:,6) ==0) & (outMap(:,7) == 0));
        yellow = find((outMap(:,5) == 1) & (outMap(:,6) ==1) & (outMap(:,7) == 0));
        green = find((outMap(:,5) == 0) & (outMap(:,6) ==1) & (outMap(:,7) == 0));
        blue = find((outMap(:,5) == 0) & (outMap(:,6) ==0) & (outMap(:,7) == 1));
%         geoplot(outMap(red,3),outMap(red,4),'.','color',[1 0 0])
        hRed.LatitudeData = outMap(red,3);
        hRed.LongitudeData = outMap(red,4);

%         geoplot(outMap(yellow,3),outMap(yellow,4),'.','color',[1 1 0])
        hYellow.LatitudeData = outMap(yellow,3);
        hYellow.LongitudeData = outMap(yellow,4);

%         geoplot(outMap(green,3),outMap(green,4),'.','color',[0 1 0])
        hGreen.LatitudeData = outMap(green,3);
        hGreen.LongitudeData = outMap(green,4);

%         geoplot(outMap(blue,3),outMap(blue,4),'.','color',[0 0 1])
        hBlue.LatitudeData = outMap(blue,3);
        hBlue.LongitudeData = outMap(blue,4);
        hazardUpdate = hazardUpdate + 1;
        % draw hazard map
        shipPathUpdate = 0;
    end
else
    hazardUpdate = 0;
    if hazardUpdate == 0
        hMapDrone.Visible = 'on'; 
%         hazardUpdate = hazardUpdate + 1;
    end
end

if block.InputPort(4).Data == 1  % new ship path available
%         load('ShipPath.mat','ShipPosW')    
%         la = size(ShipPosW(:,2));
%         lo = size(ShipPosW(:,1));
%     if shipPathUpdate == 0
%         % draw new ship path
%         disp("draw new ship path");
%         
%         size(hShipPath.LatitudeData)
%         size(hShipPath.LongitudeData)
%         
%         hShipPath.LatitudeData = [hShipPath.LatitudeData ShipPosW(:,2)'];
%         hShipPath.LongitudeData = [hShipPath.LongitudeData ShipPosW(:,1)'];
%         shipPathUpdate = shipPathUpdate + 1;
%         disp("drawn new ship path");
%         size(hShipPath.LatitudeData)
%         size(hShipPath.LongitudeData)
%     end
else
    shipPathUpdate = 0;
end


% wlp = [block.InputPort(1).Data(1), block.InputPort(1).Data(2), 1] * E.UnrealToWorldTform;
% wrl = [wlp(2)/wlp(3) wlp(1)/wlp(3)];  % lat and long
% 
% geoplot(ax1,wrl(1), wrl(2), 'o', 'color', 'r');
% drawnow
% geobasemap colorterrain
% ax1 = gca;

% wlp1 = [block.InputPort(2).Data(1), block.InputPort(2).Data(2), 1] * E.UnrealToWorldTform;
% wrl1 = [wlp1(2)/wlp1(3) wlp1(1)/wlp1(3)];  % lat and long
% geoplot(ax2,wrl1(1), wrl1(2), 'o', 'color', 'k');
% drawnow;
% geoplot(ax2, block.InputPort(1).Data(2), block.InputPort(1).Data(1), 'o', 'color', 'k');
% drawnow;

% geobasemap colorterrain
% geobasemap colorterrain

%if block.InputPort(3).Data == 1 
%  if nFrames == 0
%     load('SimEnvironment.mat','Env')
%     len = length(Env.IceNumerals);
%     f = figure;
%     set(f,'MenuBar','none','NumberTitle','off','units','normalized','outerposition',[-1 0 1 1]);%.WindowState = 'maximized';
%     %hold on
%     geoplot(Env.IceNumerals(1).shape,'FaceColor',Env.IceNumerals(1).color,'LineStyle','none');
%     geolimits([47.9 50.1],[-70 -65.5]);
%     set(gca,'NextPlot','add');
%     geobasemap colorterrain
%     %hold on
%    
%     for i = 2:len
%         %hold on
%         geoplot(Env.IceNumerals(i).shape,'FaceColor',Env.IceNumerals(i).color,'LineStyle','none')
%         %drawnow
%     end
% %     hold off
%     nFrames = nFrames + 1;
%     State = 2;  % State 2
%     save('Machine.mat','State')
% 
% end


%wlp = [ShipPosN(i,1), ShipPosN(i,2), 1] * InputPort(1);
%        wrl = [wlp(2)/wlp(3) wlp(1)/wlp(3)];  % lat and long

%patchm(ax,block.InputPort(2).Data(:,2), block.InputPort(2).Data(:,1),'green','FaceAlpha','flat')
% hold on
% %block.InputPort(2).Data(:,1:2)
% if x == 1
% geoplot(ax, block.InputPort(2).Data(:,2), block.InputPort(2).Data(:,1),'o', 'color', 'blue');
% 
% hold on
% geoplot(ax, block.InputPort(1).Data(2), block.InputPort(1).Data(1), 'o', 'color', 'r');
% 
% %
% geolimits([48 50],[-70 -67]);
% x = x + 1;
% drawnow
% end

%hold off



%block.OutputPort(1).Data = block.Dwork(1).Data + block.InputPort(1).Data;
% block.OutputPort(1).Data = env.Env.WorldToUnrealTform;
% block.OutputPort(2).Data = env.Env.UnrealToWorldTform;
% block.OutputPort(3).Data = env.Env.OccupancyGridToUnrealTform;
% block.OutputPort(4).Data = env.Env.UnrealToOccupancyGridTform;

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

