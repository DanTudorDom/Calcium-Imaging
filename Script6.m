clear;
% Step 1: Read data from the Excel file
filename = 'C:\Users\dando\Desktop\DRG_TRPA1\V10';  % Replace with your actual path
data = readtable(filename, 'ReadVariableNames', false);
data = data(2:end, :);
% Extract time and cell data
time = table2array(data(:, 1));
cells = table2array(data(:, 3:end));
BK = table2array(data(:, 2));
cells = cells - BK;

% Define frames for intervals and intervalsBK (in time units)
framesIntervals = [60, 219; 689, 840];
framesIntervalsBK = [40, 60; 669, 689];

% Initialize arrays to store the closest time points
closestTimesIntervals = zeros(size(framesIntervals));
closestIndicesIntervals = zeros(size(framesIntervals));

closestTimesIntervalsBK = zeros(size(framesIntervalsBK));
closestIndicesIntervalsBK = zeros(size(framesIntervalsBK));

% Find the closest time points and their corresponding indices for the framesIntervals
for i = 1:size(framesIntervals, 1)
    for j = 1:size(framesIntervals, 2)
        [~, idx] = min(abs(time - framesIntervals(i, j)));
        closestTimesIntervals(i, j) = time(idx);
        closestIndicesIntervals(i, j) = idx;
    end
end

% Find the closest time points and their corresponding indices for the framesIntervalsBK
for i = 1:size(framesIntervalsBK, 1)
    for j = 1:size(framesIntervalsBK, 2)
        [~, idx] = min(abs(time - framesIntervalsBK(i, j)));
        closestTimesIntervalsBK(i, j) = time(idx);
        closestIndicesIntervalsBK(i, j) = idx;
    end
end


% Define intervals using the found indices
intervals = closestIndicesIntervals;
intervalsBK = closestIndicesIntervalsBK;

% Initialize arrays to store max and min values
maxValues = zeros(size(intervals, 1), size(cells, 2));
minValues = zeros(size(intervals, 1), size(cells, 2));

% Loop through each interval to find the max and min values within each column
for i = 1:size(intervals, 1)
    % Use the indices for indexing
    startIdx = intervals(i, 1);
    stopIdx = intervals(i, 2);
    
    % Extract the data within the interval
    intervalData = cells(startIdx:stopIdx, :);
    
    % Calculate max and min values within the interval for each column
    maxValues(i, :) = max(intervalData, [], 1);
    minValues(i, :) = min(intervalData, [], 1);
end

% Initialize arrays to store max and min values for BK intervals
maxValuesBK = zeros(size(intervalsBK, 1), size(cells, 2));
minValuesBK = zeros(size(intervalsBK, 1), size(cells, 2));

% Loop through each BK interval to find the max and min values within each column
for j = 1:size(intervalsBK, 1)
    % Use the indices for indexing
    startIdxBK = intervalsBK(j, 1);
    stopIdxBK = intervalsBK(j, 2);
    
    % Extract the data within the interval
    intervalDataBK = cells(startIdxBK:stopIdxBK, :);
    
    % Calculate max and min values within the interval for each column
    maxValuesBK(j, :) = max(intervalDataBK, [], 1);
    minValuesBK(j, :) = min(intervalDataBK, [], 1);
end

% Plot the cell data
figure;
hold on;
plot(time, cells);

% Define colors for the intervals
intervalColors = {'r', 'g'};
intervalBKColors = {'b', 'm'};

% Plot the intervals
for i = 1:size(intervals, 1)
    startIdx = intervals(i, 1);
    stopIdx = intervals(i, 2);
    % Plot shaded area for the interval
    fill([time(startIdx) time(stopIdx) time(stopIdx) time(startIdx)], ...
         [min(min(cells)) min(min(cells)) max(max(cells)) max(max(cells))], ...
         intervalColors{i}, 'FaceAlpha', 0.2, 'EdgeColor', 'none');
end

for i = 1:size(intervalsBK, 1)
    startIdxBK = intervalsBK(i, 1);
    stopIdxBK = intervalsBK(i, 2);
    % Plot shaded area for the BK interval
    fill([time(startIdxBK) time(stopIdxBK) time(stopIdxBK) time(startIdxBK)], ...
         [min(min(cells)) min(min(cells)) max(max(cells)) max(max(cells))], ...
         intervalBKColors{i}, 'FaceAlpha', 0.2, 'EdgeColor', 'none');
end

hold off;
title('Cell Data with Highlighted Intervals');
xlabel('Time');
ylabel('Cell Data');
legend({'Cell Data', 'Interval 1', 'Interval 2', 'Interval BK 1', 'Interval BK 2'}, 'Location', 'Best');

