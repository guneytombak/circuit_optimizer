close all;
clear all;
format long;

pause_duration = 1e-5;
numClose = 20;

set(0,'defaulttextInterpreter','latex');

%% File/Load Name

file_name = 'amp';
N = 1000; if mod(N,2), N = N + 1; end
noGen = 200; 

load_name = '';
addGen = 100;

%% Parallel Computing Start

pll.flag = 1;
pll.numWorkers = 4;

parallel_start;

%% Matlab Version Controller

version_controlling;

%% Run Options 

run_options;

%% Archive Initialization

archive_initialization;

%% Directory Creation

directory_creation;

%% Time Start

tic; % start of duration timer

%% Initialization of Run

run_initizalization;

%% Run

loop;

total_duration = toc;

%% Parallel Computing Stop

delete(gcp('nocreate'));

%% Data Save

data_save;