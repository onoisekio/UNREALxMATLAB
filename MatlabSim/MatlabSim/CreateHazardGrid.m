function CreateHazardGrid(block, i)
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

% Override input port properties
block.InputPort(1).Dimensions        = 1;  % Vessel geo position
block.InputPort(1).DatatypeID  = 0;  % double
block.InputPort(1).Complexity  = 'Real';
block.InputPort(1).DirectFeedthrough = true;

% % Camera FOV
block.InputPort(2).Dimensions        = [4 2];   % Unreal to World Transform (2,:)
block.InputPort(2).DatatypeID  = 0;  % double
block.InputPort(2).Complexity  = 'Real';
block.InputPort(2).DirectFeedthrough = true;

% % Unreal X Y inputs 
% block.InputPort(3).Dimensions        = 2;    % XY
% block.InputPort(3).DatatypeID  = 1;  % single
% block.InputPort(3).Complexity  = 'Real';
% block.InputPort(3).DirectFeedthrough = true;

% 
% block.InputPort(3).Dimensions        = 3;    % Y
% block.InputPort(3).DatatypeID  = 1;  % single
% block.InputPort(3).Complexity  = 'Real';
% block.InputPort(3).DirectFeedthrough = true;


% Override output port properties
% block.OutputPort(1).Dimensions       = [1 2];    % world to unreal transform
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
block.SampleTimes = [0.0333 0];

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
global ax 
global x
figure,geoplot(block.InputPort(1).Data(2), block.InputPort(1).Data(1), 'o', 'color', 'r');
geolimits([48 50],[-70 -67]);
ax = gca;
x = 1;
%drawnow

%end Start

%%
%% Outputs:
%%   Functionality    : Called to generate block outputs in
%%                      simulation step
%%   Required         : Yes
%%   C MEX counterpart: mdlOutputs
%%
function Outputs(block)
global ax
global x

%wlp = [ShipPosN(i,1), ShipPosN(i,2), 1] * InputPort(1);
%        wrl = [wlp(2)/wlp(3) wlp(1)/wlp(3)];  % lat and long

%patchm(ax,block.InputPort(2).Data(:,2), block.InputPort(2).Data(:,1),'green','FaceAlpha','flat')
hold on
%block.InputPort(2).Data(:,1:2)
if x == 1
geoplot(ax, block.InputPort(2).Data(:,2), block.InputPort(2).Data(:,1),'o', 'color', 'blue');

hold on
geoplot(ax, block.InputPort(1).Data(2), block.InputPort(1).Data(1), 'o', 'color', 'r');

%
geolimits([48 50],[-70 -67]);
x = x + 1;
drawnow
end

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

