function DataFusionSubsystem(block, i)
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
block.NumOutputPorts = 1;

% Input 1: Greyscale image from camera
% Input 2: Four image corners
% Input 3: Greyscale image
% Input 4: Current State from Controller
% Input 5: Current Substate from PathPlan Subsystem

% Setup port properties to be inherited or dynamic
block.SetPreCompInpPortInfoToDynamic;
block.SetPreCompOutPortInfoToDynamic;


block.InputPort(1).Dimensions        = [700 900];
block.InputPort(1).DatatypeID  = 0;  % double
block.InputPort(1).Complexity  = 'Real';
block.InputPort(1).DirectFeedthrough = true;

block.InputPort(2).Dimensions        = 1;
block.InputPort(2).DatatypeID  = 0;  
block.InputPort(2).Complexity  = 'Real';
block.InputPort(2).DirectFeedthrough = true;

block.InputPort(3).Dimensions        = [700 900];
block.InputPort(3).DatatypeID  = 0;  
block.InputPort(3).Complexity  = 'Real';
block.InputPort(3).DirectFeedthrough = true;




% % Override output port properties
% block.OutputPort(1).Dimensions       = [1944 9];  % coordinates of 20 x 20 pixel image patches
% block.OutputPort(1).DatatypeID  = 0; % double
% block.OutputPort(1).Complexity  = 'Real';
% block.OutputPort(1).SamplingMode = 'Sample';
% 
block.OutputPort(1).Dimensions       = 1;
block.OutputPort(1).DatatypeID  = 0; 
block.OutputPort(1).Complexity  = 'Real';
block.OutputPort(1).SamplingMode = 'Sample';

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
%   block.OutputPort(2).SamplingMode = fd;
%    block.OutputPort(3).SamplingMode = fd;
%     block.OutputPort(4).SamplingMode = fd;

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
global cnt
global Ee

load('SimEnvironment.mat','Env')
Ee = Env.HazardMapShading1;

cnt = 1;

block.OutputPort(1).Data = 0;
%end Start

%%
%% Outputs:
%%   Functionality    : Called to generate block outputs in
%%                      simulation step
%%   Required         : Yes
%%   C MEX counterpart: mdlOutputs
%%
function Outputs(block, i)
global cnt

if block.InputPort(2).Data == 2    % Current State = 2
    if cnt == 1
        occMap = block.InputPort(1).Data .* block.InputPort(3).Data;  % Array of ice numerals
        outMap = IceNumeralToColour(occMap);
        save('OccMap.mat','outMap')
        save('OccMapIn.mat','occMap')
%         mask = block.InputPort(4).Data;
%         save('Mask.mat','mask')
%         occMap= occMap + mask;
%         
        %min(min(occMap))
        map = IceNumeralToOccupancy(occMap);
        %min(min(map))
        save('OccupancyMap.mat','map')
        block.OutputPort(1).Data = 1;     % Activate input(5) of PathPlan Sub 
         %figure,imshow(map)
        cnt = cnt + 1;
    end
else
    block.OutputPort(1).Data = 0;
    cnt = 1;
end

function outMap = IceNumeralToOccupancy(inMap)
% Map IceNumeral Values to Occupancy map values
outMap = 1./(1+exp((4*inMap) + 1.4));%inMap*0;
%end Outputs

function outMap = IceNumeralToColour(inMap)
global Ee
outMap = Ee;
for i = 1:size(outMap,1)
    if inMap(outMap(i,1),outMap(i,2)) < 0
        outMap(i,5:7) = [1,0,0];  % Red
    elseif inMap(outMap(i,1),outMap(i,2)) >= 0 && inMap(outMap(i,1),outMap(i,2)) < 1
        outMap(i,5:7) = [1,1,0];  % Yellow
    elseif inMap(outMap(i,1),outMap(i,2)) >= 1 && inMap(outMap(i,1),outMap(i,2)) < 3
        outMap(i,5:7) = [0,1,0];  % Green
    else
        outMap(i,5:7) = [0,0,1];  % Blue
    end
end

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

