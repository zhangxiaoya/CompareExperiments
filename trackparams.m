
% Track Params

Param = [];

Param.seqId   = seqId;
Param.dataset = datasetPath;

switch( seqId );
    
    case( 'Animal' );
        Param.s0     = [ 350, 40, 100, 70, 0 ];
        Param.param  = struct( 'numsample', 400, 'affsig', [16,16,.000,.000,.000,.000] );
        Param.forMat = '.jpg';
    case('car4');
        Param.s0     =  [116 93 103 87 0];
        Param.param  = struct( 'numsample', 400, 'affsig', [16,16,.000,.000,.000,.000] );
        Param.forMat = '.jpg';
        
    case 'animal'; Param.s0 = [350, 40, 100, 70, 0];
        Param.param = struct('numsample',400, 'affsig',[16,16,.000,.000,.000,.000]);
        Param.forMat = '.jpg';
        
    case 'board'; Param.s0 = [154,243,195,153,0];
        Param.param = struct('numsample',100, 'affsig',[10, 10, .03, .00, .001, .00]);
        Param.forMat = '.jpg';
        
    case 'car11';  Param.s0 = [89 140 30 25 0];
        Param.param = struct('numsample',200, 'affsig',[5,5,.01,.01,.001,.001]);
        Param.forMat = '.jpg';
        
    case 'caviar'; Param.s0 = [162 216 50 140 0.0];
        Param.param = struct('numsample',120, 'affsig',[6,5,.01,.00,.001,.0000]);
        Param.forMat = '.jpg';
        
    case 'faceocc2'; Param.s0 = [156,107,74,100,0.00];
        Param.param = struct('numsample',100, 'affsig',[4, 4, .02, .03, .001,.000]);
        Param.forMat = '.jpg';
        
    case 'girl'; Param.s0 =   [180,109,104,127,0];
        Param.param = struct('numsample',200, 'affsig',[10,10,.08,.00,.000,.000]);
        Param.forMat = '.jpg';
        
    case 'jumping'; Param.s0 = [163,126,33,32,0];
        Param.param = struct('numsample',400, 'affsig',[8,18,.000,.000,.000,.00]);
        Param.forMat = '.jpg';
        
    case 'panda'; Param.s0 = [286 171 25 25 0.01];
        Param.param = struct('numsample',500, 'affsig',[9,9,.01,.000,.000,.0000]);
        Param.forMat = '.jpg';
        
    case 'shaking'; Param.s0 = [255, 170, 60, 70, 0 ];
        Param.param = struct('numsample',200, 'affsig',[4,4,.03,.00,.00,.00]);
        Param.forMat = '.jpg';
        
    case 'singer1'; Param.s0 = [100, 200, 100, 300, 0];
        Param.param = struct('numsample',100, 'affsig',[4,4,.05,.0005,.0005,.001]);
        Param.forMat = '.jpg';
        
    case 'stone'; Param.s0 = [115 150 43 20 0.0];
        Param.param = struct('numsample',300, 'affsig',[6,6,.01,.00,.000,.0000]);
        Param.forMat = '.jpg';
        
    case 'gym';         Param.s0 = [177,140,46,133,0.0];
        Param.param = struct('numsample',200, 'affsig',[8,5,.002,.0001,.002,.000]);
        Param.forMat = '.jpg';
        
    case 'basketball'; Param.s0 = [210,260,40,100,0];
        %         190 210 230 310
        Param.param = struct('numsample',100, 'affsig',[10, 10, .03, .00, .001, .00]);
        Param.forMat = '.jpg';
        
    case 'skating1';
        Param.s0 = [180,220,35,100,0.0];
        Param.param = struct('numsample',200, 'affsig',[8,5,.002,.0001,.002,.000]);
        Param.forMat = '.jpg';
        
    case 'mountationbike';
        Param.s0 = [358 210 58 53 0.00];
        Param.param = struct('numsample',100,'affsig',[4, 4, 0.01, .00, .00, .00]);
        Param.forMat = '.jpg';
        
    case 'motorrolling';
        Param.s0 = [178 131 122 125 0.00];    % the init state
        Param.param = struct('numsample', 100, 'affsig', [4 4 .02 .03 .001 .000]);
        Param.forMat = '.jpg';
        
    case 'soccer'; Param.s0 = [335, 175, 66, 80, 0];
        Param.param = struct('numsample',400, 'affsig',[8,8,.000,.000,.000,.000]);
        Param.forMat = '.jpg';
        
    case 'football';Param.s0 = [330 125 50 50 0.00];
        Param.param = struct('numsample',100,'affsig',[4, 4, 0.01, .00, .00, .00]);
        Param.forMat = '.jpg';
        
    case 'bolt';
        Param.s0 = [ 352 195.5 26 61 0];
        Param.param = struct('numsample',200, 'affsig',[4,4,.01,.000,.000,.000]);
        Param.forMat = '.jpg';
    otherwise;
        error( [ 'Unknown Sequence: ' seqId ] );
end

Param.dump = 0;