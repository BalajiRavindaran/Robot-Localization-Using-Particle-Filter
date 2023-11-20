data = dlmread("output_file.dat");

% Assuming binaryData contains your binary data (85 rows x 700 columns)

% Display the binary data as a black and white image
imshow(data, 'InitialMagnification', 'fit');

% Set colormap to display black and white
colormap(flipud(gray));

% Set title and axis labels (optional)
title('Binary Map');
xlabel('Columns');
ylabel('Rows');