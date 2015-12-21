%*************************************************************
%% Copyright (C) Wei Zhong.
%% All rights reserved.
%% Date: 05/2012

%%**************************************************************

% titles = {'animal','girl','car11','panda','faceocc2','gym','board','football','soccer','stone','singer1','shaking','jumping','caviar'};
% titles = {'animal','gym','board'};
titles = {'MountationBike'};
forMat = '.jpg';

for i = 1: length(titles)
    title = cell2mat(titles(i));
    
    temp      = importdata([ 'D:\CResearch\zhyn\result\zhyn\experiments\data\images\' title '\img\' 'datainfo.txt' ]);
    imageSize = [ temp(2) temp(1) ];
    
    trackResult     = load([title '_O.mat']);
    frameNum  = size(trackResult.result, 1);
    
    figure('position',[ 100 100 imageSize(2) imageSize(1) ]);
%     set(gcf,'DoubleBuffer','on','MenuBar','none');
    
    for num = 1:frameNum
        
        framePath = ['D:\CResearch\zhyn\result\zhyn\experiments\m1_code\result\' title '\'  sprintf('%s_%04d.jpg', title, num)];
%         framePath = [ 'D:\CResearch\zhyn\result\zhyn\experiments\data\images\' title '\img\'  int2str(num) forMat];
        imageRGB  = imread(framePath);
        axes(axes('position', [0 0 1.0 1.0]));
        imagesc(imageRGB, [0,1]);
        hold on;
        numStr = sprintf('#%03d', num);
%         set(text(10,20,numStr),'FontUnits',1,'FontSize',20);
% text(10,20,numStr,'FontSize',18)
%         text(10,20,numStr,'Color','r', 'FontWeight','bold', 'FontSize',30);
        
        if  num<=size(trackResult.result,1)
            color = [ 1 1 0 ];
            est = trackResult.result(num,:);
            [ center corners ] = drawbox([32 32], est, 'Color', color, 'LineWidth', 2.5);
        end
        
        axis off;
        hold off;
        drawnow;
        savePath = ['./' title '/' sprintf('%s_%04d.jpg', title, num)];
        imwrite(frame2im(getframe(gcf)),savePath);
        clf;
    end
    
end



