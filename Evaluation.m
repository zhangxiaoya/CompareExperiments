function [errs] = Evaluation(centers,title)
% �������ĵ�����������

%% ����Ground Truth
str = ['D:\CResearch\datasets\gtmat\' title '_centers_gt.mat'];
load(str);
gtCenters(find(isnan(gtCenters) == 1)) = 0;

centers = centers';
num = min(size(centers,1),size(gtCenters,1));

centers = centers(1:num,:);
gtCenters = gtCenters(1:num,:);

errs = sqrt(sum((centers - gtCenters) .^ 2, 2));

end
