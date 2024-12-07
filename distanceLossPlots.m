close all;

% We start with the number of infractions in each RWY
totalViolations24L = length(LoAviolations24L) + length(RADARviolations24L)...
    + length(WakeViolations24L);
violationsPerType24L = [length(LoAviolations24L), length(RADARviolations24L),...
    length(WakeViolations24L)];

totalViolations06R = length(LoAviolations06R) + length(RADARviolations06R)...
    + length(WakeViolations06R);
violationsPerType06R = [length(LoAviolations06R), length(RADARviolations06R),...
    length(WakeViolations06R)];

typeOfViolation= {'LoA', 'Radar', 'Wake'};

%% NUMBER OF VIOLATIONS AND DISTRIBUTION
figure;
subplot(1,2,1)
bar(violationsPerType24L);
set(gca, 'XTickLabel', typeOfViolation);
title('Distribution of Distance Violations by Type (at 24L)',...
    'FontName','Times New Roman');
ylabel('Violations per Day','FontName','Times New Roman');
xlabel('Type of Violation','FontName','Times New Roman');

for i = 1:length(violationsPerType24L)
    percentage = (violationsPerType24L(i) / totalViolations24L) * 100;
    text(i, 7, sprintf('%.1f%%', percentage), ...
        'HorizontalAlignment', 'center', 'VerticalAlignment', 'top',...
        'FontSize', 10,'FontName','Times New Roman');
end

subplot(1,2,2)
bar(violationsPerType06R);
set(gca, 'XTickLabel', typeOfViolation);
title('Distribution of Distance Violations by Type (at 06R)',...
    'FontName','Times New Roman');
ylabel('Violations per Day','FontName','Times New Roman');
xlabel('Type of Violation','FontName','Times New Roman');

for i = 1:length(violationsPerType06R)
    percentage = (violationsPerType06R(i) / totalViolations06R) * 100;
    text(i, 0.2, sprintf('%.1f%%', percentage), ...
        'HorizontalAlignment', 'center', 'VerticalAlignment', 'top',...
        'FontSize', 10,'FontName','Times New Roman');
end

%% ANALYSIS OF LoA VIOLATIONS - 24L

% LoA degree of violation
catOfViolation = strings(1, length(LoAviolations24L));

LoAseparation = [LoAviolations24L.Separation];
LoArequiredSeparation = [LoAviolations24L.RequiredSeparation];

slightLoAViolations = 0;
mediumLoAViolations = 0;
severeLoAViolations = 0;

for i=1:length(LoAviolations24L)
    percentage(i) = (1 - LoAseparation(i)/LoArequiredSeparation(i))*100;
    if percentage(i) <= 5
        slightLoAViolations = slightLoAViolations + 1;
    elseif percentage(i) > 5 && percentage(i) <=10
        mediumLoAViolations = mediumLoAViolations + 1;
    elseif percentage(i) > 10
        severeLoAViolations = severeLoAViolations + 1;
    end
end

LoAViolations = [slightLoAViolations, mediumLoAViolations, severeLoAViolations];
totalLoAViolations = length(LoAviolations24L);
figure;
percentageValues = LoAViolations / totalLoAViolations * 100;

bar(percentageValues);
set(gca, 'XTickLabel', {'Slight (x < 5%)', 'Medium (5% < x < 10%)',...
    'Severe (x > 10%)'});

for i = 1:length(percentageValues)
    text(i, percentageValues(i), sprintf('%.2f%%', percentageValues(i)), ...
        'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom',...
        'FontSize', 10, 'FontName','Times New Roman');
end

title('Distribution of Violation Degree (at 24L)','FontName','Times New Roman');
ylabel('Percentage of Violations','FontName','Times New Roman');

% LoA infractors
classRinfractors = 0;
classHPinfractors = 0;
classLPinfractors = 0;
classNRPosInfractors = 0;
classNRNegInfractors = 0;
classNoReactInfractors = 0;

