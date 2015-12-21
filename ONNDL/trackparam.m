% script: trackparam.m
%     loads data and initializes variables
%
% MORE PARAMETERS DESCRIPTION COULD BE FOUND INLINE!
% DESCRIPTION OF OPTIONS:
%
% Following is a description of the options you can adjust for
% tracking, each proceeded by its default value.  For a new sequence
% you will certainly have to change p.  To set the other options,
% first try using the values given for one of the demonstration
% sequences, and change parameters as necessary.
% p = [px, py, sx, sy, theta]; The location of the target in the first
% frame.
% px and py are th coordinates of the centre of the box
% sx and sy are the size of the box in the x (width) and y (height)
%   dimensions, before rotation
% theta is the rotation angle of the box
%
% 'numsample',600,   The number of samples used in the condensation
% algorithm/particle filter.  Increasing this will likely improve the
% results, but make the tracker slower.
%
% 'condenssig',0.2,  The standard deviation of the observation likelihood.
%
%  The forgetting factor, as described in the paper.  When
% doing the incremental update, 1 means remember all past data, and 0
% means remeber none of it.
%
% 'batchsize',5, How often to update the basis.  We've used this
% value (update every 5th frame) fairly consistently, so it most
% likely won't need to be changed.  A smaller batchsize means more
% frequent updates, making it quicker to model changes in appearance,
% but also a little more prone to drift, and require more computation.
%
% 'affsig',  These are the standard deviations of
% the dynamics distribution, that is how much we expect the target
% object might move from one frame to the next.  The meaning of each
% number is as follows:
%    affsig(1) = x translation (pixels, mean is 0)
%    affsig(2) = y translation (pixels, mean is 0)
%    affsig(3) = x & y scaling
%    affsig(4) = rotation angle
%    affsig(5) = aspect ratio
%    affsig(6) = skew angle
clear all

dataPath = 'D:\CResearch\zhyn\data\forONNDL\';

% titles = {'board','panda','mountationbike','car11','girl','faceocc2','animal','caviar','jumping','shaking','singer1','stone','gym','soccer','football'};
% title = 'animal';
% title = 'girl';
% title = 'car11';
% title = 'caviar';
% title = 'jumping';
% title = 'mountationbike';
% title = 'panda';
% title = 'faceocc2';
% title = 'shaking';
% title = 'singer1';
% title = 'stone';
% title = 'gym';
% title = 'soccer';
% title = 'football';
% title = 'board';



