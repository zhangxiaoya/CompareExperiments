function [resCenters,resConers] = run_MTT_IJCV12( imageNames, Param )

addpath('MTT_Toolbox');

close all;

all_images = imageNames;

opt = paraConfig_MTT(Param.seqId);
% %% video frames
% video_name = 'car11';
% video_path = fullfile('.\data\',video_name);
% m_start_frame = 1;  %starting frame number
% nframes		= 393; %393;	 %number of frames to be tracked
% Imgext		= 'png';				%image format
% numzeros	= 4;	%number of digits for the frame index
% all_images	= cell(nframes,1);
% nz			= strcat('%0',num2str(numzeros),'d'); %number of zeros in the name of image
% for t=1:nframes
%     image_no	= m_start_frame + (t-1);
%     fid			= sprintf(nz, image_no);
%     all_images{t}	= strcat(video_path,'\',fid,'.',Imgext);
% end

%% initialize bounding box
% m_boundingbox = [75,129,25,19];  % [left-top-x, left-top-y, width, height];
m_boundingbox = Param.s0(1:4);

% init_pos	= SelectTarget(all_images{1});  % automatically get bounding box
% init_pos =  [p1 p2 p3];
% 			  p1-------------------p3
% 				\					\
% 				 \       target      \
% 				  \                   \
% 				  p2-------------------\
init_pos = [m_boundingbox(2)-m_boundingbox(4)/2   m_boundingbox(2)+m_boundingbox(4)/2  m_boundingbox(2)-m_boundingbox(4)/2 ;
    m_boundingbox(1)-m_boundingbox(3)/2   m_boundingbox(1)-m_boundingbox(3)/2  m_boundingbox(1)+m_boundingbox(3)/2];
opt.init_pos = double(init_pos);  %  initialization bounding box

width = m_boundingbox(3);
height = m_boundingbox(4);
%% 	set object size including height and width based on the initialization
if min( 0.5*[height width]) < 25
    sz_T = 1.0 * [height width];
    if height > 80
        sz_T =  [ 0.5 *height width];
    end
else
    sz_T = 0.5 * [height width];
end
sz_T = ceil(sz_T);
if min(sz_T>32)
    sz_T = [32 32];
end


%% Run MTT tracking. To get better results for different videos, we can change sz_T, rel_std_afnv,  and m_theta.
% tic
[tracking_res, run_time]= MTT_Tracking(all_images,opt);

nframes = length(all_images);

%% 保存中心点坐标和高宽
resCenters = [];   % 返回中心点坐标[col,row]
resConers  = [];   % 返回矩形框高宽[lefttop,righttop,leftbottom,lefttop]

for t = 1:nframes
    map_afnv	= tracking_res(:,t)';
    rect= round(aff2image(map_afnv', sz_T));
    inp	= reshape(rect,2,4);
    
    topleft_r = inp(1,1);
    topleft_c = inp(2,1);
    botleft_r = inp(1,2);
    botleft_c = inp(2,2);
    topright_r = inp(1,3);
    topright_c = inp(2,3);
    botright_r = inp(1,4);
    botright_c = inp(2,4);
    
    resCenter=[topleft_c+(topright_c-topleft_c)/2;topleft_r+(botleft_r-topleft_r)/2];
    resCenters = [resCenters resCenter];
    resConer = [topleft_r;topleft_c;topright_r;topright_c;botright_r;botright_c;botleft_r;botleft_c];
    resConers= [resConers resConer];
end


% tracking_time=toc;
%
% tic
% for t = 1:length(all_images)
%     img_color	= imread(all_images{t});
%     img_color	= double(img_color);
%     imshow(uint8(img_color));
%     text(5,10,num2str(t),'FontSize',18,'Color','r');
% end
% load_time = toc;
%
% fps=(tracking_time-load_time)/length(all_images);
%% Save tracking results
% all_results_path = '.\MTT_Results\';
% if ~exist([all_results_path video_name])
%     mkdir([all_results_path video_name]);
% end
% all_rect = [];
% for t = 1:nframes
%     img_color	= imread(all_images{t});
%     img_color	= double(img_color);
%     imshow(uint8(img_color));
%     text(5,10,num2str(t),'FontSize',18,'Color','r');
%     color = [1 0 0];
%     map_afnv	= tracking_res(:,t)';
%     rect=drawAffine(map_afnv, sz_T, color, 2);
%     all_rect =[all_rect; rect(2,1) rect(1,1) rect(2,3)-rect(2,1) rect(1,2)-rect(1,1)];
%
%     s_res	= all_images{t}(1:end-4);
%     s_res	= fliplr(strtok(fliplr(s_res),'/'));
%     s_res	= fliplr(strtok(fliplr(s_res),'\'));
%     s_res	= [s_res '_MTT.png'];
%     f = getframe(gcf);
%     imwrite(uint8(f.cdata), [all_results_path video_name '\' s_res]);
% end

%   results.type = 'L1Aff';
%   results.res=tracking_res';
%   results.tmplsize=opt.sz_T;%[height, width]
%   results.fps=length(run_time)/sum(run_time);

results = tracking_res;