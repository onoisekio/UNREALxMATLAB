folder = 'C:\Users\admin_faruq\OneDrive - York University\Desktop\Unreal\UNREALxMATLAB\MatlabSim\MatlabSim\DroneImages';%folder containing images
imext = '.png';
startIndex = 4;
endIndex = 151;
numCrops = 100;
xHeight = 64;
yHeight = 36;
index = 1;

for i = startIndex:endIndex
    imdir = strcat(folder, '/', num2str(i), imext);
    img = imread(imdir);
    [r, c, n] = size(img);
    
    %create folder to store the images
    cropFolder = strcat(folder, '\', 'cropFolder');
    %mkdir(cropFolder);
    %create the cropped images
    for nC = 1:numCrops
        xCord = randi([1, c - xHeight], 1);
        yCord = randi([1, r - yHeight], 1);
        iCrop = imcrop(img, [xCord,yCord,xHeight-1,yHeight-1]);
        iCrop = rgb2gray(iCrop);
        imwrite(iCrop, strcat(cropFolder, '\', num2str(index), imext));
        index = index + 1;
        %break;
    end
    %break;
end