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

%% NUMBER OF VIOLATIONS AND DISTRIBUTION - 24L
figure;
subplot(1,2,1)
bar(violationsPerType24L);
set(gca, 'XTickLabel', typeOfViolation);
title('Distribution of Distance Violations by Type (at 24L)','FontName','Times New Roman');
ylabel('Violations per Day','FontName','Times New Roman');
xlabel('Type of Violation','FontName','Times New Roman');

subplot(1,2,2)
bar(violationsPerType06R);
set(gca, 'XTickLabel', typeOfViolation);
title('Distribution of Distance Violations by Type (at 06R)','FontName','Times New Roman');
ylabel('Violations per Day','FontName','Times New Roman');
xlabel('Type of Violation','FontName','Times New Roman');

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
