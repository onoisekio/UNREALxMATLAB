%% MATLAB UAV Simulation Example
% This example shows how to use the UAV scenario blocks to simulate a scenario in Simulink®.

% Create Scenario
% Initialize your UAV scenario with meshes and uavPlatform objects for the UAV scenario blocks to use.

% Initialize the scenario 
scene = uavScenario(UpdateRate=100,ReferenceLocation=[0 0 0]);

%Create a ground for visualization
addMesh(scene,"polygon",{[-15 -15; 15 -15; 15 15; -15 15] [-0.5 0]},[0.3 0.3 0.3]);

% Add cylinder meshes to scan with lidar sensor
addMesh(scene,"cylinder",{[-5 5 2] [0 12]},[0 1 0]);
addMesh(scene,"cylinder",{[5 5 2] [0 12]},[0 1 0]);
addMesh(scene,"cylinder",{[5 -5 2] [0 12]},[0 1 0]);

% Create one UAV platform to be controlled and another to be stationary.

% Platform/UAV initial position and orientation
initpos = [0 0 -5]; % NED Frame
initori = [0 0 0];

% Add UAV Platforms to the Scenario and scale them for easier visualization
platform = uavPlatform("platformUAV",scene,ReferenceFrame="NED", ...
    InitialPosition=initpos,InitialOrientation=eul2quat(initori));
platform2 = uavPlatform("platformUAV2",scene,ReferenceFrame="NED", ...
    InitialPosition=[0 7 -11],InitialOrientation=eul2quat(initori));

updateMesh(platform,"quadrotor",{2},[0 0 0],eul2tform([0 0 pi]));
updateMesh(platform2,"quadrotor",{2},[0 0 0],eul2tform([0 0 pi]));

%Create a uavSensor with a lidar sensor model, for use in the Simulink simulation, by using the uavLidarPointCloudGenerator, and attach it to the first UAV platform. Specify the parameters of the lidar in the UAV Scenario Lidar block, because the model does not load them from the object.

LidarModel = uavLidarPointCloudGenerator;
uavSensor("Lidar",platform,LidarModel,MountingLocation=[0 0 1],MountingAngles=[0 0 180]);