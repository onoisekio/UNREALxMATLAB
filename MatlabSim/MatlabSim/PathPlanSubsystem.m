function PathPlanSubsystem(block, i)
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
block.NumInputPorts  = 5;
block.NumOutputPorts = 15;

%% Inputs
% 1:
% 2:
% 3:
% 4:

%% Outputs
% 1:
% 2:
% 3:
% 4:
% 5:

% Setup port properties to be inherited or dynamic
block.SetPreCompInpPortInfoToDynamic;
block.SetPreCompOutPortInfoToDynamic;

% Override input port properties
block.InputPort(1).Dimensions        = 3;  % Location
block.InputPort(1).DatatypeID  = 1;  % single
block.InputPort(1).Complexity  = 'Real';
block.InputPort(1).DirectFeedthrough = true;

block.InputPort(2).Dimensions        = 3;  % Rotation
block.InputPort(2).DatatypeID  = 1;  % single
block.InputPort(2).Complexity  = 'Real';
block.InputPort(2).DirectFeedthrough = true;

block.InputPort(3).Dimensions        = 3;  % Scale
block.InputPort(3).DatatypeID  = 1;  % single
block.InputPort(3).Complexity  = 'Real';
block.InputPort(3).DirectFeedthrough = true;

block.InputPort(4).Dimensions        = 1;     % State from Control Block
block.InputPort(4).DatatypeID  = 0; 
block.InputPort(4).Complexity  = 'Real';
block.InputPort(4).DirectFeedthrough = true;

block.InputPort(5).Dimensions        = 1;     % State from Image Processing Subsystem
block.InputPort(5).DatatypeID  = 0;  % unit8
block.InputPort(5).Complexity  = 'Real';
block.InputPort(5).DirectFeedthrough = true;


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
block.OutputPort(7).Dimensions       = 1;
block.OutputPort(7).DatatypeID  = 0; % double
block.OutputPort(7).Complexity  = 'Real';
block.OutputPort(7).SamplingMode  = 'Sample';

block.OutputPort(8).Dimensions       = 1;
block.OutputPort(8).DatatypeID  = 0; % double
block.OutputPort(8).Complexity  = 'Real';
block.OutputPort(8).SamplingMode  = 'Sample';

block.OutputPort(9).Dimensions       = 1;
block.OutputPort(9).DatatypeID  = 0; % double
block.OutputPort(9).Complexity  = 'Real';
block.OutputPort(9).SamplingMode  = 'Sample';

block.OutputPort(10).Dimensions       = 1;
block.OutputPort(10).DatatypeID  = 0; % double
block.OutputPort(10).Complexity  = 'Real';
block.OutputPort(10).SamplingMode  = 'Sample';

block.OutputPort(11).Dimensions       = 1;
block.OutputPort(11).DatatypeID  = 0; % double
block.OutputPort(11).Complexity  = 'Real';
block.OutputPort(11).SamplingMode  = 'Sample';

block.OutputPort(12).Dimensions       = 1;
block.OutputPort(12).DatatypeID  = 0; % double
block.OutputPort(12).Complexity  = 'Real';
block.OutputPort(12).SamplingMode  = 'Sample';

block.OutputPort(12).Dimensions       = 1;
block.OutputPort(12).DatatypeID  = 0; % double
block.OutputPort(12).Complexity  = 'Real';
block.OutputPort(12).SamplingMode  = 'Sample';

block.OutputPort(13).Dimensions       = 1;
block.OutputPort(13).DatatypeID  = 0; 
block.OutputPort(13).Complexity  = 'Real';
block.OutputPort(13).SamplingMode  = 'Sample';

block.OutputPort(14).Dimensions       = 1;
block.OutputPort(14).DatatypeID  = 0; 
block.OutputPort(14).Complexity  = 'Real';
block.OutputPort(14).SamplingMode  = 'Sample';

block.OutputPort(15).Dimensions       = 1;
block.OutputPort(15).DatatypeID  = 0; 
block.OutputPort(15).Complexity  = 'Real';
block.OutputPort(15).SamplingMode  = 'Sample';
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
%block.RegBlockMethod('CalculatePath', @CalculatePath);
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
function path = CalculateDronePath(startPt,EndPt,speed)
    m = (EndPt(2)-startPt(2))/(EndPt(1)-startPt(1));   %line gradient
    fr = 30;
    dx = speed/fr;   % distance per frame
    x = startPt(1):dx:EndPt(1);
    x = x';
    th = x;
    y = m*(x-startPt(1)) + startPt(2);
    th(:,1) = pi/4;%atan(m);
    path = [x,y,th];

