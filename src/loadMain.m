close all;
clear all;
format long;

pauseDur = 1e-5;
closeNo = 20;

set(0,'defaulttextInterpreter','latex');

%% Parallel Computing Start

pllFlag = 1;
noPool = 4;

pllStart;

%% Loading Parameters

addGen = 100; % additional generation number ---------------
fileName = ''; % the file to add on ------------------------
load(['results/' fileName]);

preData = data;
clear data;

preGen = preData.param.gen;
noGen = preGen + addGen;

%% Taking the Constants

preDate = preData.date;
preDur = preData.duration;
specs = preData.param;
titel = preData.title;
lims = preData.lims;
cir = preData.cir;

specs.gen = noGen;
N = specs.popSize;

%% Variable Extraction

preArch = preData.archive;
refDen = specs.refDen;

[~,~,noX] = size(preArch.X);
[~,~,noUx] = size(preArch.Ux);
[~,~,noY] = size(preArch.Y);
[~,~,noUy] = size(preArch.Uy);
%[~,noV] = size(preArch.rV);

toMaxY = preData.param.toMaxY;

%% Redefine Archive

% Archive Initialize (noGen = preGen + addGen)
arch.rX = zeros(noGen,2*N,noX);
arch.rUx = zeros(noGen,2*N,noUx);
arch.rY = zeros(noGen,2*N,noY);
arch.rUy = zeros(noGen,2*N,noUy);
%arch.rV = zeros(noGen,noV,2*N,transCount);
arch.err = cell(1,noGen);

arch.X = zeros(noGen,N,noX);
arch.Ux = zeros(noGen,N,noUx);
arch.Y = zeros(noGen,N,noY);
arch.Uy = zeros(noGen,N,noUy);
arch.gamma = zeros(noGen,N);

arch.Z = cell(1,noGen);
arch.nsgaData = cell(1,noGen);
arch.outOfRange = zeros(noGen,noX);

% Previous Arch Insert
arch.ini = preArch.ini;

arch.rX(1:preGen,:,:) = preArch.rX;
arch.rUx(1:preGen,:,:) = preArch.rUx;
arch.rY(1:preGen,:,:) = preArch.rY;
arch.rUy(1:preGen,:,:) = preArch.rUy;
%arch.rV(1:preGen,:,:,:) = preArch.rV;

arch.X(1:preGen,:,:) = preArch.X;
arch.Ux(1:preGen,:,:) = preArch.Ux;
arch.Y(1:preGen,:,:) = preArch.Y;
arch.Uy(1:preGen,:,:) = preArch.Uy;
arch.gamma(1:preGen,:) = preArch.gamma;

arch.outOfRange(1:preGen,:) = preArch.outOfRange;

for k = 1:preGen
    arch.err{k} = preArch.err{k};
    arch.Z{k} = preArch.Z{k};
    arch.nsgaData{k} = preArch.nsgaData{k};
end

%% Display Parameters

disp(specs);

%% Time calculation
calcTime = 88.3/100;

estTotDur = (addGen+1)*N*calcTime; 
estGenDur = N*calcTime;
disp(['Estimated generational duration: ' ...
    datestr(seconds(estGenDur),'HH:MM:SS')]);
disp(['Estimated simulation duration: ' ...
    datestr(seconds(estTotDur),'dd | HH:MM:SS')]);

tic; % start of duration timer

%% Initialize Population and Reference

iniX = preData.lastX; % initial population

Z = linGrid(refDen, noY);

%% Run

gen = preGen; % generation count

loop;

runDur = toc;

%% Parallel Computing Stop

delete(gcp('nocreate'));

%% Data Save

% last inputs
data.lastX = lastX;

% previous run time
data.preDate = preDate;
data.preDur = preDur;

% run duration
data.date = datetime;
data.runDur = runDur;

% total duration
data.duration = runDur + preDur;

% run specifications
data.param = specs;

% titles
data.title = titel;

% limits 
data.lims = lims;

% archive data
data.archive = arch;

% circuit data
data.cir = cir;

ymdStr = num2str(yyyymmdd(data.date));
[h,mi,s] = hms(data.date);

saveText = [ymdStr(3:end) '_' num2str(h) '-' num2str(mi)];

save(['./results/' saveText '.mat'], 'data');
