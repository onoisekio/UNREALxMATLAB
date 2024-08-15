function ImageProcessingSubsystem(block, i)
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

% Override input port properties
block.InputPort(1).Dimensions        = [720 1280];  % input image
block.InputPort(1).DatatypeID  = 1;  % single
block.InputPort(1).Complexity  = 'Real';
block.InputPort(1).DirectFeedthrough = true;

% Override input port properties
block.InputPort(2).Dimensions        = [1 6];  % Drone Translation and orientation
block.InputPort(2).DatatypeID  = 0;  % single
block.InputPort(2).Complexity  = 'Real';
block.InputPort(2).DirectFeedthrough = true;

block.InputPort(3).Dimensions        = [4 2];
block.InputPort(3).DatatypeID  = 1;  % single
block.InputPort(3).Complexity  = 'Real';
block.InputPort(3).DirectFeedthrough = true;

block.InputPort(4).Dimensions        = 1;
block.InputPort(4).DatatypeID  = 0; 
block.InputPort(4).Complexity  = 'Real';
block.InputPort(4).DirectFeedthrough = true;

block.InputPort(5).Dimensions        = 1;
block.InputPort(5).DatatypeID  = 0;  
block.InputPort(5).Complexity  = 'Real';
block.InputPort(5).DirectFeedthrough = true;

% % Override output port properties
% block.OutputPort(1).Dimensions       = [1944 9];  % coordinates of 20 x 20 pixel image patches
% block.OutputPort(1).DatatypeID  = 0; % double
% block.OutputPort(1).Complexity  = 'Real';
% block.OutputPort(1).SamplingMode = 'Sample';
% 
block.OutputPort(1).Dimensions       = [700 900];
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
end

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
  end



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
end


function SetInputPortSamplingMode(block, idx, fd)
 block.InputPort(idx).SamplingMode = fd;
  block.OutputPort(1).SamplingMode  = fd;
%   block.OutputPort(2).SamplingMode = fd;

%end SetInputPortSamplingMode
end


%%
%% Start:
%%   Functionality    : Called once at start of model execution. If you
%%                      have states that should be initialized once, this 
%%                      is the place to do it.
%%   Required         : No
%%   C MEX counterpart: mdlStart
%%
function Start(block)
global hStep
global vStep
global hSpan
global vSpan
global frame
global HLines    % Horizontal line parameters
global VLines    % Vertical line parameters
global Boundaries  
global imCounter
global utogtf  % unreal to occupancy grid transform
global fov
global  k 
global subsample
global ImData       % current occupancy map data
global ImStat       % number of occupancy map updates 
global mask 
global imcnt

% frame = 0;
hStep = 64;
vStep = 36;
vSpan = block.InputPort(1).Dimensions(1)/vStep;
hSpan = block.InputPort(1).Dimensions(2)/hStep;
frame = 1;
imCounter = 1;
k = 1;
subsample = 15;

HLines = zeros(vSpan + 1,2); %Lines formed by joining points from lines AD and BC
VLines = zeros(hSpan + 1,2); %Lines formed by joining points from lines CD and AB
Boundaries =zeros(4,2,hSpan*vSpan);  %h and v coordinates of points forming boundaries
%ConcentrationStruct = struct('XBounds',[],'YBounds',[],'OccupX',[],'OccupY',[],'OccupC',[],'OccupR',[],'Concentrations',[]);

load("SimEnvironment.mat","Env")

utogtf = Env.UnrealToOccupancyGridTform;
fov = Env.CameraFOV;
ImStat = zeros(size(Env.UniformOccupancyMap));
ImData = ImStat;
ImData(:,:) = -4;
% mask = ImStat;
% mask(:,:) = nan;


%end Start
end


%%
%% Outputs:
%%   Functionality    : Called to generate block outputs in
%%                      simulation step
%%   Required         : Yes
%%   C MEX counterpart: mdlOutputs
%%
function Outputs(block, i)
global hStep;
global vStep;
global hSpan;
global vSpan;
global frame
global XBounds
global YBounds
global State
global Substate
global Concentrations
global IceTypes
global imCounter
global utogtf
global fov
global k 
global subsample
global ImData
global ImStat
global mask 

