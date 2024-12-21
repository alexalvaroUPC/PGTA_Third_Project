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

labels24L = {'LoA', 'RADAR', 'Wake'};
h1 = pie(violationsPerType24L);
title('Distribution of Distance Violations by Type (at 24L)',...
    'FontName','Times New Roman');

for i = 1:length(violationsPerType24L)
    percentage = (violationsPerType24L(i) / totalViolations24L) * 100;
    h1(i*2).String = sprintf('%s: %.1f%%', labels24L{i}, percentage);
end


subplot(1,2,2)

labels06R = {'LoA', 'RADAR', 'Wake'}; 
h2 = pie(violationsPerType06R);
title('Distribution of Distance Violations by Type (at 06R)',...
    'FontName','Times New Roman');

for i = 1:length(violationsPerType06R)
    percentage = (violationsPerType06R(i) / totalViolations06R) * 100;
    h2(i*2).String = sprintf('%s: %.1f%%', labels06R{i}, percentage);
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

% Subplot 4: Analysis for VictimClass
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
xlabel('Index (number of infractors)','FontName','Times New Roman');
ylabel('Radar Separation [NM]','FontName','Times New Roman');
title('Radar Separation of Infractors (at 24L)','FontName',...
    'Times New Roman');

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

%% By TIME of INFRACTION
LoAtimes24L = [LoAviolations24L.TimeOfInfraction];
RADARtimes24L = [RADARviolations24L.CriticalInstant];
WakeTimes24L = [WakeViolations24L.CriticalInstant];

LoAtimes06R = [LoAviolations06R.TimeOfInfraction];
RADARtimes06R = [RADARviolations06R.CriticalInstant];
% WakeTimes06R = [WakeViolations06R.CriticalInstant];

times24L = [LoAtimes24L, RADARtimes24L, WakeTimes24L];
hours24L = floor(seconds(times24L) / 3600);

times06R = [LoAtimes06R, RADARtimes06R];
hours06R = floor(seconds(times06R) / 3600);

LoA_hours24L = floor(seconds(LoAtimes24L) / 3600);
RADAR_hours24L = floor(seconds(RADARtimes24L) / 3600);
Wake_hours24L = floor(seconds(WakeTimes24L) / 3600);

LoA_hours06R = floor(seconds(LoAtimes06R) / 3600);
RADAR_hours06R = floor(seconds(RADARtimes06R) / 3600);
% Wake_hours06R= floor(seconds(WakeTimes06R) / 3600);

hour_bins = 0:23;

LoA_counts24L = histcounts(LoA_hours24L, [hour_bins, 24]);
RADAR_counts24L = histcounts(RADAR_hours24L, [hour_bins, 24]);
Wake_counts24L = histcounts(Wake_hours24L, [hour_bins, 24]);

LoA_counts06R = histcounts(LoA_hours06R, [hour_bins, 24]);
RADAR_counts06R = histcounts(RADAR_hours06R, [hour_bins, 24]);
% Wake_counts06R = histcounts(Wake_hours06R, [hour_bins, 24]);

counts24L = [LoA_counts24L; RADAR_counts24L; Wake_counts24L]';

counts06R = [LoA_counts06R; RADAR_counts06R;]';

figure;
subplot(2,1,1)
h = histogram(hours24L, 'BinMethod', 'integers', 'BinWidth', 1);
xlabel('Hour of the Day','FontName','Times New Roman');
ylabel('Number of Infractions','FontName','Times New Roman');
title('Infractions per Hour at 24L','FontName','Times New Roman');
xticks(0:23);
xlim([0, 23]);

hold on;
x = h.BinEdges(1:end-1) + diff(h.BinEdges)/2;
y = h.Values;
p = polyfit(x, y, 4); 
yfit = polyval(p, x); 
plot(x, yfit, '-r', 'LineWidth', 2, 'Color','#fe4040');

subplot(2,1,2)
h = histogram(hours06R, 'BinMethod', 'integers', 'BinWidth', 1);
xlabel('Hour of the Day','FontName','Times New Roman');
ylabel('Number of Infractions','FontName','Times New Roman');
title('Infractions per Hour at 06R','FontName','Times New Roman');
xticks(0:23);
xlim([0, 23]);

hold on;
x = h.BinEdges(1:end-1) + diff(h.BinEdges)/2;
y = h.Values;
p = polyfit(x, y, 4); 
yfit = polyval(p, x); 
plot(x, yfit, '-r', 'LineWidth', 2, 'Color','#fe4040');

figure;
subplot(2,1,1)
bar(hour_bins, counts24L, 'grouped');
xlabel('Hour of the Day','FontName','Times New Roman');
ylabel('Number of Infractions','FontName','Times New Roman');
title('Infractions per Hour by Violation Type at 24L','FontName',...
    'Times New Roman');
legend({'LoA Violations', 'RADAR Violations', 'Wake Violations'},...
    'Location', 'best');
xticks(0:23);
xlim([0, 23]);

subplot(2,1,2)
bar(hour_bins, counts06R, 'grouped');
xlabel('Hour of the Day','FontName','Times New Roman');
ylabel('Number of Infractions','FontName','Times New Roman');
title('Infractions per Hour by Violation Type at 06R','FontName',...
    'Times New Roman');
