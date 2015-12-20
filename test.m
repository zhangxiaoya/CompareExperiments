
%% Test Example
clc; 
close all;

% title = 'animal';  % good
% title = 'board';   % good
% title = 'car11';   % better little
% title = 'caviar';  % good
% title = 'faceocc2'; % good
% title = 'girl';     % good
% title = 'jumping';  % good
% title = 'panda';  % good
% title = 'shaking';  % good
% title = 'singer1';  % good
% title = 'stone';    % same

% title = 'motorrolling'; % fail all
% title = 'mountationbike'; % good little
% title = 'skating1' % all fail
% title = 'basketball';
% title = 'gym'

% title = 'soccer';   % good
% title = 'football'; % good
% title = 'bolt';
titles = {'animal';'board';'car11';'caviar';'faceocc2'; 'girl';'jumping'; 'panda';'shaking';'singer1';'stone';'mountationbike';'gym';'soccer';'football'};
% datasetPath = '/home/xiaoya/Research/zhyn/experiments/data/images';
datasetPath = 'D:\CResearch\datasets\MyBenchmark\';

res_path='D:\CResearch\datasets\Results_CompareExperiments\L1APG_ICCV09\results\';

%% Test for all sequences
% for i = 1:length(titles);
for i = 1:1;
    seqId = cell2mat(titles(i));

    Param.forMat = '.jpg';
    folder = [ datasetPath '\' seqId '\img\' ];
    imageNames = loadImages( folder , Param.forMat );

%     run tracker
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
%     cd PCOM_CVPR14/
%     [result ] = run_PCOM_CVPR14(imageNames,Param);
%     save([ './result/' seqId '.mat'], 'result');
%     cd 'condenssig',condenssig, 'ff',1.0,...
%                      'batchsize',5, ..

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     Param.seqId   = seqId;
%     Param.dataset = datasetPath;
%     Param.numsample = 600;
%     trackparams;
%     cd IVT_IJCV08/
%     [ result ] = run_IVT_IJCV08( imageNames, Param );
%     save([ './result/' seqId '.mat'], 'result');
%     cd ..

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    Param.seqId   = seqId;
    Param.dataset = datasetPath;
    Param.numsample = 600;
    trackparams;
    cd L1APG_ICCV09
    [ resCenters resConers ] = run_L1APG_ICCV09( imageNames, Param );
    

    % prepare the path for saving tracking results
    res_path=[res_path seqId '\'];
    if ~exist(res_path,'dir')
        mkdir(res_path);
    end
    
    save([res_path 'L1_APG_' seqId '_Centers.mat'], 'resCenters');
    save([res_path 'L1_APG_' seqId '_Coners.mat'], 'resConers');
    cd ..

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     Param.seqId   = seqId;
%     Param.dataset = datasetPath;
%     trackparams;
%     cd MTT_IJCV12
%     [result] = run_MTT_IJCV12( imageNames, Param );
%     save([ './result/' seqId '.mat'], 'result');
%     cd ..
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%      Param.seqId   = seqId;
%     Param.dataset = datasetPath;
%     trackparams;
%     
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     cd LSST_CVPR13
%     if i ~= 2
%         
%     
%     Param.seqId   = seqId;
%     Param.dataset = datasetPath;
%     trackparam;
%     Param.param = opt;
%     Param.s0 = p;
%     [result] = run_LSST_CVPR13(imageNames, Param);
%     save([ './result/' seqId '.mat'], 'result');
%     end
%     cd ..

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


end
% seqId       = title;






% cd IVT_IJCV08/
% [ results ] = run_IVT_IJCV08( imageNames, Param );
% cd ..
