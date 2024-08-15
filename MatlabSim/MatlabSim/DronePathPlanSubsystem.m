function DronePathPlanSubsystem(block, i)
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
block.NumInputPorts  = 3;
block.NumOutputPorts = 6;

% Setup port properties to be inherited or dynamic
block.SetPreCompInpPortInfoToDynamic;
block.SetPreCompOutPortInfoToDynamic;

% Override input port properties
block.InputPort(1).Dimensions        = 3;
block.InputPort(1).DatatypeID  = 1;  % single
block.InputPort(1).Complexity  = 'Real';
block.InputPort(1).DirectFeedthrough = true;

block.InputPort(2).Dimensions        = 3;
block.InputPort(2).DatatypeID  = 1;  % single
block.InputPort(2).Complexity  = 'Real';
block.InputPort(2).DirectFeedthrough = true;

block.InputPort(3).Dimensions        = 3;
block.InputPort(3).DatatypeID  = 1;  % single
block.InputPort(3).Complexity  = 'Real';
block.InputPort(3).DirectFeedthrough = true;

% Override output port properties
block.OutputPort(1).Dimensions       = 1;
block.OutputPort(1).DatatypeID  = 0; % double
block.OutputPort(1).Complexity  = 'Real';
block.OutputPort(1).SamplingMode = 'Sample';

block.OutputPort(2).Dimensions       = 1;
block.OutputPort(2).DatatypeID  = 0; % double
block.OutputPort(2).Complexity  = 'Real';
block.OutputPort(2).SamplingMode  = 'Sample';

block.OutputPort(3).Dimensions       = 1;
block.OutputPort(3).DatatypeID  = 0; % double
block.OutputPort(3).Complexity  = 'Real';
block.OutputPort(3).SamplingMode  = 'Sample';

block.OutputPort(4).Dimensions       = 1;
block.OutputPort(4).DatatypeID  = 0; % double
block.OutputPort(4).Complexity  = 'Real';
block.OutputPort(4).SamplingMode = 'Sample';

block.OutputPort(5).Dimensions       = 1;
block.OutputPort(5).DatatypeID  = 0; % double
block.OutputPort(5).Complexity  = 'Real';
block.OutputPort(5).SamplingMode  = 'Sample';

block.OutputPort(6).Dimensions       = 1;
block.OutputPort(6).DatatypeID  = 0; % double
block.OutputPort(6).Complexity  = 'Real';
block.OutputPort(6).SamplingMode  = 'Sample';
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
block.SampleTimes = [0 0];

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
  block.OutputPort(2).SamplingMode = fd;
  block.OutputPort(3).SamplingMode = fd;
  block.OutputPort(4).SamplingMode = fd;
  block.OutputPort(5).SamplingMode = fd;
  block.OutputPort(6).SamplingMode = fd;

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
% Plan survey path from start to end
load('SimEnvironment.mat','Env.SurveyTable');

%Start SurveyPt, End SurveyPt, CurrShipPosition
global i;
global ShipPosN;
global DronePosN
global ax;
global tf;
global SurveyTable;
global phase;
global flightIndex;

phase = 1;
flightIndex = 1;

% Extract the survey points from the Simulation Environment 
SurveyTable = Env.SurveyTable;
len = size(SurveyTable,1);
pts = zeros(1,2);
k = 1;
for i = 1:len
    pts(k,:) = [SurveyTable.UnrealStartX(i),SurveyTable.UnrealStartY(i)];
    k = k + 1;
    pts(k,:) = [SurveyTable.UnrealStopX(i),SurveyTable.UnrealStopY(i)];
    k = k+1;
end
pts1 = unique(pts,'rows');

p = polyfit(pts1(:,1),pts1(:,2),3);
minx = min(pts1(:,1));
maxx = max(pts1(:,1));
xPoly = minx:1:maxx;
xPoly = xPoly';
yPoly = p(1)*xPoly.^3 + p(2)*xPoly.^2 + p(3)*xPoly + p(4);
grad = 180/pi*atan(3*p(1)*xPoly.^2 + 2*p(2)*xPoly + p(3));

