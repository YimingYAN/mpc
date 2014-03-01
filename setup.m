% SETUP
% This scrtipt is used to setup the system enviroment for the solver.
% Necessory paths will be added.
%
% Please run this secript at the root of the folder.
%
% Yiming @ Uinversity of Edinburgh
clear;
clc;

folderLocation = pwd;

% add paths
disp('* Add necessary paths...');
if isunix || ismac
    addpath(folderLocation);
    addpath([folderLocation '/src']);
    addpath([folderLocation '/examples']);
elseif ispc
    addpath(folderLocation);
    addpath([folderLocation '\src']);
    addpath([folderLocation '\examples']);
else
    error('    Cannot determine your OS.')
end

disp('    Done.')

% try to save the paths to Matlab
reply = input('* Do you want save the paht? Y/N [Y]:','s');
if isempty(reply)
    reply = 'Y';
end

if strcmpi(reply,'y')
    flag = savepath;
    if flag == 1
        disp('    Cannot save the path. Please check if you have admin rights.')
    else
        disp('    Path saved successfully.');
    end
else
    disp('    Saving path aborted.');
end

disp('Done.');

clear;