switch (title)
    case 'davidin300';  p = [158 106 62 78 0];
        opt = struct('batchsize',5, 'affsig',[4,4,.005,.00,.001,.00]);
    case 'trellis70';  p = [200 100 45 49 0];
        opt = struct('batchsize',5, 'affsig',[4,4,.005, 0.00, 0.001, 0.0]);
    case 'car4';  p = [123 94 107 87 0];
        opt = struct('batchsize',5, 'affsig',[4,4,.02,.0,.001,.00]);
    case 'car11';  p = [89 140 30 25 0];
        opt = struct('batchsize',5, 'affsig',[4,4,.005,.0,.001,.00]);
    case 'animal'; p = [350 40 100 70 0];
        opt = struct('batchsize',5, 'affsig',[16,16,.005, .0, .001, 0.00]);
    case 'shaking';  p = [255 170 60 70 0];
        opt = struct('batchsize',5, 'affsig',[4,4,.005,.00,.001,.00]);
    case 'singer1';  p = [100 200 100 300 0];
        opt = struct('batchsize',5, 'affsig',[4,4,.02,.00,.001,.0000]);
    case 'skating1';  p = [180 220 35 100 0];
        opt = struct('batchsize',5, 'affsig',[4,4,.005,.00,.001,.00]);
        
    case 'bolt'; p = [277+15 77+30 30 60 0];
        opt = struct('batchsize',5, 'affsig',[4,4,.005,.000,.001,.000]);
        
    case 'singer2';  p = [350 250 80 200 0];
        opt = struct('batchsize',5, 'affsig',[4,4,.005,.000,.001,.000]);
    case 'basketball';  p = [210 260 40 100 0];
        opt = struct('batchsize',5, 'affsig',[4,4,.005,.000,.001,.000]);
    case 'woman';  p = [222 165 35 95 0.0];
        opt = struct('batchsize',3, 'affsig',[4,4,.005,.000,.001,.000]);
    case 'football';  p = [330 125 40 40 0.0];
        opt = struct('batchsize',5, 'affsig',[4,4,.005,.000,.001,.000]);
    case 'girl';  p = [180,109,104,127,0.0];
        opt = struct('batchsize',5, 'affsig',[6,6,.02,.000,.001,.000]);
        
    case 'caviar'; p = [162 216 50 140 0.0];
        opt = struct('batchsize',5, 'affsig',[6,5,.01,.00,.001,.0000]);
        
    case 'jumping'; p = [163,126,33,32,0];
        opt = struct('batchsize',5, 'affsig',[8,18,.000,.000,.000,.00]);
    case 'mountationbike';
        p = [358 210 58 53 0.00];
        opt = struct('batchsize',5,'affsig',[4, 4, 0.01, .00, .00, .00]);
    case 'panda'; p = [286 171 25 25 0.01];
        opt = struct('batchsize',5, 'affsig',[9,9,.01,.000,.000,.0000]);
    case 'faceocc2'; p = [156,107,74,100,0.00];
        opt = struct('batchsize',5, 'affsig',[4, 4, .02, .03, .001,.000]);
        
    case 'stone'; p = [115 150 43 20 0.0];
        opt = struct('batchsize',5, 'affsig',[6,6,.01,.00,.000,.0000]);
    case 'gym';         p = [177,140,46,133,0.0];
        opt = struct('batchsize',5, 'affsig',[8,5,.002,.0001,.002,.000]);
    case 'soccer'; p = [335, 175, 66, 80, 0];
        opt = struct('batchsize',5, 'affsig',[8,8,.000,.000,.000,.000]);
    case 'board'; p = [154,243,195,153,0];
        opt = struct('batchsize',5, 'affsig',[10, 10, .03, .00, .001, .00]);
        
        %     case 'shaking'; p = [255, 170, 60, 70, 0 ];
        %         opt = struct('numsample',100, 'affsig',[4,4,.03,.00,.00,.00]);
        %         forMat = '.jpg';
        
        %         forMat = '.jpg';
        %         forMat = '.jpg';
        %         forMat = '.jpg';
        %         forMat = '.jpg';
        
    otherwise;  error(['unknown title ' title]);
end

% The number of particles used in particle filter
opt.numsample = 200;
% Used in calculating particle confidence.
opt.condenssig = 0.2;
% The number of positive templates, Must be mutiple of 10!
opt.maxbasis = 20;
% The number of negative samples collected each frame.
opt.negativeBasis = 100;
% Forger factor used in updating bases.
opt.forgetFactor = 0.99;
% Whether to use GPU in the robust non-negative sparse coding
opt.useGpu = true;

% Auto determine template size.
if p(3) / p(4) <= 0.5
    opt.tmplsize = [48, 16];
else
    opt.tmplsize = [32, 32];
end

% Load data
disp('Loading data...');
fullPath = [dataPath, title, '\img\'];
imageNames = loadImages(fullPath,'.jpg');
% d = dir([fullPath, '*.jpg']);
% if size(d, 1) == 0
%     d = dir([fullPath, '*.png']);
% end
% if size(d, 1) == 0
%     d = dir([fullPath, '*.bmp']);
% end
im = imread(imageNames{1});
data = zeros(size(im, 1), size(im, 2), size(imageNames, 1));
for i = 1 : size(imageNames, 1)
    im = imread(imageNames{i});
    if ndims(im) == 2
        data(:, :, i) = im;
    else
        data(:, :, i) = rgb2gray(im);
    end
end

paramOld = [p(1), p(2), p(3)/opt.tmplsize(2), p(5), p(4) /p(3) / (opt.tmplsize(1) / opt.tmplsize(2)), 0];
param0 = affparam2mat(paramOld);
