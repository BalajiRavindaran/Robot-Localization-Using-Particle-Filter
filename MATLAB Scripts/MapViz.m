data = dlmread("Data\map2023DAT.dat" );

% Display the binary data as Black& White
imshow(data, 'InitialMagnification', 'fit');

% Fliping color map 0 => White (Free Space), 1 => Black (Occupied)
colormap(flipud(gray));

hold on;

% Define robot's initial position
robot_x = 445; % X-coordinate of robot's initial position
robot_y = 72;  % Y-coordinate of robot's initial position
robot_width = 20; % Robot's width
robot_height = 13; % Robot's height

% Plot the robot as a filled rectangle
rectangle('Position', [robot_x, robot_y, robot_width, robot_height], 'EdgeColor', 'black', 'FaceColor', 'red');

title('Binary Map');
xlabel('Columns');
ylabel('Rows');

hold off; % Disable hold