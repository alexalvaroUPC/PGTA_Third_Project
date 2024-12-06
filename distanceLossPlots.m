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
catOfViolation = strings(1, length(LoAviolations24L));

LoAseparation = [LoAviolations24L.Separation];
LoArequiredSeparation = [LoAviolations24L.RequiredSeparation];

slightLoAViolations = 0;
mediumLoAViolations = 0;
severeLoAViolations = 0;

% LoA degree of violation
for i=1:length(LoAviolations24L)
    percentage(i) = (1 - LoAseparation(i)/LoArequiredSeparation(i))*100;
    if percentage(i) <= 5
        catOfViolation(i) = 'Slight';
        slightLoAViolations = slightLoAViolations + 1;
    elseif percentage(i) > 5 && percentage(i) <=10
        catOfViolation(i) = 'Medium';
        mediumLoAViolations = mediumLoAViolations + 1;
    elseif percentage(i) > 10
        catOfViolation(i) = 'Severe';
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