% Interpolate points according to frame rate
v = Env.DroneSpeed;
ft = 1/30;  % frame period
k = 1;
len = length(xPoly);
DronePosN = zeros(1,3);
for j = 1:len-1
    ds = sqrt((xPoly(j+1)-xPoly(j))^2 + (yPoly(j+1)-yPoly(j))^2); % st line distance between start and end points
    dt = ds/v; % time to travel the line
    N = dt/ft; % distance travelled
    dx = (xPoly(j+1) - xPoly(j))/N;
    dy = (yPoly(j+1) - yPoly(j))/N;
    dTh = (grad(j+1) - grad(j))/N; % rotation change
    x = xPoly(j);
    y = yPoly(j);
    Th = grad(j);
    DronePosN(k,:) = [xPoly(j), yPol(j) grad(j)];
    x = x + dx;
    y = y + dy;
    Th = Th + dTh;
    k = k + 1;

    if dx < 0  % x2 < x1
        while x > xPoly(j+1)
            y = ((yPoly(j+1)-yPoly(j))/(xPoly(j+1)-xPoly(j)))*(x-xPoly(j)) + yPoly(j);
            DronePosN(k,:) = [x,y,Th];
            k = k + 1;
            x = x + dx;
            Th = Th + dTh;
        end
    elseif dx > 0
        while x < xPoly(j+1)
            y = ((yPoly(j+1)-yPoly(j))/(xPoly(j+1)-xPoly(j)))*(x-xPoly(j)) + yPoly(j);
            DronePosN(k,:) = [x,y,Th];
            k = k + 1;
            x = x + dx;
            Th = Th + dTh;
        end
    else
        if dy < 0
            while y > yPoly(j+1)
                DronePosN(k,:) = [x,y,Th];
                y = y + dy;
                Th = Th + dTh;
                k = k + 1;
            end
        else
            while y < yPoly(j+1)
                DronePosN(k,:) = [x,y,Th];
                y = y + dy;
                Th = Th + dTh;
                k = k + 1;
            end
        end
    end
    %ShipPosN(k,:) = [ShipPos(j+1,1:3)];
    %k = k + 1;
end
DronePosN(k,:) = [xPoly(j), yPoly(j) grad(j)]; %Final interpolated points from start to end of voyage


% Move drone first, return drone
% Define regions where the drone must do survellance
% Move ship and monitor its position
% When ship gets to critical point, move drone to survey until the next
% point and return
% Move ship accordingly
% Repeat process until end


block.Dwork(1).Data = 0;
env = 
tf = env.Env.UnrealToWorldTform;
start = [-271 111 pi/2];      % unreal coordinates
fin = [180 -330 0];            % unreal coordinates
% wlp = [start(1), start(2), 1] * env.Env.UnrealToWorldTform;
% wrl = [wlp(2)/wlp(3) wlp(1)/wlp(3)];  % lat and long
% figure,geoplot(wrl(1), wrl(2), 'o', 'color', 'r');
% ax = gca;
% drawnow
res = 5;

% transform points to occupancy map coordinates
startO = [env.Env.UnrealToOccupancyGridTform * [start(1);start(2);1];start(3)];
finO =  [env.Env.UnrealToOccupancyGridTform * [fin(1);fin(2);1];fin(3)];
startO = startO';
finO = finO';

% map bounds
bounds = [env.Env.OccupancyGrid.XWorldLimits; env.Env.OccupancyGrid.YWorldLimits; [-pi pi]];
% state space dubins
ss = stateSpaceDubins(bounds);
ss.MinTurningRadius = 10;

