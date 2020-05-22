close all;
clear all;
format long;

%% Figure Parameters

pause_duration = 1e-5;
act_fig_no = 10;
AZ = -60; EL = 45;
fig_pos_vec = [0.3 0.2 0.4 0.65];
fig_flag = 1;

set(0,'defaulttextInterpreter','latex');

%% File/Load Name

file_name = 'amp_ex';
N = 30; if mod(N,2), N = N + 1; end
noGen = 20; 

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