for i = 1:length(LoAviolations24L)
    if strcmp(LoAviolations24L(i).InfractorClass, 'R')
        classRinfractors = classRinfractors + 1;
    elseif strcmp(LoAviolations24L(i).InfractorClass, 'HP')
        classHPinfractors = classHPinfractors + 1;
    elseif strcmp(LoAviolations24L(i).InfractorClass, 'LP')
        classLPinfractors = classLPinfractors + 1;
    elseif strcmp(LoAviolations24L(i).InfractorClass, 'NR+')
        classNRPosInfractors = classNRPosInfractors + 1;
    elseif strcmp(LoAviolations24L(i).InfractorClass, 'NR-')
        classNRNegInfractors = classNRNegInfractors + 1;
    elseif strcmp(LoAviolations24L(i).InfractorClass, 'NO REACTOR')
        classNoReactInfractors = classNoReactInfractors + 1;
    end
end

classInfractors = [classRinfractors, classHPinfractors,...
    classLPinfractors, classNRPosInfractors, classNRNegInfractors,...
    classNoReactInfractors];

figure;
labels = {'R', 'HP', 'LP', 'NR+', 'NR-', 'NO REACTOR'};
bar(classInfractors)
set(gca, 'XTickLabel', labels);

title('Distribution of LoA Infractors by Class (at 24L)','FontName','Times New Roman');
ylabel('Number of Infractors','FontName','Times New Roman');
xlabel('Class Types','FontName','Times New Roman');

% Now the SID
% Subplot 1: Analysis for InfractorSID
subplot(2, 2, 1);