stateValidator = validatorOccupancyMap(ss); 
stateValidator.Map = occupancyMap(env.Env.OccupancyMap,res);   %mm = occupancyMap(map,5);
stateValidator.ValidationDistance = 1;
planner = plannerRRT(ss,stateValidator);
planner.MaxConnectionDistance = 2.0;
planner.MaxIterations = 30000;
planner.GoalReachedFcn = @exampleHelperCheckIfGoal;

rng default
[pthObj, solnInfo] = plan(planner,startO,finO);

% Transform path to unreal coordinates and convert to time series
len = size(pthObj.States,1);
dur = 10;
t = 1/len*dur;
time = 0:t:dur-t;

Ship = env.Env.OccupancyGridToUnrealTform * [pthObj.States(:,1:2)';ones(1,len)];
ShipPos = [Ship(1,:)', Ship(2,:)', pthObj.States(:,3)];

%%%%%%%%%%%%
% DS = sqrt((ShipPos(end,1)-ShipPos(1,1))^2 + (ShipPos(end,2)-ShipPos(1,2))^2);
% dt = 600;
v = 1;  % speed
ft = 1/30;  % frame period
k = 1;
ShipPosN = zeros(1,3);
DronePosN = env.Env.DroneSurveyPath; 
for j = 1:len-1
    ds = sqrt((ShipPos(j+1,1)-ShipPos(j,1))^2 + (ShipPos(j+1,2)-ShipPos(j,2))^2); % st line distance between start and end points
    dt = ds/v; % time to travel the line
    N = dt/ft; % distance travelled
    dx = (ShipPos(j+1,1) - ShipPos(j,1))/N;
    dy = (ShipPos(j+1,2) - ShipPos(j,2))/N;
    dTh = (ShipPos(j+1,3) - ShipPos(j,3))/N; % rotation change
    x = ShipPos(j,1);
    y = ShipPos(j,2);
    Th = ShipPos(j,3);
    ShipPosN(k,:) = ShipPos(j,1:3);
    x = x + dx;
    y = y + dy;
    Th = Th + dTh;
    k = k + 1;

    if dx < 0  % x2 < x1
        while x > ShipPos(j+1,1)
            y = ((ShipPos(j+1,2)-ShipPos(j,2))/(ShipPos(j+1,1)-ShipPos(j,1)))*(x-ShipPos(j,1)) + ShipPos(j,2);
            ShipPosN(k,:) = [x,y,Th];
            k = k + 1;
            x = x + dx;
            Th = Th + dTh;
        end
    elseif dx > 0
        while x < ShipPos(j+1,1)
            y = ((ShipPos(j+1,2)-ShipPos(j,2))/(ShipPos(j+1,1)-ShipPos(j,1)))*(x-ShipPos(j,1)) + ShipPos(j,2);
            ShipPosN(k,:) = [x,y,Th];
            k = k + 1;
            x = x + dx;
            Th = Th + dTh;
        end
    else
        if dy < 0
            while y > ShipPos(j+1,2)
                ShipPosN(k,:) = [x,y,Th];
                y = y + dy;
                Th = Th + dTh;
                k = k + 1;
            end
        else
            while y < ShipPos(j+1,2)
                ShipPosN(k,:) = [x,y,Th];
                y = y + dy;
                Th = Th + dTh;
                k = k + 1;
            end
        end
    end
    %ShipPosN(k,:) = [ShipPos(j+1,1:3)];
    %k = k + 1;
end
ShipPosN(k,:) = [ShipPos(j+1,1:3)];



% time = time';
% position(:,3) = 5;
% position(:,2) = 0;
% orientation(:,2) = 0;
% orientation = orientation*pi/180;
% 
% acc = 0.5;
% u = 0;
% t1 = 2;
% position(1,1) = 0;
% 
% for i = 2:length(time)
%     if time(i) <= t1
%         u = u + acc*t;
%         position(i,1) = position(i-1,1) + u*t + 0.5*acc*t^2;
%     else
%        position(i,1) = position(i-1,1) + u*t;
%     end
% end
% 
% p = struct('x',[time,position(:,1)], 'y',[time, position(:,2)], 'z',[time,position(:,3)]);
% o = struct('x',[time,orientation(:,1)], 'y',[time, orientation(:,2)], 'z',[time,orientation(:,3)]);

%end Start

%%
%% Outputs:
%%   Functionality    : Called to generate block outputs in
%%                      simulation step
%%   Required         : Yes
%%   C MEX counterpart: mdlOutputs
%%
function Outputs(block, i)
global i;
global ShipPosN;
global DronePosN;
global ax;
global tf;
global phase;   % Survey phase = region of the river being surveyed = size of survey table
global part;   % part of survey phase: 0 = forward, 1 = return;
global flightIndex;  % Index of drone location in DronePosN
global SurveyTable;  
test = false;

if block.InputPort(1).Data == 2  % Survey State
    if phase <= size(SurveyTable,1) && part == 0    % if survey phase isn't completed
        if DronePosN(flightIndex,2) < table2array(SurveyTable.UnrealStopY(phase))   % if min Y has not been reached for the current phase
            block.OutputPort(1).Data = DronePosN(flightIndex,1:2);
            block.OutputPort(2).Data = DronePosN(flightIndex,3);
            flightIndex = flightIndex + 1;
        else
            part = 1;  % return flight when limit reached
            phase = phase + 1;  % ready for next phase
        end
    end
%block.OutputPort(1).Data = block.Dwork(1).Data + block.InputPort(1).Data;
len = size(ShipPosN,1);
if test == true
    block.OutputPort(1).Data = 0;  % X pos [ShipPosN(i,1:2),double(block.InputPort(1).Data(3))];   % X and Y calculated, Z determined by water waves
    block.OutputPort(2).Data = 0;  % Y pos 
    block.OutputPort(3).Data = 0; 
    block.OutputPort(4).Data = 0;
    block.OutputPort(5).Data = 0; 
    block.OutputPort(6).Data = 0;    
else
    if i <= len
%        wlp = [ShipPosN(i,1), ShipPosN(i,2), 1] * tf;
%        wrl = [wlp(2)/wlp(3) wlp(1)/wlp(3)];  % lat and long
%        geoplot(ax, wrl(1), wrl(2), 'o', 'color', 'r');
%        drawnow
        block.OutputPort(1).Data = DronePosN(i,1);  % X pos [ShipPosN(i,1:2),double(block.InputPort(1).Data(3))];   % X and Y calculated, Z determined by water waves
        block.OutputPort(2).Data = DronePosN(i,2);  % Y pos 
        block.OutputPort(3).Data = double(block.InputPort(1).Data(3)); % Z pos inherited from input
        block.OutputPort(4).Data = double(block.InputPort(2).Data(1)); % X rot inherited from input
        block.OutputPort(5).Data = double(block.InputPort(2).Data(2)); % Y rot inherited from input [0, 0, ShipPosN(i,3)];
        block.OutputPort(6).Data = DronePosN(i,3)*pi/180;    % Z rot calculated
        i = i + 1;
    else
        i
%         block.OutputPort(1).Data = ShipPosN(len,1);  % X pos [ShipPosN(i,1:2),double(block.InputPort(1).Data(3))];   % X and Y calculated, Z determined by water waves
%         block.OutputPort(2).Data = ShipPosN(len,2);  % Y pos 
%         block.OutputPort(3).Data = double(block.InputPort(1).Data(3)); % Z pos inherited from input
%         block.OutputPort(4).Data = double(block.InputPort(2).Data(1)); % X rot inherited from input
%         block.OutputPort(5).Data = double(block.InputPort(2).Data(2)); % Y rot inherited from input [0, 0, ShipPosN(i,3)];
%         block.OutputPort(6).Data = ShipPosN(len,3);    % Z rot calculated   
    end
end

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