function path = CalculateShipPath(startPt,EndPt,speed,U2Otf,O2Utf,mapGrid)
global E;

    mm = occupancyMap(mapGrid,1);
    %figure,show(mm)
    figure,imshow(mapGrid)
%     transform points to occupancy map coordinates
    startO = [U2Otf * [startPt(1);startPt(2);1];startPt(3)];
    finO =  [U2Otf * [EndPt(1);EndPt(2);1];EndPt(3)];
    startO = startO';
    finO = finO';

    % map bounds
    bounds = [mm.XWorldLimits; mm.YWorldLimits; [-pi pi]];
    % state space dubins
    ss = stateSpaceDubins(bounds);
    ss.MinTurningRadius = 10;

    stateValidator = validatorOccupancyMap(ss); 
    
    stateValidator.Map = occupancyMap(mm);   %mm = occupancyMap(map,5);
    %mm
    stateValidator.ValidationDistance = 1;
    planner = plannerRRT(ss,stateValidator);
    planner.MaxConnectionDistance = 10.0;
    planner.MaxIterations = 30000;
    planner.GoalReachedFcn = @exampleHelperCheckIfGoal;

    % rng default
    Err = false;
    try
        [pthObj, ~] = plan(planner,startO,finO);
        size(pthObj.States)
    catch
        Err = true;
    end
    if ~Err   %no error
        figure
        show(mm)

        hold on