infractor_counts = groupcounts(string({LoAviolations24L.InfractorSID}'));

[~, worst_idx_1] = max(infractor_counts);
worst_SID_1 = unique(string({LoAviolations24L.InfractorSID}'));
worst_SID_1 = worst_SID_1(worst_idx_1);

[~, best_idx_1] = min(infractor_counts);
best_SID_1 = unique(string({LoAviolations24L.InfractorSID}'));
best_SID_1 = best_SID_1(best_idx_1);

x_labels_1 = {['Worst: ', char(worst_SID_1)],...
    ['Best: ', char(best_SID_1)], 'FontName','Times New Roman'};
y_values_1 = [max(infractor_counts), min(infractor_counts)];

b1 = bar(y_values_1);
b1.FaceColor = 'flat';
b1.CData(1, :) = [254, 64, 64] / 255;
xticks(1:2);
xticklabels(x_labels_1);
ylabel('Count', 'FontName','Times New Roman');
title('InfractorSID Analysis', 'FontName','Times New Roman');
grid on;

% Subplot 2: Analysis for VictimSID
subplot(2, 2, 2);

victim_counts = groupcounts(string({LoAviolations24L.VictimSID}'));

[~, worst_idx_2] = max(victim_counts);
worst_SID_2 = unique(string({LoAviolations24L.VictimSID}'));
worst_SID_2 = worst_SID_2(worst_idx_2);

[~, best_idx_2] = min(victim_counts);
best_SID_2 = unique(string({LoAviolations24L.VictimSID}'));
best_SID_2 = best_SID_2(best_idx_2);

x_labels_2 = {['Worst: ', char(worst_SID_2)],...
    ['Best: ', char(best_SID_2)], 'FontName','Times New Roman'};
y_values_2 = [max(victim_counts), min(victim_counts)];

b2 = bar(y_values_2);
b2.FaceColor = 'flat';
b2.CData(1, :) = [254, 64, 64] / 255; 
xticks(1:2);
xticklabels(x_labels_2);
ylabel('Count', 'FontName','Times New Roman');
title('VictimSID Analysis', 'FontName','Times New Roman');
grid on;

% Subplot 3: Analysis for InfractorClass
subplot(2, 2, 3);

infractor_class_counts = groupcounts(string({LoAviolations24L.InfractorClass}'));

[~, worst_idx_3] = max(infractor_class_counts);
worst_class_3 = unique(string({LoAviolations24L.InfractorClass}'));
worst_class_3 = worst_class_3(worst_idx_3);

[~, best_idx_3] = min(infractor_class_counts);
best_class_3 = unique(string({LoAviolations24L.InfractorClass}'));
best_class_3 = best_class_3(best_idx_3);

x_labels_3 = {['Worst: ', char(worst_class_3)],...
    ['Best: ', char(best_class_3)], 'FontName','Times New Roman'};
y_values_3 = [max(infractor_class_counts), min(infractor_class_counts)];

b3 = bar(y_values_3);
b3.FaceColor = 'flat';
b3.CData(1, :) = [254, 64, 64] / 255;
xticks(1:2);
xticklabels(x_labels_3);
ylabel('Count', 'FontName','Times New Roman');
title('InfractorClass Analysis', 'FontName','Times New Roman');
grid on;

%% Subplot 4: Analysis for VictimClass
subplot(2, 2, 4);

victim_class_counts = groupcounts(string({LoAviolations24L.VictimClass}'));

[~, worst_idx_4] = max(victim_class_counts);
worst_class_4 = unique(string({LoAviolations24L.VictimClass}'));
worst_class_4 = worst_class_4(worst_idx_4);

[~, best_idx_4] = min(victim_class_counts);
best_class_4 = unique(string({LoAviolations24L.VictimClass}'));
best_class_4 = best_class_4(best_idx_4);

x_labels_4 = {['Worst: ', char(worst_class_4)], ['Best: ', char(best_class_4)]};
y_values_4 = [max(victim_class_counts), min(victim_class_counts)];

b4 = bar(y_values_4);
b4.FaceColor = 'flat';
b4.CData(1, :) = [254, 64, 64] / 255;
xticks(1:2);
xticklabels(x_labels_4);
ylabel('Count');
title('VictimClass Analysis');
grid on;



%% ANALYSIS OF RADAR VIOLATIONS - 24L

% RADAR degree of violation
catOfViolation = strings(1, length(RADARviolations24L));

radarSeparation = [RADARviolations24L.CriticalSeparation];
radarRequiredSeparation = [RADARviolations24L.RequiredSeparation];

slightRadarViolation = 0;
mediumRadarViolation = 0;
severeRadarViolation = 0;

for i=1:length(RADARviolations24L)
    percentage(i) = (1 - radarSeparation(i)/radarRequiredSeparation(i))*100;
    if percentage(i) <= 5
        slightRadarViolation = slightRadarViolation + 1;
    elseif percentage(i) > 5 && percentage(i) <=10
        mediumRadarViolation = mediumRadarViolation + 1;
    elseif percentage(i) > 10
        severeRadarViolation = severeRadarViolation + 1;
    end
end

radarViolations = [slightRadarViolation, mediumRadarViolation,...
    severeRadarViolation];
totalRadarViolations = length(RADARviolations24L);
figure;
percentageValues = radarViolations / totalRadarViolations * 100;

bar(percentageValues);
set(gca, 'XTickLabel', {'Slight (x < 5%)', 'Medium (5% < x < 10%)',...
    'Severe (x > 10%)'});

for i = 1:length(percentageValues)
    text(i, percentageValues(i), sprintf('%.2f%%', percentageValues(i)), ...
        'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom',...
        'FontSize', 10, 'FontName','Times New Roman');
end

title('Distribution of Violation Degree (at 24L)','FontName','Times New Roman');
ylabel('Percentage of Violations','FontName','Times New Roman');

% Separation vs Required Separation
radarMeanSeparation = mean(radarSeparation);
figure;
hold on;

bar(radarSeparation);
x = 1:length(radarSeparation);
p = polyfit(x, radarSeparation, 8);
yfit = polyval(p, x);
plot(x, yfit, '-r', 'LineWidth', 2, 'Color','#fe4040');
xlabel('Index (number of infractors)','FontName','Times New Roman');
ylabel('Radar Separation [NM]','FontName','Times New Roman');
title('Radar Separation of Infractors (at 24L)','FontName','Times New Roman');
legend('Radar Separation', 'Tendence Line (8-th polynomical)',...
    'Location', 'best','FontName','Times New Roman');

% Worst and Best SID
% Counting violations by InfractorSID
uniqueInfractorSIDs = unique({RADARviolations24L.InfractorSID});
violationsByInfractor = zeros(1, length(uniqueInfractorSIDs));

for i = 1:length(uniqueInfractorSIDs)
    violationsByInfractor(i) = sum(strcmp({RADARviolations24L.InfractorSID}, uniqueInfractorSIDs{i}));
end

% Finding the 'worst' and 'best' InfractorSID
[~, idxMaxInfractor] = max(violationsByInfractor);
[~, idxMinInfractor] = min(violationsByInfractor);

worstInfractorSID = uniqueInfractorSIDs{idxMaxInfractor};
bestInfractorSID = uniqueInfractorSIDs{idxMinInfractor};

% Counting violations by VictimSID
uniqueVictimSIDs = unique({RADARviolations24L.VictimSID});
violationsByVictim = zeros(1, length(uniqueVictimSIDs));

for i = 1:length(uniqueVictimSIDs)
    violationsByVictim(i) = sum(strcmp({RADARviolations24L.VictimSID}, uniqueVictimSIDs{i}));
end

% Finding the 'worst' and 'best' VictimSID
[~, idxMaxVictim] = max(violationsByVictim);
[~, idxMinVictim] = min(violationsByVictim);

worstVictimSID = uniqueVictimSIDs{idxMaxVictim};
bestVictimSID = uniqueVictimSIDs{idxMinVictim};

% Creating the subplot
figure;

subplot(1, 2, 1);
h1 = bar([violationsByInfractor(idxMaxInfractor),...
    violationsByInfractor(idxMinInfractor)],'FontName','Times New Roman');
set(h1, 'FaceColor', 'flat');
h1.FaceColor = 'flat';
h1.CData(1, :) = hex2rgb('#fe4040');
set(gca, 'XTickLabel', {['Worst: ', worstInfractorSID],...
    ['Best: ', bestInfractorSID]},'FontName','Times New Roman');
ylabel('Number of Infractions','FontName','Times New Roman');
title('Worst and Best Infractor SID','FontName','Times New Roman');

grid on;
subplot(1, 2, 2);
h2 = bar([violationsByVictim(idxMaxVictim),...
    violationsByVictim(idxMinVictim)],'FontName','Times New Roman');
set(h2, 'FaceColor', 'flat');
h2.FaceColor = 'flat';
h2.CData(1, :) = hex2rgb('#fe4040');
set(gca, 'XTickLabel', {['Worst: ', worstVictimSID],...
    ['Best: ', bestVictimSID]},'FontName','Times New Roman');
ylabel('Number of Infractions','FontName','Times New Roman');
title('Worst and Best Victim SID','FontName','Times New Roman');

grid on;

% Function to convert hex color to RGB
function rgb = hex2rgb(hex)
    hex = char(hex);
    rgb = reshape(sscanf(hex(2:end), '%2x') / 255, 1, 3);
end

%% ANALYSIS OF WAKE VIOLATIONS - 24L

% Convert 'InfractorWake' and 'VictimWake' to cell arrays to count frequencies
infractorWake = {WakeViolations24L.InfractorWake};
victimWake = {WakeViolations24L.VictimWake};

% Get unique categories for InfractorWake and VictimWake
[infractorWakeCategories, ~, infractorWakeIndex] = unique(infractorWake);
[victimWakeCategories, ~, victimWakeIndex] = unique(victimWake);

% Count occurrences for each category
infractorWakeCount = histcounts(infractorWakeIndex, 'BinMethod', 'auto');
victimWakeCount = histcounts(victimWakeIndex, 'BinMethod', 'auto');

% Function to assign colors based on value
assignColor = @(count, minCount, maxCount) ...
    (count == minCount) * [95, 255, 116] / 255 + ...
    (count == maxCount) * [254, 64, 64] / 255 + ...            
    (count > minCount && count < maxCount) * [255, 233, 123] / 255;

% Get min and max values
minInfractorWakeCount = min(infractorWakeCount);
maxInfractorWakeCount = max(infractorWakeCount);
minVictimWakeCount = min(victimWakeCount);
maxVictimWakeCount = max(victimWakeCount);

% Create subplot
figure;

% Subplot 1: InfractorWake
subplot(1, 2, 1);
hold on;
for i = 1:length(infractorWakeCount)
    bar(i, infractorWakeCount(i), 'FaceColor',...
        assignColor(infractorWakeCount(i), minInfractorWakeCount,...
        maxInfractorWakeCount));
end
title('InfractorWake Frequencies','FontName','Times New Roman');
xticks(1:length(infractorWakeCategories));
xticklabels(cellstr(infractorWakeCategories));
ylabel('Count','FontName','Times New Roman');

% Subplot 2: VictimWake
subplot(1, 2, 2);
hold on;
for i = 1:length(victimWakeCount)
    bar(i, victimWakeCount(i), 'FaceColor',...
        assignColor(victimWakeCount(i),...
        minVictimWakeCount, maxVictimWakeCount));
end
title('VictimWake Frequencies','FontName','Times New Roman');
xticks(1:length(victimWakeCategories));
xticklabels(cellstr(victimWakeCategories));
ylabel('Count','FontName','Times New Roman');