%% 1. Clear any old variables and command window outputs, and close any old figures.
clearvars; clc; close all;
%% 2. Add any required directories to MATLAB's path.
addpath(genpath(fileparts(mfilename('fullpath'))));
%% 3. Initialise the struct State.
State = struct;
%% 4. Configure the sub-struct State.Constants.
State = ConfigureConstants(State);