%         size(pthObj.States)
        plot(pthObj.States(:,1), pthObj.States(:,2),'k-', 'LineWidth', 2)
        hold off
       
        len = size(pthObj.States,1);
        Ship=O2Utf*[pthObj.States(:,1:2)';ones(1,len)];
        ShipPos = [Ship(1,:)', Ship(2,:)', pthObj.States(:,3)];
        k = 1;
        ft = 1/30;   % frame time
        path = zeros(1,3);

        for j = 1:len-1
            ds = sqrt((ShipPos(j+1,1)-ShipPos(j,1))^2 + (ShipPos(j+1,2)-ShipPos(j,2))^2); % st line distance between start and end points
            dt = ds/speed; % time to travel the line
            N = dt/ft; % distance travelled
            dx = (ShipPos(j+1,1) - ShipPos(j,1))/N;
            dy = (ShipPos(j+1,2) - ShipPos(j,2))/N;
            dTh = atan(dy/dx);%(ShipPos(j+1,3) - ShipPos(j,3))/N; % rotation change
            x = ShipPos(j,1);
            y = ShipPos(j,2);
            %Th = ShipPos(j,3);
            path(k,:) = ShipPos(j,1:3);
            x = x + dx;
            y = y + dy;
            Th = dTh; %+ Th
            k = k + 1;
        
            if dx < 0  % x2 < x1
                while x > ShipPos(j+1,1)
                    y = ((ShipPos(j+1,2)-ShipPos(j,2))/(ShipPos(j+1,1)-ShipPos(j,1)))*(x-ShipPos(j,1)) + ShipPos(j,2);
                    path(k,:) = [x,y,Th];
                    k = k + 1;
                    x = x + dx;
                    %Th = dTh;
                end
            elseif dx > 0
                while x < ShipPos(j+1,1)
                    y = ((ShipPos(j+1,2)-ShipPos(j,2))/(ShipPos(j+1,1)-ShipPos(j,1)))*(x-ShipPos(j,1)) + ShipPos(j,2);
                    path(k,:) = [x,y,Th];
                    k = k + 1;
                    x = x + dx;
                    %Th = dTh;
                end
            else
                if dy < 0
                    while y > ShipPos(j+1,2)
                        path(k,:) = [x,y,Th];
                        y = y + dy;
                        %Th = dTh;
                        k = k + 1;
                    end
                else
                    while y < ShipPos(j+1,2)
                        path(k,:) = [x,y,Th];
                        y = y + dy;
                        %Th = dTh;
                        k = k + 1;
                    end
                end
            end
            path(k,:) = [ShipPos(j+1,1:3)];
            %ShipPosN(k,:) = [ShipPos(j+1,1:3)];
            k = k + 1;
        end
        
    else
        path = -1;
    end

function positionShip(block, Loc, Rot)
    block.OutputPort(1).Data = Loc(1);  %x
    block.OutputPort(2).Data = Loc(2);
    block.OutputPort(3).Data = 3;%100;
    block.OutputPort(4).Data = 0;
    block.OutputPort(5).Data = 0;
    block.OutputPort(6).Data = Rot(3);%*180/pi;

function positionDrone(block, Loc, Rot)
    block.OutputPort(7).Data = Loc(1);
    block.OutputPort(8).Data = Loc(2);
    block.OutputPort(9).Data = 100;
    block.OutputPort(10).Data = 0;
    block.OutputPort(11).Data = 0;
    block.OutputPort(12).Data = Rot(3);%*180/pi;

 
% % Transform path to unreal coordinates and convert to time series
% len = size(pthObj.States,1);
% dur = 10;
% t = 1/len*dur;
% time = 0:t:dur-t;
% 
% Ship = env.Env.OccupancyGridToUnrealTform * [pthObj.States(:,1:2)';ones(1,len)];
% ShipPos = [Ship(1,:)', Ship(2,:)', pthObj.States(:,3)];

%%%%%%%%%%%%
% DS = sqrt((ShipPos(end,1)-ShipPos(1,1))^2 + (ShipPos(end,2)-ShipPos(1,2))^2);
% dt = 600;
% v = 1;  % speed
% ft = 1/30;  % frame period
% k = 1;
% ShipPosN = zeros(1,3);
% DronePosN = Env.DroneSurveyPath; 




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
 block.OutputPort(7).SamplingMode = fd;
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
global ShipPosN;
global DronePosN;
%global ax;
%global tf;
global changeState;  
global E;
global State;  % Current state
global region; % current region
global surveySubstate
global shipPathIndex
global pathPlanSubstate  % ship path plan states
global occMap
global dronePathIndex
global dStartPt
global sStartPt

ShipPosN = zeros(1,3);
DronePosN = zeros(1,3);

i = 1;
shipPathIndex = 1;
dronePathIndex = 1;
changeState = 0;  % Indicator to change state
load('SimEnvironment.mat','Env');
E = Env; 
State = block.InputPort(4).Data;
block.OutputPort(13).Data = changeState;
block.OutputPort(15).Data = 0; % ship path not updated

region = 1;
surveySubstate = 0;
pathPlanSubstate = 0;
%startPt
sStartPt = [E.UnrealEndPoints(region,:), pi/4];
ShipPosN(shipPathIndex,:) = sStartPt;
dStartPt = E.UnrealEndPoints(region,:);
DronePosN(dronePathIndex,:) = [dStartPt,0];
positionDrone(block,[DronePosN(dronePathIndex,1:2),0],[0,0,DronePosN(dronePathIndex,3)]);
positionShip(block,[ShipPosN(shipPathIndex,1:2),100],[0,0,ShipPosN(shipPathIndex,3)]);


%end Start


%%
%% Outputs:
%%   Functionality    : Called to generate block outputs in
%%                      simulation step
%%   Required         : Yes
%%   C MEX counterpart: mdlOutputs
%%
function Outputs(block)
global ShipPosN;
global DronePosN;
global changeState;
global State;
global region;  % current region
global E;    % environment
global surveySubstate;
global dronePathIndex;
global shipPathIndex;
global pathPlanSubstate
global dStartPt
global sStartPt
global dStopPt
global sStopPt

% port 1 2 3 4 5 6 = Ship x, y, z, rotx, roty rotz;
% port 7 8 9 10 11 12 = drone x, y, z, rotx, roty rotz;
% port 13 = changestate logic

% State
State = block.InputPort(4).Data;

%surveySubstate
block.OutputPort(13).Data = changeState;
block.OutputPort(14).Data = surveySubstate;
changeState = 0;

if State == 0 
     %% Overall initialization state
    shipPathIndex = 1;
    dronePathIndex = 1;
%     State = 1;
    
elseif State == 1  
    pathPlanSubstate = 0;    % reset path planning

    %% Drone survey state
    if surveySubstate == 0   
        % Appropriate output for drone
        surveySubstate = 1;

    elseif surveySubstate == 1   % Calculate drone survey path
        % Calculate survey path
        if region < size(E.UnrealEndPoints,1)
            dStartPt = ShipPosN(shipPathIndex,1:2); %E.UnrealEndPoints(region,:);  % Starting region point  % change this to accommodate ship path
            dStopPt = E.UnrealEndPoints(region+1,:);   % ending region point
            DronePosN = CalculateDronePath(dStartPt,dStopPt,E.DroneSpeed);
            surveySubstate = 2;  %move to next substate
            dronePathIndex = 1;
        end

    elseif surveySubstate == 2   % Move drone through survey path
        % Move forward through path
        if dronePathIndex <= size(DronePosN,1)
            positionDrone(block, [DronePosN(dronePathIndex,1:2),0],[0,0,DronePosN(dronePathIndex,3)]);
            dronePathIndex = dronePathIndex + 1;
            if dronePathIndex >= size(DronePosN,1)
                surveySubstate = 3;
                dronePathIndex = 1;
            end
        else
            dronePathIndex = 1;
            surveySubstate = 3;  % conclude survey
        end
    elseif surveySubstate == 3
        surveySubstate = 0;   % surveySubstate = 3. Reset drone parameters
        changeState = 1;  % State 1 completed, State change permitted
        region = region + 1;
    end
    
elseif State == 2
    %% Calculate path for ship from current position and update its path
    if block.InputPort(5).Data == 1   % Updated Occupancy map available
        if pathPlanSubstate == 0          % Load the occupancy map from storage and plan ship path
            sStartPt = ShipPosN(shipPathIndex,:);
            sStopPt = [E.UnrealEndPoints(region,:),0];

            load('OccupancyMap.mat','map');
            load('BlackMap.mat','blackmap');
            
            ShipPosN = CalculateShipPath(sStartPt, sStopPt, E.ShipSpeed, E.UnrealToOccupancyGridTform, E.OccupancyGridToUnrealTform, blackmap);
            shipPathIndex = 1;
%             size(ShipPosN,1)
            pathPlanSubstate = 1;
            size(ShipPosN)
            ShipPos = [ShipPosN(:,1:2),ones(size(ShipPosN,1),1)];
            ShipPosW = ShipPos*E.UnrealToWorldTform;
            ShipPosW(:,1) = ShipPosW(:,1)./ShipPosW(:,3);
            ShipPosW(:,2) = ShipPosW(:,2)./ShipPosW(:,3);
            ShipPosCumulative = ShipPosW;
            save('ShipPath.mat','ShipPosN','ShipPosW')  % Save the calculated path
            block.OutputPort(15).Data = 1;  % Ship path updated signal to HazardMapDisplay

        elseif pathPlanSubstate == 1   % Move ship if there is a clear path to destination     
            if ShipPosN == -1
                % Indicate to Simulation Control to End voyage
            else % move ship towards destination
                % keep state constant as long as time to do the next survey has
                % not reached, change state otherwise
                % Change to relevant state 
                if shipPathIndex <= size(ShipPosN,1)
                    changeState = 0;   % Do not change state
                    positionShip(block,[ShipPosN(shipPathIndex,1:2),0],[0,0,ShipPosN(shipPathIndex,3)]);
                    shipPathIndex = shipPathIndex + 1;
                    if shipPathIndex >= size(ShipPosN,1)*.95 && region < size(E.UnrealEndPoints,1) % Time to do next survey 
                        changeState = -1;  % return to survey state
                        surveySubstate = 1;
%                         shipPathIndex
%                         surveySubstate
%                         region
                        dStartPt = ShipPosN(shipPathIndex,1:2);
                        dStopPt = E.UnrealEndPoints(region+1,:);
                        DronePosN = [ShipPosN(shipPathIndex,1:2),0];
%                         ShipPosN(shipPathIn;dex,:)
                    end
                else  % completed the path
                    changeState = 1;  % Proceed to state 3 and conclude voyage

                end
    %             State = uint8(1);
            end
        end
    end

elseif State == 3

elseif State == 4

else

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


