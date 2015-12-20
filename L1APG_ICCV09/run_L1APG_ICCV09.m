function [ resCenters,resConers ] = run_L1APG_ICCV09( imageNames, Param )
  
  close all
  
  
%   global resCorners
%   global resCenters
  
  s_frames = imageNames;
  
  para=paraConfig_L1_APG(Param.seqId);
  
  opt = Param.param;
  para.n_sample = opt.numsample;
  
  nframes = length(imageNames);
  
   %Initialization for the first frame. 
        %Each column is a point indicating a corner of the target in the first image. 
        %The 1st row is the y coordinate and the 2nd row is for x.
        %Let [p1 p2 p3] be the three points, they are used to determine the affine parameters of the target, as following
        %    p1(65,55)-----------p3(170,53)
        %         | 				|		 
        %         |     target      |
        %         | 				|	        
        %   p2(64,140)--------------
  p = Param.s0
  p = [p(1)-p(3)/2, p(2)-p(4)/2, p(3), p(4)];
  
  init_pos= [p(2),p(2)+p(4)-1,p(2);
    p(1),p(1),p(1)+p(3)-1];
   
  % para.s_debug_path = res_path;
  para.init_pos = init_pos;
  
  % indicator for result image show and save after tracking finished
  bShowSaveImage=0;       
  para.bDebug=bShowSaveImage;
  
  %% main function for tracking
  [results, output,resCenters,resConers]  = L1TrackingBPR_APGup(s_frames, para);
  
  fps = (nframes-1)/sum(output.time);
  
  disp(['fps: ' num2str(fps)])
