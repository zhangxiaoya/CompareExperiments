
clc;
close all;

titles = {'animal';'board';'car11';'caviar';'faceocc2';'girl'; 'panda';'shaking';'singer1';'mountainBike';'gym';'soccer';'football'};

gtPath = 'D:\CResearch\datasets\gtmat\';

res_path='D:\CResearch\datasets\Results_CompareExperiments\ONNDL\';

color = [1 1 0];
linewidth = 2;

%% Test for all sequences
for i = 1:length(titles);
    seqId = cell2mat(titles(i));
    
    
    clear savedRes;
    resultPath = ['.\' seqId '_ONNDL.mat'];
    load(resultPath);
    
    tres_path = [res_path seqId];
    if ~exist(tres_path,'dir')
        mkdir(tres_path);
    end
    
    str = [gtPath seqId '_centers_gt.mat'];
    load(str);
    gtCenters(find(isnan(gtCenters) == 1)) = 0;
    
    centers = savedRes(:,1:2);
    num = min(size(centers,1),size(gtCenters,1));
    
    centers = centers(1:num,:);
    gtCenters = gtCenters(1:num,:);
    
    errs = sqrt(sum((centers - gtCenters) .^ 2, 2));
    
    savePath = [tres_path '\' sprintf('ONNDL_%s_Errs.mat', seqId)];
    save(savePath,'errs');
end

