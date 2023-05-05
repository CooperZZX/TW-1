%本程序用于实现将NaTeCam的2C级数据转化为tiff
clear
clc
% filepath = uigetdir('*.*', 'Please Choose the Folder'); % filepath: folder path
filepath='I:\TW-1\NaTeCam-2C\补';
dirOutput=dir(fullfile(filepath,'*.2C'));
fileNames={dirOutput.name}';
fileNames=cell2mat(fileNames);   % convert cell to matrix.
fileNum = size(fileNames,1); % count the total number of files.
result_filepath=[filepath,'tif'];
cd (result_filepath)
% ****** read in the 2C file and export as tiff file. ********
for i=1:fileNum   % load the 2B file one-by-one.
    basename = fileNames(i,:);  % The ith file name.
    disp(i)
    disp(basename)
    filename=[filepath,'\',basename];
    fID = fopen(filename);
    Cam = fread(fID, 2048*2048*3,'uint8','l');
    fclose(fID);
    Cam = uint8(Cam);
    R = Cam(1:3:end);
    G = Cam(2:3:end);
    B = Cam(3:3:end);
    R = reshape(R,2048,2048);
    G = reshape(G,2048,2048);
    B = reshape(B,2048,2048);
    CC(:,:,1) = R';
    CC(:,:,2) = G';
    CC(:,:,3) = B';   
%     figure
%     imshow(CC)    
    fname = strcat(basename(1:end-2),'tif');
%     imgname=[fname(1:12),fname(end-10:end-5),fname(13:end-12),fname(end-6:end)];
    imgname=[fname(end-10:end-6),'-',fname(20),'-',fname(24:26),fname(end-3:end)];
    imwrite(CC,imgname)
    hold on
end