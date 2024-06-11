clear all
% Specify the file path
file_path = ['C:\Users\dando\Desktop\3.12.23M3Vor\ctrl.xlsx'];

[numData, ~, ~] = xlsread(file_path);
data = numData(:,1:end);
time = data(:,1);
cells = data(:,3:end);
plot(cells);

BG1 = 14;
BG2 = 21;
Fmin1 = mean(cells(BG1:BG2, :));


App1 = 26;
App2 = 82;
Fmax1 = max(cells(App1:App2, :));

BG3 = 127;
BG4 = 133;
Fmin2 = mean(cells(BG3:BG4, :));


App3 = 138;
App4 = 218;
Fmax2 = max(cells(App3:App4, :));


DeltaF1 = Fmax1 - Fmin1;
DeltaF1overF0 = DeltaF1 ./ Fmin1;
DeltaF2 = Fmax2 - Fmin2;
DeltaF2overF0 = DeltaF2 ./ Fmin2;
DeltaFnorm = DeltaF2 ./ DeltaF1;

meanValuesSelect = mean(DeltaF1overF0);
stdErrorValuesSelect = std(DeltaF1overF0) / sqrt(size(DeltaF1overF0, 2));

meanValuesSelect2 = mean(DeltaF2overF0);
stdErrorValuesSelect2 = std(DeltaF2overF0) / sqrt(size(DeltaF2overF0, 2));

bar([meanValuesSelect, meanValuesSelect2]);
hold on;
errorbar([1, 2], [meanValuesSelect, meanValuesSelect2], [stdErrorValuesSelect, stdErrorValuesSelect2], 'k', 'LineStyle', 'none', 'CapSize', 10);
hold off;

plot(cells)
hold on;
for i = 1:size(cells, 2)
    fill([App1, App2, App2, App1], ...
        [min(cells(:, i)), min(cells(:, i)), max(cells(:, i)), max(cells(:, i))], 'c', 'FaceAlpha', 0);
    fill([BG1, BG2, BG2, BG1], ...
        [min(cells(:, i)), min(cells(:, i)), max(cells(:, i)), max(cells(:, i))], 'r', 'FaceAlpha', 0);
    fill([BG3, BG4, BG4, BG3], ...
        [min(cells(:, i)), min(cells(:, i)), max(cells(:, i)), max(cells(:, i))], 'r', 'FaceAlpha', 0);
    fill([App3, App4, App4, App3], ...
        [min(cells(:, i)), min(cells(:, i)), max(cells(:, i)), max(cells(:, i))], 'r', 'FaceAlpha', 0);

end
hold off;