df = maxValues - minValuesBK;
dff0 = df ./ minValuesBK;

PassApp1  = zeros(size(dff0));

            % Loop through each element and use the processColumnNumber function
            
for i = 1:length(dff0)
    PassApp1(i) = DFcheck(dff0(i));
end

positiveColumnNumbers = arrayfun(@(row) find(PassApp1(row, :) == 1), 1:size(PassApp1, 1), 'UniformOutput', false);

PassAppA = cell2mat(positiveColumnNumbers);

App1Positive = cells(:, PassAppA);

cells = App1Positive;

for i = 1:size(framesIntervals, 1)
    for j = 1:size(framesIntervals, 2)
        [~, idx] = min(abs(time - framesIntervals(i, j)));
        closestTimesIntervals(i, j) = time(idx);
        closestIndicesIntervals(i, j) = idx;
    end
end

% Find the closest time points and their corresponding indices for the framesIntervalsBK
for i = 1:size(framesIntervalsBK, 1)
    for j = 1:size(framesIntervalsBK, 2)
        [~, idx] = min(abs(time - framesIntervalsBK(i, j)));
        closestTimesIntervalsBK(i, j) = time(idx);
        closestIndicesIntervalsBK(i, j) = idx;
    end
end


% Define intervals using the found indices
intervals = closestIndicesIntervals;
intervalsBK = closestIndicesIntervalsBK;

% Initialize arrays to store max and min values
maxValues = zeros(size(intervals, 1), size(cells, 2));
minValues = zeros(size(intervals, 1), size(cells, 2));

% Loop through each interval to find the max and min values within each column
for i = 1:size(intervals, 1)
    % Use the indices for indexing
    startIdx = intervals(i, 1);
    stopIdx = intervals(i, 2);
    
    % Extract the data within the interval
    intervalData = cells(startIdx:stopIdx, :);
    
    % Calculate max and min values within the interval for each column
    maxValues(i, :) = max(intervalData, [], 1);
    minValues(i, :) = min(intervalData, [], 1);
end

% Initialize arrays to store max and min values for BK intervals
maxValuesBK = zeros(size(intervalsBK, 1), size(cells, 2));
minValuesBK = zeros(size(intervalsBK, 1), size(cells, 2));

% Loop through each BK interval to find the max and min values within each column
for j = 1:size(intervalsBK, 1)
    % Use the indices for indexing
    startIdxBK = intervalsBK(j, 1);
    stopIdxBK = intervalsBK(j, 2);
    
    % Extract the data within the interval
    intervalDataBK = cells(startIdxBK:stopIdxBK, :);
    
    % Calculate max and min values within the interval for each column
    maxValuesBK(j, :) = max(intervalDataBK, [], 1);
    minValuesBK(j, :) = min(intervalDataBK, [], 1);
end

% Plot the cell data
figure;
hold on;
plot(time, cells);

% Define colors for the intervals
intervalColors = {'r', 'g'};
intervalBKColors = {'b', 'm'};

% Plot the intervals
for i = 1:size(intervals, 1)
    startIdx = intervals(i, 1);
    stopIdx = intervals(i, 2);
    % Plot shaded area for the interval
    fill([time(startIdx) time(stopIdx) time(stopIdx) time(startIdx)], ...
         [min(min(cells)) min(min(cells)) max(max(cells)) max(max(cells))], ...
         intervalColors{i}, 'FaceAlpha', 0.2, 'EdgeColor', 'none');
end

for i = 1:size(intervalsBK, 1)
    startIdxBK = intervalsBK(i, 1);
    stopIdxBK = intervalsBK(i, 2);
    % Plot shaded area for the BK interval
    fill([time(startIdxBK) time(stopIdxBK) time(stopIdxBK) time(startIdxBK)], ...
         [min(min(cells)) min(min(cells)) max(max(cells)) max(max(cells))], ...
         intervalBKColors{i}, 'FaceAlpha', 0, 'EdgeColor', 'none');
end

hold off;
title('Cell Data with Highlighted Intervals');
xlabel('Time');
ylabel('Cell Data');
legend({'Cell Data', 'Interval 1', 'Interval 2', 'Interval BK 1', 'Interval BK 2'}, 'Location', 'Best');

df = maxValues - minValuesBK;
dff0 = df ./ minValuesBK;

normDF = dff0(2, :) ./ dff0(1, :);
normDF = normDF';
avg = mean(normDF);
SEM = std(normDF, 0, 1) / sqrt(size(normDF, 1));

meanCells = mean(cells, 2);
plot(meanCells)