function [result] = FunctionParticleFilter(fileLocation)

data = dlmread(fileLocation);

result = [];

currentRobotX = 445;
currentRobotY = 72;
currentRobotTheta = 0;

for i = 1:size(data, 1)
    if data(i, 1) == 0
        [currentRobotX, currentRobotY, currentRobotTheta] = FunctionOdometryModel(data(i, 2), data(i, 3), data(i, 4), currentRobotX, currentRobotY, currentRobotTheta);
        result = [result; [currentRobotX, currentRobotY, currentRobotTheta]];
    elseif data(i, 1) == 1
        FunctionSensorModel();
        [currentRobotX, currentRobotY, currentRobotTheta] = FunctionOdometryModel(data(i, 2), data(i, 3), data(i, 4), currentRobotX, currentRobotY, currentRobotTheta);
        result = [result; [currentRobotX, currentRobotY, currentRobotTheta]];
    end
end

