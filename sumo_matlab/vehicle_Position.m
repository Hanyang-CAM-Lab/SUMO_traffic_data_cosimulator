function Position = vehicle_Position(vehID)
%% Get the vehicle's location
% Get the ID of the vehicle
vehicle_num = length(vehID);
Position = vehID;
% Load the x and y axes of the vehicle
for i = 1:vehicle_num
    result =zeros(2,8);
    this = traci.sendReadOneStringCmd('0xa4','0x42',vehID{i});

    for j =1:2
     oldpos = this.pos;
     this.pos = this.pos + 8;
     result(j,:) = this.content(oldpos:this.pos-1);
    end
    
     Position(i,2)={typecast([fliplr(uint8(result(1,:)))],'double')}; %x축
     Position(i,3)={typecast([fliplr(uint8(result(2,:)))],'double')}; %y축


end