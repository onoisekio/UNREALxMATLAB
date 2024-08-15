function LidarProcessingSubsystem(block, i)
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
block.NumOutputPorts = 1;

% Input 1: Greyscale image from camera
% Input 2: Four image corners
% Input 3: Greyscale image
% Input 4: Current State from Controller
% Input 5: Current Substate from PathPlan Subsystem

% Setup port properties to be inherited or dynamic
block.SetPreCompInpPortInfoToDynamic;
block.SetPreCompOutPortInfoToDynamic;
block.AllowSignalsWithMoreThan2D = 1;

% Override input port properties
block.InputPort(1).Dimensions        = [20 21 3];  % input pointcloud
block.InputPort(1).DatatypeID  = 1;  % double 
block.InputPort(1).Complexity  = 'Real';
block.InputPort(1).DirectFeedthrough = true;

% Override input port properties
block.InputPort(2).Dimensions        = [1 6];  % Drone Translation and orientation from PathPlanSubsystem
block.InputPort(2).DatatypeID  = 0;  % single
block.InputPort(2).Complexity  = 'Real';
block.InputPort(2).DirectFeedthrough = true;

block.InputPort(3).Dimensions        = 1;  % Current state from SimulationControl
block.InputPort(3).DatatypeID  = 0;  
block.InputPort(3).Complexity  = 'Real';
block.InputPort(3).DirectFeedthrough = true;

block.InputPort(4).Dimensions        = 1;  % Current survey substate from PathPlanSubsystem
block.InputPort(4).DatatypeID  = 0;  
block.InputPort(4).Complexity  = 'Real';
block.InputPort(4).DirectFeedthrough = true;

block.InputPort(5).Dimensions        = 1;  % Ship categor
block.InputPort(5).DatatypeID  = 0;  % double
block.InputPort(5).Complexity  = 'Real';
block.InputPort(5).DirectFeedthrough = true;

% % Override output port properties
% block.OutputPort(1).Dimensions       = [1944 9];  % coordinates of 20 x 20 pixel image patches
% block.OutputPort(1).DatatypeID  = 0; % double
% block.OutputPort(1).Complexity  = 'Real';
% block.OutputPort(1).SamplingMode = 'Sample';
% 
block.OutputPort(1).Dimensions       = [700 900];
block.OutputPort(1).DatatypeID  = 0; % 
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
global hlSpan
global vlSpan
global lframe
global lCounter
global utogtf  % unreal to occupancy grid transform
global lfov
global  q 
global lsubsample
global LiData
global LiStat
global Multiplier
global iceTable

lframe = 0;
vlSpan = block.InputPort(1).Dimensions(1);
hlSpan = block.InputPort(1).Dimensions(2);
% frame = 1;
lCounter = 1;
q = 1;
lsubsample = 15;


load("SimEnvironment.mat","Env")
% occmap = Env.SmoothOccupancyMap;
utogtf = Env.UnrealToOccupancyGridTform;
lfov = Env.LidarFOV;
LiStat = zeros(size(Env.UniformOccupancyMap));
LiData = LiStat;
LiData(:,:) = 4;
Multiplier = LiStat+4;
iceTable = table2array(Env.ShipIceTable(:,3:9));
% st = block.InputPort(5).Data;
% if st == 3
%     shipCol = iceTable.E_Class;
% elseif st == 4
%     shipCol = iceTable.D_Class;
% elseif st == 5
%     shipCol = iceTable.C_Class;
% elseif st == 6
%     shipCol = iceTable.B_Class;
% elseif st == 7
%     shipCol = iceTable.A_Class;
% elseif st == 8
%     shipCol = iceTable.CAC4_Class;
% elseif st == 9
%     shipCol = iceTable.CAC3_Class;
% end


%end Start

