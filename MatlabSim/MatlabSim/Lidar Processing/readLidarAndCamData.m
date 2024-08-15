outputFolder = fullfile(tempdir,'RosbagFile');
rosbagURL = ['https://ssd.mathworks.com/supportfiles/lidar/data/' ...
    'lccSample.zip'];
helperDownloadRosbag(outputFolder,rosbagURL);
%Retrieve information from the bag file.

path = fullfile(outputFolder,'lccSample.bag');
bag = rosbag(path);
% select image and point cloud messages from file 
imageBag = select(bag,'Topic','/camera/image/compressed');
pcBag = select(bag,'Topic','/points');

%read all messages
imageMsgs = readMessages(imageBag);
pcMsgs = readMessages(pcBag);

% Time series for lidar and camera messages for calibration

ts1 = timeseries(imageBag);
ts2 = timeseries(pcBag);
t1 = ts1.Time;
t2 = ts2.Time;

% Match lidar and camera timestamps within 0.1s accuracy
k = 1;
if size(t2,1) > size(t1,1)
    for i = 1:size(t1,1)
        [val,indx] = min(abs(t1(i) - t2));
        if val <= 0.1
            idx(k,:) = [i indx];
            k = k + 1;
        end
    end
else
    for i = 1:size(t2,1)
        [val,indx] = min(abs(t2(i) - t1));
        if val <= 0.1
            idx(k,:) = [indx i];
            k = k + 1;
        end
    end   
end

% Create directories for image and point cloud data
pcFilesPath = fullfile(tempdir,'PointClouds');
imageFilesPath = fullfile(tempdir,'Images');
if ~exist(imageFilesPath, 'dir')
    mkdir(imageFilesPath);
end
if ~exist(pcFilesPath, 'dir')
    mkdir(pcFilesPath);
end

%Extract image and point cloud data and save in respective folders
for i = 1:length(idx)
    I = readImage(imageMsgs{idx(i,1)});
    pc = pointCloud(readXYZ(pcMsgs{idx(i,2)}));
    n_strPadded = sprintf( '%04d', i ) ;
    pcFileName = strcat(pcFilesPath,'/', n_strPadded, '.pcd');
    imageFileName = strcat(imageFilesPath,'/', n_strPadded, '.png');
    imwrite(I, imageFileName);
    pcwrite(pc, pcFileName);
end

% Load data into calibrator
checkerSize = 81; %millimeters
padding = [0 0 0 0];
lidarCameraCalibrator(imageFilesPath,pcFilesPath,checkerSize,padding)
