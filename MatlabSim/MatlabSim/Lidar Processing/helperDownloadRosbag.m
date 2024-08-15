function helperDownloadRosbag(outputFolder,rosbagURL)
% Download the data set from the given URL to the output folder.
rosbagFile = fullfile(outputFolder,'lccSample.bag');
rosbagZipFile = fullfile(outputFolder,'lccSample.zip');
    if ~exist(rosbagFile,'file')
        if ~exist(rosbagZipFile,'file')
            mkdir(outputFolder);
            disp('Downloading the rosbag file (8.5 MB)...');
            websave(rosbagZipFile,rosbagURL);
        end
        unzip(rosbagZipFile,outputFolder);
    end
end