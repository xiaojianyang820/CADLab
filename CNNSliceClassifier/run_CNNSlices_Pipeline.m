% CT torso
imageFilename = '/home/rothhr/Code/CADLab-GitHub/Data/ISBI2015_data/TorsoCT001.nii.gz' % please specifiy
output_dir = '/tmp/TorsoCT001' % please specifiy
% Pancreas
imageFilename = '/home/rothhr/Code/CADLab-GitHub/Data/ISBI2015_data/1002.nii.gz' % please specifiy
output_dir = '/tmp/1002' % please specifiy

%% PARAMS
optROI.corrValue = []; % if images are not in HU, add this value to desired HU thresholds
% params for roi extraction
optSlices.outputImageSize=256; % outputImageSize (squared image)
optSlices.outExtension='.jpg';
optSlices.minWin=-100; %lower[intensity] ^= -100 HU
optSlices.maxWin=200; %upper[intensity] ^= +200 HU


optSlices.itkExtractImageSlices_exe = 'itkApps_build/release/itkExtractImageSlices';

% params for convnet predictions
optConvNet.ConvNetSrcFolder = [pwd,'/my-cuda-convnet2'];
optConvNet.CNNmodel                  = [pwd,'/TrainedConvNets/All512_to_def_t2_r2_balanced_256_500batches_ConvNet2/ConvNet__2014-11-14_21.13.15/101.1']; 
optConvNet.existingMeanImageFilename = [pwd,'/TrainedConvNets/All512_to_def_t2_r2_balanced_256_500batches_ConvNet2/data_mean.png']; 

optConvNet.NumberBatchesFactor = 1; % 1 makes sure no files get missed
optConvNet.UseMultiview = true;
optConvNet.ImageSize = optSlices.outputImageSize;
optConvNet.ImageSearchString = optSlices.outExtension;
optConvNet.ImageChannels = 1;
optConvNet.BatchStartIndex = 1;
optConvNet.NumberBatches = 1;

%% RUN
addpath(genpath(pwd))

CNNSlices_Pipeline(imageFilename,output_dir,optSlices,optConvNet);
