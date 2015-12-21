
clc;
close all;

% titles = {'animal';'board';'car11';'caviar';'faceocc2';'jumping'; 'panda';'shaking';'singer1';'mountainBike';'gym';'soccer';'football'};
% titles = {'mountainBike';'gym';'soccer';'football'};
titles = {'girl'};

datasetPath = 'D:\CResearch\datasets\MyBenchmark\';

res_path='D:\CResearch\datasets\Results_CompareExperiments_Img\ONNDL\';

color = [1 1 0];
linewidth = 2;

%% Test for all sequences
for i = 1:length(titles);
    seqId = cell2mat(titles(i));
    
    forMat = '.jpg';
    folder = [ datasetPath '\' seqId '\img\' ];
    imageNames = loadImages( folder , forMat );
    
    nframes = length(imageNames);
    
    clear savedRes;
    resultPath = ['.\' seqId '_ONNDL.mat'];
    load(resultPath);
    tres_path = [res_path seqId];
    if ~exist(tres_path,'dir')
        mkdir(tres_path);
    end
    
    for t = 1:nframes
        fprintf('Frame number: %d \n',t);
        img_color	= imread(imageNames{t});
        if(size(img_color,3) == 3)
            img     = double(rgb2gray(img_color));
        else
            img     = double(img_color);
        end
        
        %%   draw tracking results
        img_color	= double(img_color);
        imshow(uint8(img_color));
        text(5,10,num2str(t),'FontSize',18,'Color','r');
        
        % 保存中心点和高宽
        curRes = savedRes(t,:);
        width = curRes(3);
        height = curRes(4);
        center = [curRes(2);curRes(1)];
        
        topleft_r = curRes(2)-height/2;
        topleft_c = curRes(1)-width/2;
        botleft_r = curRes(2)-height/2 + height;
        botleft_c = curRes(1)-width/2;
        topright_r = curRes(2)-height/2;
        topright_c = curRes(1)-width/2 + width;
        botright_r = curRes(2)-height/2 + height;
        botright_c = curRes(1)-width/2 + width;
        p = line([topleft_c, topright_c], [topleft_r, topright_r]);
        set(p, 'Color', color); set(p, 'LineWidth', linewidth); set(p, 'LineStyle', '-');
        p = line([topright_c, botright_c], [topright_r, botright_r]);
        set(p, 'Color', color); set(p, 'LineWidth', linewidth); set(p, 'LineStyle', '-');
        p = line([botright_c, botleft_c], [botright_r, botleft_r]);
        set(p, 'Color', color); set(p, 'LineWidth', linewidth); set(p, 'LineStyle', '-');
        p = line([botleft_c, topleft_c], [botleft_r, topleft_r]);
        set(p, 'Color', color); set(p, 'LineWidth', linewidth); set(p, 'LineStyle', '-');
        
        drawnow;
        
        savePath = [tres_path '\' sprintf('%04d.jpg', t)];
        imwrite(frame2im(getframe(gcf)),savePath);
    end
end

