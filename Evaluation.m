function [errs] = Evaluation(centers,title)
% 计算中心点误差，返回向量

%% 加载Ground Truth
str = ['D:\CResearch\datasets\gtmat\' title '_centers_gt.mat'];
load(str);
gtCenters(find(isnan(gtCenters) == 1)) = 0;

centers = centers';
num = size(centers,1);

gtCenters = gtCenters(1:num,:);

errs = sqrt(sum((centers - gtCenters) .^ 2, 2));

end
% clear all;
% load gt file
% load('D:\CResearch\experiments\a15_SCM_wei_zhong_cvpr12\code\images\faceocc2\groundtruth_rect.txt');

% gt_centers = zeros(size(groundtruth_rect,1),2);
% for i = 1:size(groundtruth_rect,1)
%     gt_centers(i,1) = groundtruth_rect(i,1) + groundtruth_rect(i,3)/2;
%     gt_centers(i,2) = groundtruth_rect(i,2) + groundtruth_rect(i,4)/2;
% end
% clear all;
% title = 'faceocc2';num = 812;
% title = 'girl';num = 501;
% title = 'car11';num = 393;
% title = 'mountationbike';num = 228;
% title = 'panda';num = 241;
% title = 'board';num = 598;
%  title = 'gym';num = 767;



% load result
% MakeCenters;
%
% errs1 = sqrt(sum((res1Centers - gtCenters) .^ 2, 2));
%
% errs2 = sqrt(sum((res2Centers - gtCenters) .^ 2, 2));
%
% % save evalue result
% str = ['./evaluation/' title '_evlRes.mat'];
% save(str,'errs1','errs2');