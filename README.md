# UNREALxMATLAB

Tools:
- Unreal Engine 4.26.2
- MATLAB R2022a
- MATLAB Simulink R2022a

This is Matlab/Unreal Engine 4.26 simulation of a Sim3d UAV coorperating with a Sim3d autonomous surface ship (MASS) to facilitate the MASS's navigation in ice. The UAV performs survey missions to gather and process ice data. Safe navigation paths for the MASS are estimated from the processed data and represented in a colour-coded hazard map. Simulation must be run on MATLAB V. 2022a and Unreal Engine 4.26. See below for instructions to run the simulation on MATLAB. Contact Gerald Kio @ zckog@yahoo.com for more information.

Simulation Instructions

Launch MATLAB V. 2022a
Change working path to MatlabSim if necessary
Launch Simulink
Launch MASS_Simulation.slx located in the working path
Double-click on the Simulation 3D Scene Configuration2 Simulink block and make selections in its Block Parameters dialogue box.
Select the (UE) Project DroneExp1.uproject
Click Open Unreal Editor to launch UE Editor
Click Apply and OK to close the dialogue box
After UE Editor launches, click Run on Simulink editor to start the simulation. Wait for it to compile, and when ready click Play on UE Editor to start the simulation
Maximize Matlab windows docked in the tray to view the simulation. image
Simulation & Helper Scripts (MatlabSim\MatlabSim...)

SimEnvironment.mat – Contains simulation presets for the simulation vehicles and shipping environment
LeftRiverGeoPts.mat, RightRiverGeoPts.mat – Estimates of geocoordinates of shipping boundaries
OccMap.mat – contains default pixel and geocoordinates, and colours of hazard map points
ShipPath.mat – Calculated ship path
Run0, 1, 2, 3.mat – Parameters for Hazard-Uncertainty experiment
OccupancyMap.mat – Default occupancy map
SimulationControl.m – Implements a system state machine
PathPlanSubsystem.m – Calculates survey paths for the drone and travel paths for the ship with the RRT algorithm
ImageProcessingSubsystem.m – Processes images obtained by the drone camera to produce ice concentration data
LidarProcessingSubsystem – Processes LiDAR range data to produce Ice Multipliers
DataFusionSubsystem – Processes outputs from ImageProcessing (4) and LidarProcessing (5) functions to update ice numerals, occupancy, and hazard maps
RGBToGray – Converts RGB image data to grayscale
HazardMapDisplay – Displays the drone, ship positions and paths on the Hazard map
DistributeIceXML1.m (FuzzyBlockSegmentation, GenerateIcePatches) – Calculates distribution of ice in the shipping environment
exampleHelperCheckIfGoal.m – Helper function for the RRT algorithm
MatlabUnrealVehicleConfig – Script to install required MATLAB plugins into Unreal Engine. Probably outdated. Check MathWorks website for updates
IceConcentrations.xml – Ice distribution input to Unreal Engine simulation
