
load([title '_ONNDL.mat']);

resCenters = savedRes(:,1:2);

str = ['D:\CResearch\zhyn\data\gtmat\' title '_centers_gt.mat'];
load(str);

temp  = [];
for i = 1: size(resCenters,1)
    if isnan(gtCenters(i,1))
        continue;
    else
        temp = [temp; gtCenters(i,:) - resCenters(i,:)];
    end
end

errs = sqrt((sum((temp .^ 2),2)));
sum(errs)
str = ['./evaluation/' title '_evlRes.mat'];
save(str,'errs');
