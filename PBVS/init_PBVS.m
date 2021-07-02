clear, clc, close all;

%% parameters

O = [0; 0; 0];        % world origin frame
C = [0.2; 0.3; 0.2];  % camera origin frame

f = 0.5;             % focal lenght
% p = [2.1; 0.17; 0.8]; % point's position (x,y,z) in world frame

d = C - O;            % distance between camera and world frame
ang = [pi/2  0  pi/2];  % initial orientation, [pi 0 pi/2] 
init_pose = [C ; ang'];
frequency = 200;       % sampling frequency [Hz]
dT = 1/frequency;      % sampling time [s]


% % points' position (x,y,z) in world frame
p1 = [1.7; 0.65; 0.6]; 
p2 = [1.7; 0.85; 0.1]; 
% reference 
%ref1 = [-0.18; -0.0];
%ref2 = [0.18;  -0.0];
%ref = [ref1; ref2];
ref = [-0.2; 0; 0; pi/2; 0 ; pi/2];

% control
Kp = 1*eye(6);
Kd = 0*eye(6);