%hSpan = 80;
%vSpan = 80;
State = block.InputPort(4).Data;
Substate = block.InputPort(5).Data;

if State == 1      % Post-initialization
    if Substate == 2   % Forward motion of the drone
        % collect image frames
        % process image frames
        % update occupancy map
        % save occupancy map
        % notify path planning block
        
        if frame == subsample
            % image and 4 image corners 
           
            p = block.InputPort(2).Data;
            p(6) = 0;
%              if k == 1
%                 p
%                 k = k + 1;
%              end
            RotZ = [cos(p(6)) -sin(p(6)) 0;sin(p(6)) cos(p(6)) 0;0 0 1];
            %RotZ = [cos(block.InputPort(2).Data(6)) -sin(block.InputPort(2).Data(6)) 0;sin(block.InputPort(2).Data(6)) cos(block.InputPort(2).Data(6)) 0;0 0 1];
            gdPlane = [0 0 0];
            h = p(1,1:3) - gdPlane;
            %h = block.InputPort(2).Data(1,1:3) - gdPlane;
            dx = h(3)*tan(fov(1)/2*pi/180);
            dy = h(3)*tan(fov(2)/2*pi/180);
            b = [p(1) + dx p(2) + dy 0; p(1) + dx p(2) - dy 0;p(1) - dx p(2) - dy 0;p(1) - dx p(2) + dy 0];