legend({'LoA Violations', 'RADAR Violations', 'Wake Violations'},...
    'Location', 'best');
xticks(0:23);
xlim([0, 23]);

% Now we extract the number of Take-Offs to compare de results
takeOffTimes24L = duration([aircraft24L.TOtime]);
takeOffTimes_hours24L = floor(seconds(takeOffTimes24L) / 3600);

takeOffTimes06R = duration([aircraft06R.TOtime]);
takeOffTimes_hours06R = floor(seconds(takeOffTimes06R) / 3600);

takeOffCounts24L = histcounts(takeOffTimes_hours24L, [hour_bins, 24]);
takeOffCounts06R = histcounts(takeOffTimes_hours06R, [hour_bins, 24]);

figure;
subplot(2,1,1)
h = histogram(takeOffTimes_hours24L, 'BinMethod', 'integers', 'BinWidth', 1);
xlabel('Hour of the Day','FontName','Times New Roman');
ylabel('Number of Take-Offs','FontName','Times New Roman');
title('Number of Take-Offs at the Day at 24L','FontName','Times New Roman');
xticks(0:23);
xlim([0, 23]);

hold on;
x = h.BinEdges(1:end-1) + diff(h.BinEdges)/2;
y = h.Values;
p = polyfit(x, y, 4); 
yfit = polyval(p, x); 
plot(x, yfit, '-r', 'LineWidth', 2, 'Color','#fe4040');

subplot(2,1,2)
h = histogram(takeOffTimes_hours06R, 'BinMethod', 'integers', 'BinWidth', 1);
xlabel('Hour of the Day','FontName','Times New Roman');
ylabel('Number of Take-Offs','FontName','Times New Roman');
title('Number of Take-Offs at the Day at 06R','FontName','Times New Roman');
xticks(0:23);
xlim([0, 23]);

hold on;
x = h.BinEdges(1:end-1) + diff(h.BinEdges)/2;
y = h.Values;
p = polyfit(x, y, 4); 
yfit = polyval(p, x); 
plot(x, yfit, '-r', 'LineWidth', 2, 'Color','#fe4040');

%% SEPARATION VECTOR VS THRESHOLD
rowNumber = 381;

if rowNumber > 0 && rowNumber <= numel(distances24L) && ...
        ~isempty(distances24L(rowNumber).Separations)
    separations = distances24L(rowNumber).Separations;
    timeInstants = seconds(distances24L(rowNumber).timeInstants) / 3600;
    involvedAC = distances24L(rowNumber).InvolvedAC;

    callSigns = split(involvedAC, '_');
    
    titleString = [callSigns{1} ' & ' callSigns{2}];

    figure;
    plot(timeInstants, separations, 'LineWidth', 1.5);
    xlabel('Time [h]', 'FontName', 'Times New Roman');
    ylabel('Separations [NM]', 'FontName', 'Times New Roman');
    title(['Separations for Callsigns: ', titleString], 'FontName', 'Times New Roman');
    grid on;
    hold on;
    yline(3, '--r', 'Radar Minimum Separation: 3 NM', 'LineWidth', 1.5, ...
        'LabelHorizontalAlignment', 'right', 'FontName', 'Times New Roman', ...
        'Color', '#fe4040');
else
    disp('Invalid row number or empty separation vector.');
end

%% Distances data

minSeparations24L = [];

for i = 1:length(distances24L)
    separations = distances24L(i).Separations; 
    
    if ~isempty(separations)
        minSeparations24L = [minSeparations24L, min(separations)]; 
    end
end

if ~isempty(minSeparations24L)
    figure;
    histogram(minSeparations24L, 'EdgeColor', 'black', 'FaceColor',...
        'b', 'BinWidth', 0.25); 
    xlabel('Minimum Separations [NM]', 'FontName', 'Times New Roman');
    ylabel('Frequency', 'FontName',...
        'Times New Roman');
    title('Distribution of Minimum Separations', 'FontName',...
        'Times New Roman');
    grid on;

    meanVal = mean(minSeparations24L);
    modeVal = mode(minSeparations24L);
    medianVal = median(minSeparations24L);
    stdVal = std(minSeparations24L); 

    str = {
        ['Mean: ' num2str(meanVal, '%.2f') ' NM'], 
        ['Mode: ' num2str(modeVal, '%.2f') ' NM'], 
        ['Median: ' num2str(medianVal, '%.2f') ' NM'],
        ['Standard Deviation: ' num2str(stdVal, '%.2f') ' NM']
    };
    
    x = 0.5;
    y = 0.5;
    width = 0.15; 
    height = 0.15;

    annotation('textbox', [x, y, width, height], 'String', str, ...
               'FontSize', 12, 'HorizontalAlignment', 'center', ...
               'VerticalAlignment', 'middle', 'FontName',...
               'Times New Roman', 'EdgeColor', 'black', 'LineWidth',...
               1.5, 'BackgroundColor', 'white');
else
    disp('No data available for the histogram.');
end