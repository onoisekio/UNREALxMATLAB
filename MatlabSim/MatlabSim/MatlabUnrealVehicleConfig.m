%% STEP1
% Specify the location of the support package project files and a local folder destination
% Note:  Only one path is supported. Select latest download path.

dest_root = "C:\Local";
src_root = fullfile(matlabshared.supportpkg.getSupportPackageRoot, ...
    "toolbox", "shared", "sim3dprojects", "spkg");

%% STEP2
% Specify the location of the Unreal Engine installation.
ueInstFolder = "D:\UE_4.26";

%% STEP3
% Copy the MathWorksSimulation plugin to the Unreal Engine plugin folder.
mwSimPluginName = "MathWorksSimulation";
mwAutoPluginName = "MathWorksAutomotiveContent";
mwRRPluginName = "RoadRunnerMaterials";
mwUAVPluginName = "MathworksUAVContent";
mwPluginFolder = fullfile(src_root, "plugins");
uePluginFolder = fullfile(ueInstFolder, "Engine", "Plugins");
uePluginDst = fullfile(uePluginFolder, "Marketplace", "MathWorks");

cd(uePluginFolder)
foundPlugins = [dir("**/" + mwSimPluginName + ".uplugin"); dir("**/" + mwAutoPluginName + ".uplugin"); dir("**/" + mwRRPluginName + ".uplugin")];

if ~isempty(foundPlugins)
    numPlugins = size(foundPlugins, 1);
    msg2 = cell(1, numPlugins);
    pluginCell = struct2cell(foundPlugins);

    msg1 = "Plugin(s) already exist here:" + newline + newline;
    for n = 1:numPlugins
        msg2{n} = "    " + pluginCell{2,n} + newline;
    end
    msg3 = newline + "Please remove plugin folder(s) and try again.";
    msg  = msg1 + msg2 + msg3;
    msg = strjoin(msg);
    warning(msg);
else

    try 
      copyfile(fullfile(mwPluginFolder, 'mw_automotive'), uePluginDst); 
      disp("Successfully copied MathWorksAutomotiveContent to UE4 engine plugins!") 
    catch 
      warning("Could not copy MathWorksAutomotiveContent plugin to UE4 engine plugins!") 
    end
    
    try     
      copyfile(fullfile(mwPluginFolder, 'mw_simulation'), uePluginDst); 
      disp("Successfully copied MathWorksSimulation to UE4 engine plugins!") 
    catch    
       warning("Could not copy MathWorksSimulation plugin to UE4 engine plugins!") 
    end

    try
       copyfile(fullfile(mwPluginFolder, 'rr_materials'), uePluginDst); 
       disp("Successfully copied RoadRunnerMaterials to UE4 engine plugins!")         
    catch  
       warning("Could not copy RoadRunnerMaterials plugin to UE4 engine plugins!") 
    end

    try
       copyfile(fullfile(mwPluginFolder, 'mw_uav'), uePluginDst); 
       disp("Successfully copied MathWorksUAVContent plugin to UE4 engine plugins!")         
    catch  
       warning("Could not copy MathWorksUAVContent plugin to UE4 engine plugins!") 
    end

end

% %% STEP4
% % Copy the support package folder that contains the AutoVrtlEnv.uproject
% % files to the local folder destination.
% projFolderName = "AutoVrtlEnv";
% projSrcFolder = fullfile(src_root, "project", projFolderName);
% projDstFolder = fullfile(dest_root, projFolderName);
% if ~exist(projDstFolder, "dir") 
%     copyfile(projSrcFolder, projDstFolder); 
% else 
%     warning("Delete old project before installing newer version") 
% end 

data = out.simout1;
frames = data.Data;
f = frames(:,:,:,1);
figure,pcshow(f)
f = frames(:,:,:,100);
figure,pcshow(f)
xlabel('x')
ylabel('y')
zlabal('z')