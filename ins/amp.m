%% Predefined Functions

nu = @(s) str2double(char(s));
%pm_func = @(hreal, himg) (pi - wrapTo2Pi(angle(hreal + 1i*himg)))*(180/pi);
pm_func = @gamzePM;

%% Naming

naming.name = "One Stage Diff-Amp with 6 Transistors";
naming.exp = "PM high 45, front then homogeneity in crossMutation";
naming.dimens = ["$Gain \ (dB)$" "$Bandwidth_{log_{10}} \ [Hz]$" ...
    "$Power [W]$"];
naming.input = ["LM1" "LM2" "LM3" "WM1" "WM2" "WM3" "Ib"]; % input names
naming.output = ["Gain" "BW " "Pow"]; % output names
naming.unused = ["PM" "Area"]; % unused output names

%% Circuit Parameters

% files
ckt.name = 'amp';
ckt.inc = {'130nm.txt'};
ckt.ext = {'.ma0', '.mt0'};
ckt.numLines = {4,4};

% functions
ckt.y_func = @(x) [nu(x{2}), log10(nu(x{1})), nu(x{8})];
ckt.u_func = @(x) [pm_func(nu(x{4}), nu(x{3})), nu(x{9})];

% inputs
ckt.input_parameters = ["LM1" "LM2" "LM3" "WM1" "WM2" "WM3" "Ib"];

%ckt.Cload = 0.5e-12;
ckt.dL = 130e-9;
ckt.dW = 5*ckt.dL;
ckt.numTrans = 6; 

% limits
L = ckt.dL; W = ckt.dW;

lims.xLo = [L L L W W W 50e-6];  
lims.xUp = [10*L 10*L 10*L 150*W 150*W 150*W 1e-3]; 
lims.yLo = [NaN NaN NaN];
lims.yUp = [NaN NaN NaN];
lims.uLo = [45 NaN];
lims.uUp = [NaN NaN];

%% Run Parameters

noX = length(naming.input); % number of inputs
noY = length(naming.output); % number of outputs
noU = length(naming.unused); % number of unuseds

specs.popSize = N;
specs.noGen = noGen;
specs.refDen = n2refDen(N, noY);
specs.noZ = nchoosek(noY+specs.refDen-1,specs.refDen);

specs.noXYU = [noX noY noU];

specs.recCoef = 0.8;
specs.mssMuSig = [0.1 0.2];
specs.highY = [1 1 0];
specs.iniPopMult = 2; 

specs.lims = lims;

specs.aup.file_name = '';
specs.slp.file_name = 'slp_amp_200520_20-22.mat';
