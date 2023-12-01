clear all
close all
clc
%% Load sumo file to run
% 'sumo_matlab' file location
file_location = 'C:\Users\User\Desktop\SUMO_traffic_data_cosimulator';

% sumo road to use
file_road = 'straight_trafficlight';
% file_road = 'highway_nomal';
%file_road = 'cross2';
%file_road = 'cross';

file_road_sumo = strcat(file_road, '.sumocfg');
scenarioPath = fullfile(file_location,'maps', file_road, file_road_sumo);

% sumo matlab connection
traci.start(['sumo-gui -c ' '"' scenarioPath '"' ' --start']);

% simulation time (one step = 0.1 s) ex) run_time_step = 2000 (200 s) 
run_time_step = 2000;

% Maximum number of vehicles specified by sumo 
% (Must match the maximum number of vehicles specified by sumo)
veh = 200;

% Initializing vehicle dataset
mydata = zeros(veh, 4, run_time_step);
angle = zeros(1,veh);
height = zeros(1,veh);
width = zeros(1,veh);
speed = zeros(1,veh);
Length = zeros(1,veh);
%Simulate one step execution
traci.simulation.step();

%Simulation run time
current_time =1;

while 1
    %Simulate one step execution
    traci.simulation.step();   
    %Get the vehicle ID created on the map
    vehicle_ID = traci.vehicle.getIDList;
  
% Save the dataset when it matches the maximum number of vehicles specified in Sumo
if length(vehicle_ID)>=veh
     % Load data for each vehicle
    pos = vehicle_Position(vehicle_ID');
    for z =1 :veh
        V_ID = cell2mat(vehicle_ID(z));
        angle(z) = uint8(traci.vehicle.getAngle(V_ID));
        height(z)= uint8(traci.vehicle.getHeight(V_ID));
        width(z)= uint8(traci.vehicle.getWidth(V_ID));
        speed(z)= uint8(traci.vehicle.getSpeed(V_ID));
        Length(z)= uint8(traci.vehicle.getLength(V_ID));
    end
    % Save loaded data
    % relative ID, absolute ID, x-axis position, y-axis position, speed,
    % width, Length, height, angle
    mydata(1:length(pos(:,1)),1,current_time) = (1:length(pos(:,1)))';
    mydata(1:length(pos(:,1)),2,current_time) = str2double(pos(:,1));
    mydata(1:length(pos(:,1)),3:4,current_time) = cell2mat(pos(:,2:3));
    mydata(1:length(pos(:,1)),5,current_time) =speed;
    mydata(1:length(pos(:,1)),6,current_time) =width;
    mydata(1:length(pos(:,1)),7,current_time) =Length;
    mydata(1:length(pos(:,1)),8,current_time) = height;
    mydata(1:length(pos(:,1)),9,current_time) = angle;
    
    % Simulation ends
    if current_time==run_time_step
        break;
    end
    current_time=current_time+1;
end
end
% dataset file save
save_name ='highway_nomal_time200_veh200.mat';
scenarioPath = fullfile(file_location,'data',save_name);
save(scenarioPath, 'mydata')
% sumo close
traci.close();