%%
%% Outputs:
%%   Functionality    : Called to generate block outputs in
%%                      simulation step
%%   Required         : Yes
%%   C MEX counterpart: mdlOutputs
%%
function Outputs(block, i)
global hlSpan;
global vlSpan;
global lframe
global XLBounds
global YLBounds
global lState
global lSubstate
global Heights
global imCounter
% global ConcentrationArray
global utogtf
global lfov
global q 
global lsubsample
global LiData
global LiStat
global Multiplier
global iceTable
% 
% hSpan = 80;
% vSpan = 80;
lState = block.InputPort(3).Data;
lSubstate = block.InputPort(4).Data;
% 
if lState == 1      % Post-initialization
    if lSubstate == 2   % Forward motion of the drone
        % collect image frames
        % process image frames
        % update occupancy map
        % save occupancy map
        % notify path planning block
        
        if lframe == lsubsample
            % image and 4 image corners 
           
            p = block.InputPort(2).Data;
            p(6) = 0;

            RotZ = [cos(p(6)) -sin(p(6)) 0;sin(p(6)) cos(p(6)) 0;0 0 1];
            %RotZ = [cos(block.InputPort(2).Data(6)) -sin(block.InputPort(2).Data(6)) 0;sin(block.InputPort(2).Data(6)) cos(block.InputPort(2).Data(6)) 0;0 0 1];
            gdPlane = [0 0 0];
            h = p(1,1:3) - gdPlane;
            %h = block.InputPort(2).Data(1,1:3) - gdPlane;
            dx = h(3)*tan(lfov(1)/2*pi/180);
            dy = h(3)*tan(lfov(2)/2*pi/180);
            b = [p(1) + dx p(2) + dy 0; p(1) + dx p(2) - dy 0;p(1) - dx p(2) - dy 0;p(1) - dx p(2) + dy 0];
