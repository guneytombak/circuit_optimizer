%% Predefined Functions

nu = @(s) str2double(char(s));
%pm_func = @(hreal, himg) (pi - wrapTo2Pi(angle(hreal + 1i*himg)))*(180/pi);
pm_func = @gamzePM;

%% Naming

naming.name = "Two Stage OTA with 16 Transistors";
naming.exp = "PM high 45, front then homogeneity in crossMutation";
naming.dimens = ["$Gain \ (dB)$" "$Bandwidth_{log_{10}} \ [Hz]$" ...
    "$Power [W]$"];
naming.input = ["WM1" "WM2" "WM3" "WM4" "WM5" "WM6" "WM7" "WM8" ...
    "WM9" "WM10" "WM11" "Lcm" "Rb" "Cff"]; % input names
naming.output = ["Gain" "BW " "Pow"]; % output names
naming.unused = ["PM" "Area"]; % unused output names

%% Circuit Parameters

% files
ckt.name = 'bts';
ckt.inc = {'130nm.txt'};
ckt.ext = {'.ma0', '.mt0'};
ckt.numLines = {4,4};

% functions
ckt.y_func = @(x) [nu(x{2}), log10(nu(x{1})), nu(x{8})];
ckt.u_func = @(x) [pm_func(nu(x{4}), nu(x{3})), nu(x{9})];

% inputs
ckt.input_parameters = ["WM1" "WM2" "WM3" "WM4" "WM5" "WM6" "WM7" "WM8" ...
    "WM9" "WM10" "WM11" "Lcm" "Rb" "Cff"];

ckt.Cload = 0.5e-12;
ckt.dL = 0.5e-6;
ckt.dW = 1e-6;
ckt.numTrans = 16; 

% limits
L = ckt.dL; W = ckt.dW;

lims.xLo = [W W W W W W W W W W W L 500 0.1e-12]; 
lims.xUp = [200*W 200*W 200*W 200*W 200*W 200*W 200*W 200*W ...
    200*W 200*W 200*W 4*L 50e3 10e-12]; 
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
specs.iniPopMult = 5; 

specs.lims = lims;

specs.aup.file_name = '';