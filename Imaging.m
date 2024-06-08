% Define time points and find closest indices
clear
filename = 'C:\Users\dando\Desktop\TAS_Project\3.12.23M3Vor\v82.txt';  
data = readtable(filename, 'ReadVariableNames', false);
data = data(2:end, :);

% Extract data
cells = table2array(data(:, 3:end));
time = table2array(data(:, 1));
BK = table2array(data(:, 2));
InitialCells = cells;
figure;
plot(InitialCells);

% Subtract BK from cells and plot
cells = cells - BK;
figure;
plot(cells);

% InitialCells = cells;

% Filter out columns based on threshold
thresholdValue1 = 100;
selectedColumns1 = any(cells(1:50, :) > thresholdValue1, 1);
cells = cells(:, ~selectedColumns1);

% Calculate and plot mean of cells
meanCells = mean(cells, 2);
figure;
plot(meanCells);

% Compute and plot moving mean of cells
smoothData = movmean(cells, 5);
figure;
plot(smoothData);

% Plot mean cells again
figure;
time1 = time ./ 60;
plot(time, meanCells);


AppTime = [56, 200, 296, 440, 526, 690];
BKtime = [1, 40, 45, 55, 285, 295, 515, 525];

findClosestIndices = @(refTimes, times) arrayfun(@(t) find(abs(times - t) == min(abs(times - t)), 1), refTimes);

App = findClosestIndices(AppTime, time);
BK = findClosestIndices(BKtime, time);

% Calculate means for intervals
calcMean = @(indices) mean(cells(indices(1):indices(2), :));

meanBK = calcMean(BK(1:2));
meanIntervals = arrayfun(@(i) calcMean(App(i:i+1)), 1:2:length(App)-1, 'UniformOutput', false);

% Access means
meanAp1 = meanIntervals{1};
meanAp2 = meanIntervals{2};
meanAp3 = meanIntervals{3};

meanCells = mean(InitialCells, 2);
figure;

% Plot the mean of cells with x-axis ticks at increments of 60
subplot(2, 1, 1);
plot(time, meanCells);
title('Mean Cells');
xlabel('Time');
ylabel('Mean Cells');
xticks(min(time):60:max(time));  % Set x-axis ticks in increments of 60


% Plot cells
subplot(2, 1, 2);
plot(InitialCells);
title('Cells');
xlabel('Time');
ylabel('Cells');
hold on;

% Correct fillAreas function
fillAreas = @(startIdx, endIdx, color, minVal, maxVal) fill([startIdx, endIdx, endIdx, startIdx], ...
    [minVal, minVal, maxVal, maxVal], color, 'FaceAlpha', 0, 'EdgeColor', color);

for i = 1:size(cells, 2)
    minVal = min(cells(:, i));
    maxVal = max(cells(:, i));
    
    fillAreas(App(1), App(2), 'g', minVal, maxVal);
    fillAreas(BK(1), BK(2), 'g', minVal, maxVal);
    fillAreas(App(3), App(4), 'g', minVal, maxVal);
    fillAreas(BK(3), BK(4), 'g', minVal, maxVal);
    fillAreas(App(5), App(6), 'r', minVal, maxVal);
    fillAreas(BK(7), BK(8), 'r', minVal, maxVal);
    fillAreas(BK(5), BK(6), 'r', minVal, maxVal);
end
hold off;


stdAp2b = std(cells(BK(5):BK(6), :));
checkAp2 = meanAp2 - (mean(cells(BK(5):BK(6), :)) + 1 * stdAp2b);


% Process columns above threshold
passThreshold = @(checkValues) arrayfun(@(val) processColumnNumberAbove(val), checkValues);

passAp2 = passThreshold(checkAp2);
processColumnNumberAbove = @(row) find(passAp2(row, :) == 1);
passApA2 = cell2mat(arrayfun(processColumnNumberAbove, 1:size(passAp2, 1), 'UniformOutput', false));
cells = cells(:, passApA2);
%%

% % Calculate standard deviation and check
% stdAp3 = std(cells(App(5):App(6), :));
% checkAp3 = meanAp3 - (mean(cells(BK(7):BK(8), :)) + 2 * stdAp3);
% 
% % Process columns above threshold
% passThreshold = @(checkValues) arrayfun(@(val) processColumnNumberAbove(val), checkValues);
% 
% passAp3 = passThreshold(checkAp3);
% processColumnNumberAbove = @(row) find(passAp3(row, :) == 1);
% passApA3 = cell2mat(arrayfun(processColumnNumberAbove, 1:size(passAp3, 1), 'UniformOutput', false));
% cells = cells(:, passApA3);
%%
% Calculate the mean of cells along the second dimension
% Final plot
meanCells = mean(cells, 2);
figure;

% Plot the mean of cells with x-axis ticks at increments of 60
subplot(2, 1, 1);
plot(time, meanCells);
title('Mean Cells');
xlabel('Time');
ylabel('Mean Cells');
xticks(min(time):60:max(time));  % Set x-axis ticks in increments of 60

% Plot cells
subplot(2, 1, 2);
plot(cells);
title('Cells');
xlabel('Time');
ylabel('Cells');
hold on;

% Correct fillAreas function
fillAreas = @(startIdx, endIdx, color, minVal, maxVal) fill([startIdx, endIdx, endIdx, startIdx], ...
    [minVal, minVal, maxVal, maxVal], color, 'FaceAlpha', 0, 'EdgeColor', color);

for i = 1:size(cells, 2)
    minVal = min(cells(:, i));
    maxVal = max(cells(:, i));
    
    fillAreas(App(1), App(2), 'g', minVal, maxVal);
    fillAreas(BK(1), BK(2), 'g', minVal, maxVal);
    fillAreas(App(3), App(4), 'g', minVal, maxVal);
    fillAreas(BK(3), BK(4), 'g', minVal, maxVal);
    fillAreas(App(5), App(6), 'r', minVal, maxVal);
    fillAreas(BK(7), BK(8), 'r', minVal, maxVal);
    fillAreas(BK(5), BK(6), 'r', minVal, maxVal);
end
hold off;
%%



% Final plot
meanCells = mean(cells, 2);
figure;
subplot(2, 1, 1);
plot(time, meanCells);
subplot(2, 1, 2);
plot(cells);
hold on;

% Correct fillAreas function
fillAreas = @(startIdx, endIdx, color, minVal, maxVal) fill([startIdx, endIdx, endIdx, startIdx], ...
    [minVal, minVal, maxVal, maxVal], color, 'FaceAlpha', 0, 'EdgeColor', color);

for i = 1:size(cells, 2)
    minVal = min(cells(:, i));
    maxVal = max(cells(:, i));
    
    fillAreas(App(1), App(2), 'g', minVal, maxVal);
    fillAreas(BK(1), BK(2), 'g', minVal, maxVal);
    fillAreas(App(3), App(4), 'g', minVal, maxVal);
    fillAreas(BK(3), BK(4), 'g', minVal, maxVal);
    fillAreas(App(5), App(6), 'r', minVal, maxVal);
    fillAreas(BK(7), BK(8), 'r', minVal, maxVal);
    fillAreas(BK(5), BK(6), 'r', minVal, maxVal);
end
hold off;

% Compute and transpose Standard Error of the Mean (SEM)
SEM = std(cells) / sqrt(size(cells, 2));
SEM = SEM';

% Uncomment to save data to file
% filename = 'sucrD1.txt';
% export = [time, cells];
% writematrix(export, filename);
