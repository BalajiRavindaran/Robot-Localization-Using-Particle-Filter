dataset = dlmread("../Python Scripts/likelihoodMap.dat");

% Apply a logarithmic transformation to enhance the gradual differences
log_transformed_data = log(1 + dataset * 100);

% Normalize the transformed dataset values to the range [0, 1] for grayscale mapping
normalized_data = (log_transformed_data - min(log_transformed_data(:))) / (max(log_transformed_data(:)) - min(log_transformed_data(:)));

% Plotting the enhanced grayscale plot as an image
figure;
imagesc(normalized_data); % Plot the enhanced grayscale image
colormap(gray); % Set the colormap to grayscale

% Customize the plot
colorbar; % Show colorbar to indicate the values
xlabel('Columns');
ylabel('Rows');
title('Likelihood Field Map');