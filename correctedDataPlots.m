close all;

%% TOTAL VIOLATIONS
totalViolations24L = [{LoAviolations24L.Infractor},...
    {RADARviolations24L_TMA.Infractor},...
    {WakeViolations24L_TMA.Infractor},...
    {RADARviolations24L_TWR.Infractor},...
    {WakeViolations24L_TWR.Infractor}];

totalViolations24L = length(unique(totalViolations24L));

totalViolations24L_TWR = [{LoAviolations24L.Infractor},...
    {RADARviolations24L_TWR.Infractor},...
    {WakeViolations24L_TWR.Infractor}];

totalViolations24L_TWR = length(unique(totalViolations24L_TWR));

totalViolations24L_TMA = [{RADARviolations24L_TMA.Infractor},...
    {WakeViolations24L_TMA.Infractor}];

totalViolations24L_TMA = length(unique(totalViolations24L_TMA));

totalViolations06R = length(unique({LoAviolations06R.Infractor}));

totalViolations = [totalViolations24L, totalViolations06R];

totalViolationsPerType24L = [totalViolations24L_TMA,...
    totalViolations24L_TWR];

figure;
subplot(1,2,1)
p1 = pie(totalViolations);
title('Total Infractions at 24L and 06R', 'FontName','Times New Roman');
subtitle('Total Infractions: 51', 'FontName','Times New Roman');

subplot(1,2,2)
labels = {'TMA', 'TWR'};
p2 = pie(totalViolationsPerType24L);
title('Type of Infraction at 24L', 'FontName','Times New Roman');
subtitle('Virtual Total: 59 (Real Total: 49)', 'FontName','Times New Roman');

for i = 1:length(totalViolationsPerType24L)
    p2(i*2).String = sprintf('%s', labels{i});
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
ylabel('Count','FontName','Times New Roman');
title('VictimClass Analysis','FontName','Times New Roman');
grid on;

%% ANALYSIS OF WAKE VIOLATIONS - 24L - TMA
% Convert 'InfractorWake' and 'VictimWake' to cell arrays to count frequencies
infractorWake = {WakeViolations24L_TMA.InfractorWake};
victimWake = {WakeViolations24L_TMA.VictimWake};

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
title('InfractorWake Frequencies (TMA)','FontName','Times New Roman');
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
title('VictimWake Frequencies (TMA)','FontName','Times New Roman');
xticks(1:length(victimWakeCategories));
xticklabels(cellstr(victimWakeCategories));
ylabel('Count','FontName','Times New Roman');

%% ANALYSIS OF WAKE VIOLATIONS - 24L - TWR
% Datos del struct
WakeViolations24L_TWR.Infractor = 'DAL169';
WakeViolations24L_TWR.InfractorSID = 'LOBAR-Q';
WakeViolations24L_TWR.Victim = 'AVA019';
WakeViolations24L_TWR.VictimSID = 'LOBAR-Q';
WakeViolations24L_TWR.SameSIDgroup = 1;
WakeViolations24L_TWR.CriticalSeparation = 3.7902;
WakeViolations24L_TWR.RequiredSeparation = 4;
WakeViolations24L_TWR.CriticalInstant = seconds(1); % Ejemplo de duración

% Extraer datos
critical_separation = WakeViolations24L_TWR.CriticalSeparation;
required_separation = WakeViolations24L_TWR.RequiredSeparation;

% Crear el gráfico
figure;
bar([critical_separation, required_separation]);
set(gca, 'XTickLabel', {'Critical Separation', 'Required Separation'},...
    'FontName','Times New Roman');
ylabel('Separation [NM]','FontName','Times New Roman');
title('Unique Wake Infractor by TWR','FontName','Times New Roman');
grid on;

% Anotar valores en el gráfico
values = [critical_separation, required_separation];
text(1:length(values), values, num2str(values', '%.2f'), ...
    'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom',...
    'FontName','Times New Roman');

% Añadir información adicional como notas
annotation_text = sprintf(['Infractor: %s\nInfractor SID: %s\nVictim: %s\n' ...
    'Victim SID: %s\nSame SID Group: %d\nCritical Instant: %s'], ...
    WakeViolations24L_TWR.Infractor, ...
    WakeViolations24L_TWR.InfractorSID, ...
    WakeViolations24L_TWR.Victim, ...
    WakeViolations24L_TWR.VictimSID, ...
    WakeViolations24L_TWR.SameSIDgroup, ...
    char(WakeViolations24L_TWR.CriticalInstant),'FontName',...
    'Times New Roman');

% Añadir el texto como anotación en el gráfico
dim = [0.15 0.5 0.3 0.3]; % [x y width height] en fracción de la figura
annotation('textbox', dim, 'String', annotation_text, 'FitBoxToText', 'on', ...
    'BackgroundColor', 'white', 'EdgeColor', 'black','FontName',...
    'Times New Roman');

%% DISTANCES DATA - 24L
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
        'b', 'BinWidth', 0.1); 
    xlabel('Minimum Separations [NM]', 'FontName', 'Times New Roman');
    ylabel('Frequency', 'FontName',...
        'Times New Roman');
    title('Distribution of Minimum Separations at 24L', 'FontName',...
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

%% DISTANCES DATA - 06R
minSeparations06R = [];

for i = 1:length(distances06R)
    separations = distances06R(i).Separations; 
    
    if ~isempty(separations)
        minSeparations06R = [minSeparations06R, min(separations)]; 
    end
end

if ~isempty(minSeparations06R)
    figure;
    histogram(minSeparations06R, 'EdgeColor', 'black', 'FaceColor',...
        'b', 'BinWidth', 0.1); 
    xlabel('Minimum Separations [NM]', 'FontName', 'Times New Roman');
    ylabel('Frequency', 'FontName',...
        'Times New Roman');
    title('Distribution of Minimum Separations at 06R', 'FontName',...
        'Times New Roman');
    grid on;

    meanVal = mean(minSeparations06R);
    modeVal = mode(minSeparations06R);
    medianVal = median(minSeparations06R);
    stdVal = std(minSeparations06R); 

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