% b = [block.InputPort(1).Data(1) + dx block.InputPort(1).Data(2) + dy 0; block.InputPort(1).Data(1) + dx block.InputPort(1).Data(2) - dy 0;block.InputPort(1).Data(1) - dx block.InputPort(1).Data(2) - dy 0;block.InputPort(1).Data(1) - dx block.InputPort(1).Data(2) + dy 0]'
            RectTf = (RotZ*b')';
%RectTf = (RotZ*[block.InputPort(2).Data(1) + dx block.InputPort(2).Data(2) + dy 0; block.InputPort(2).Data(1) + dx block.InputPort(2).Data(2) - dy 0;block.InputPort(2).Data(1) - dx block.InputPort(2).Data(2) - dy 0;block.InputPort(2).Data(1) - dx block.InputPort(2).Data(2) + dy 0]')';
            im = block.InputPort(1).Data; 

            A = RectTf(4,1:2);
            B = RectTf(1,1:2);
            C = RectTf(2,1:2);
            D = RectTf(3,1:2);
%             figure,plot(A(1),A(2),'*','Color','r');
%             hold on
%             plot(p(1),p(2),'+','Color','m');
%             
%             plot(B(1),B(2),'*','Color','b')
%             plot(C(1),C(2),'*','Color','k')
%             plot(D(1),D(2),'*','Color','g')
%             set(gca,'YDir','reverse')

            % Horizontal and vertical Divisions 
            xDC = linspace(D(1),C(1),hSpan+1);
            yDC = linspace(D(2),C(2),hSpan+1);
            xAB = linspace(A(1),B(1),hSpan+1);
            yAB = linspace(A(2),B(2),hSpan+1);
            
            XBounds = zeros(vSpan+1,hSpan+1); % Ice boundaries
            YBounds = zeros(vSpan+1,hSpan+1);
            Concentrations = zeros(vSpan,hSpan); % Ice con
            IceTypes = zeros(vSpan,hSpan);
            
%             figure,plot([A(1),B(1),C(1),D(1),A(1)],[A(2),B(2),C(2),D(2),A(2)])
%             hold on
            % Create a grid of image patches
            for i = 1:size(XBounds,2)
                x = linspace(xDC(i),xAB(i),vSpan+1);
                XBounds(:,i) = x';
                y = linspace(yDC(i),yAB(i),vSpan+1);
                YBounds(:,i) = y';
%                 plot(XBounds(:,i),YBounds(:,i),'.')
        %         hold on
            end
            % pass image patches through classifier network
            i = 1;
            while i <= vSpan
                startV = (i-1)*vStep + 1;
                stopV = i*vStep;
                j = 1;
                while j <= hSpan
                    startH = (j-1)*hStep + 1;
                    stopH = j*hStep;
                    %X = 
                    template = im(startV:stopV,startH:stopH);
                    bw = mean(mean(template));
                    %val = bw*0.0069 - 0.0049;
                    val = 0.9768/(1+exp(-0.0344*(bw-103.5679)));
                    val(val > 1) = 1;
                    %pass template through classifier and obtain the ice type
                    Concentrations(i,j) = val; %floor(11*rand(1,1))/10;
                    %IceTypes(i,j) = ceil(8*rand(1,1));

                    j = j + 1;
                end
                i = i + 1;
            end

            % Unroll coordinate arrays and transform to occupancy grid
            % coordinates
            occArray = utogtf * [reshape(XBounds,1,(vSpan+1)*(hSpan+1));reshape(YBounds,1,(vSpan+1)*(hSpan+1));ones(1,(vSpan+1)*(hSpan+1))];
            occArrayX = reshape(occArray(1,:),vSpan+1,hSpan+1);
            occArrayY = reshape(occArray(2,:),vSpan+1,hSpan+1);
            occArrayC = round(occArrayX + 1);   % transform x,y occupancy array coordinates to row and column occupancy image coordinates
            occArrayR = round(700 - occArrayY);
%             colMin = min(occArrayC(1,1), occArrayC(1,hSpan+1));
%             colMax = max(occArrayC(1,1), occArrayC(1,hSpan+1));
%             rowMin = min(occArrayR(1,1), occArrayR(vSpan+1,1));
%             rowMax = max(occArrayR(1,1), occArrayR(vSpan+1,1));

            for i = 1:vSpan
                rmin = min(occArrayR(i,1),occArrayR(i+1,1));
                rmax = max(occArrayR(i,1),occArrayR(i+1,1));
                for j = 1:hSpan
                    cmin = min(occArrayC(1,j),occArrayC(1,j+1));
                    cmax = max(occArrayC(1,j),occArrayC(1,j+1));
                    if imCounter == 1
                        ImData(rmin:rmax,cmin:cmax) = Concentrations(i,j);  % Record concentrations
                    else
                        ImData(rmin:rmax,cmin:cmax) = ImData(rmin:rmax,cmin:cmax) + Concentrations(i,j);  % Record concentrations
                    end
                    ImStat(rmin:rmax,cmin:cmax) = ImStat(rmin:rmax,cmin:cmax) + 1;                    % Record number of entries for each
%                     mask(rmin:rmax,cmin:cmax) = 1;
                end
            end

            imCounter = imCounter + 1;
            frame = -1;
        end 
        frame = frame + 1;
    end
elseif State == 2
    St = ImStat == 0;
    ImStat = ImStat + St;
    ImData = ImData./ImStat;
    block.OutputPort(1).Data = ImData;
    ImStat(:,:) = 0;
    imCounter = 1;

    % Debug %
%     if k == 1
%         figure,imshow(ImData)
%         k = k + 1;
%     end
%     State
%     imCounter
%     save('SurveyImages.mat','ConcentrationStruct');
%     save('PixelConcSummary.mat','pixelConc')
end
   
%end Outputs
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
end

%%
%% Derivatives:
%%   Functionality    : Called to update derivatives of
%%                      continuous states during simulation step
%%   Required         : No
%%   C MEX counterpart: mdlDerivatives
%%
function Derivatives(block)

%end Derivatives
end

%%
%% Terminate:
%%   Functionality    : Called at the end of simulation for cleanup
%%   Required         : Yes
%%   C MEX counterpart: mdlTerminate
%%
%function PlanPath(block, )
function Terminate(block)

%end Terminate
end
end