% b = [block.InputPort(1).Data(1) + dx block.InputPort(1).Data(2) + dy 0; block.InputPort(1).Data(1) + dx block.InputPort(1).Data(2) - dy 0;block.InputPort(1).Data(1) - dx block.InputPort(1).Data(2) - dy 0;block.InputPort(1).Data(1) - dx block.InputPort(1).Data(2) + dy 0]'
            RectTf = (RotZ*b')';
%RectTf = (RotZ*[block.InputPort(2).Data(1) + dx block.InputPort(2).Data(2) + dy 0; block.InputPort(2).Data(1) + dx block.InputPort(2).Data(2) - dy 0;block.InputPort(2).Data(1) - dx block.InputPort(2).Data(2) - dy 0;block.InputPort(2).Data(1) - dx block.InputPort(2).Data(2) + dy 0]')';
            imX = block.InputPort(1).Data;  % depth information

            A = RectTf(4,1:2);
            B = RectTf(1,1:2);
            C = RectTf(2,1:2);
            D = RectTf(3,1:2);
%             hlSpan
%             figure,plot(A(1),A(2),'*','Color','r');
%             hold on
%             plot(p(1),p(2),'+','Color','m');
%             
%             plot(B(1),B(2),'*','Color','b')
%             plot(C(1),C(2),'*','Color','k')
%             plot(D(1),D(2),'*','Color','g')
%             set(gca,'YDir','reverse')

            % Horizontal and vertical Divisions 
            xDC = linspace(D(1),C(1),hlSpan+1);
            yDC = linspace(D(2),C(2),hlSpan+1);
            xAB = linspace(A(1),B(1),hlSpan+1);
            yAB = linspace(A(2),B(2),hlSpan+1);
            
            XLBounds = zeros(vlSpan+1,hlSpan+1); % Ice boundaries
            YLBounds = zeros(vlSpan+1,hlSpan+1);
            Heights = zeros(vlSpan,hlSpan); % Ice con
%             IceTypes = zeros(vSpan,hSpan);
            
%             figure,plot([A(1),B(1),C(1),D(1),A(1)],[A(2),B(2),C(2),D(2),A(2)])
%             hold on
            % Create a grid of image patches
            for i = 1:size(XLBounds,2)
                x = linspace(xDC(i),xAB(i),vlSpan+1);
                XLBounds(:,i) = x';
                y = linspace(yDC(i),yAB(i),vlSpan+1);
                YLBounds(:,i) = y';
%                 plot(XLBounds(:,i),YLBounds(:,i),'.')
        %         hold on
            end
%             HeightStruct(imCounter).XBounds = XLBounds;
%             HeightStruct(imCounter).YBounds = YLBounds;
            % pass image patches through classifier network

            i = 1;
            
            while i <= vlSpan
                j = 1;
                while j <= hlSpan
                    if ~isnan(imX(i,j))
                        Heights(i,j) = h(3) - imX(i,j,1);
                    end
                    j = j + 1;
                end
                i = i + 1;
            end
%             HeightStruct(imCounter).Heights = Heights;

            % Unroll coordinate arrays and transform to occupancy grid
            % coordinates
            occArray = utogtf * [reshape(XLBounds,1,(vlSpan+1)*(hlSpan+1));reshape(YLBounds,1,(vlSpan+1)*(hlSpan+1));ones(1,(vlSpan+1)*(hlSpan+1))];
            occArrayX = reshape(occArray(1,:),vlSpan+1,hlSpan+1);
            occArrayY = reshape(occArray(2,:),vlSpan+1,hlSpan+1);
            occArrayC = round(occArrayX + 1);   % transform x,y occupancy array coordinates to row and column occupancy image coordinates
            occArrayR = round(700 - occArrayY);
            
            

            for i = 1:vlSpan
                rmin = min(occArrayR(i,1),occArrayR(i+1,1));
                rmax = max(occArrayR(i,1),occArrayR(i+1,1));
                for j = 1:hlSpan
                    cmin = min(occArrayC(1,j),occArrayC(1,j+1));
                    cmax = max(occArrayC(1,j),occArrayC(1,j+1));
                    if imCounter == 1
                        LiData(rmin:rmax,cmin:cmax) = Heights(i,j);  % Record Heights
                    else
                        LiData(rmin:rmax,cmin:cmax) = LiData(rmin:rmax,cmin:cmax) + Heights(i,j);  % Record Heights
                    end
                    LiStat(rmin:rmax,cmin:cmax) = LiStat(rmin:rmax,cmin:cmax) + 1;                    % Record number of entries for each
                    depth = 3*Heights(i,j);
                    %depth = Heights(i,j);
                    sIndex = block.InputPort(5).Data-2;
                    mIndex = 8;
                    if depth > 1.70
                        mIndex = 1;
                    elseif depth >= 1.20 && depth < 1.70
                        mIndex = 2;
                    elseif depth >= .70 && depth < 1.20
                        mIndex = 3;
                    elseif depth >= .30 && depth < .70
                        mIndex = 4;
                    elseif depth >= .15 && depth < .30
                        mIndex = 5;
                    elseif depth >= .10 && depth < .15
                        mIndex = 6;
                    elseif depth >= 0 && depth < .10
                        mIndex = 7;
                    end
                    Multiplier(rmin:rmax,cmin:cmax) = iceTable(mIndex,sIndex);
                end
            end
            imCounter = imCounter + 1;
            lframe = -1;
        end 
%         State
%         Substate
%         frame
        lframe = lframe + 1;
    end
elseif lState == 2
    save("Heights.mat", "Heights");
    St = LiStat == 0;
    Li = LiStat + St;
    LiData = LiData./Li;  % Obtain average height in each patch
    block.OutputPort(1).Data = Multiplier;

%     if q == 1
%        
% 
%         save('LiData.mat','LiData')
%     elseif q == 2
%         save('Multipliers.mat','Multiplier')
%         figure,imagesc(Multiplier)
%         
%     end
%       figure,imagesc(LiData)  
%     q= q + 1; 
%     end

    imCounter = 1;
end


%end Outputs

function out = classify(depth,ship)
global iceTable

colTable = iceTable(:,ship); 
if depth >= iceTable.Thickness(1)
    out = table2array(colTable(1,1));
elseif depth < iceTable.Thickness(8)
    out = table2array(colTable(8,1));
else
    m = 1;
    success = 0;
    while success ==0 && m < size(iceTable,1)
        if depth >= iceTable.Thickness(m+1) && depth < iceTable.Thickness(m)
            success = 1;
            out = table2array(colTable(m,1));
        end
        m = m + 1;
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

