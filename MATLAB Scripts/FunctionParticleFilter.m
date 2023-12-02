function result = FunctionParticleFilter(robotDataFileLocation, mapDataFileLocation)

%robotPose = [];

robotData = dlmread(robotDataFileLocation);
mapData = dlmread(mapDataFileLocation);

% No. of Particles
numParticles = 500;

% Storing X, Y, theta and Weight of particles
particles = zeros(numParticles, 4);

for i = 1:numParticles
    particles(i, 1) = rand() * 700;
    particles(i, 2) = rand() * 85;
    particles(i, 3) = rand() * 2 * pi - pi;
    particles(i, 4) = 1/ numParticles;

end

%currentRobotX = 445;
%currentRobotY = 72;
%currentRobotTheta = 0;

for i = 1:size(robotData, 1)
    if robotData(i, 1) == 0
        % Updated Robot Position using the odometry model
        %[currentRobotX, currentRobotY, currentRobotTheta] = FunctionOdometryModel(data(i, :), currentRobotX, currentRobotY, currentRobotTheta);
        %robotPose = [robotPose; [currentRobotX, currentRobotY, currentRobotTheta]];

        % Propagating the particles using the odometry model
        for j = i:numParticles
            [particles(j, 1), particles(j, 2), particles(j, 3)] = FunctionOdometryModel(robotData(i, :), particles(j, 1), particles(j, 2), particles(j, 3));
        end

    elseif robotData(i, 1) == 1
        % Updated Robot Position using the odometry model
        %[currentRobotX, currentRobotY, currentRobotTheta] = FunctionOdometryModel(data(i, :), currentRobotX, currentRobotY, currentRobotTheta);
        %robotPose = [robotPose; [currentRobotX, currentRobotY, currentRobotTheta]];

        for j = i:numParticles
            particles(j, 4) = FunctionSensorModel(particles(j, 1:3), mapData, robotData(i, 8:187));
            [particles(j, 1), particles(j, 2), particles(j, 3)] = FunctionOdometryModel(robotData(i, :), particles(j, 1), particles(j, 2), particles(j, 3));
        end
    end
end

result = particles;

