close all


format long

% Abrir el archivo en modo lectura
dataFilename = 'P3_08_12h.csv'; % Reemplaza con el nombre correcto
[dataMatrix, H, HDG, TI, IAS, U, V, Hs, correctedModeC] = asterixCSVextraction(dataFilename);
departureFilename = 'Inputs P3 - Atenea/2305_02_dep_lebl.xlsx';
[num,txt,raw] = xlsread(departureFilename);
[~, idColumn, ~] = find(strcmp(raw,"Indicativo"));
% Why do we need corrected altitude???
departures24L = ["Target ID", "U", "V", "Hs", "H" ];
rowCount = 1;
for i = 2:size(raw,1)
    [rowsHit, ~, ~] = find(strcmp(TI,raw{i, idColumn}));
    for j = 1:numel(rowsHit)
        dataRow = rowsHit(j);
        departures24L(rowCount, :) = [TI(dataRow) U(dataRow) V(dataRow) Hs(dataRow) H(dataRow)];
        rowCount = rowCount+1;
    end
end
% OK UP TO HERE
uniqueTI = unique(departures24L(:,1), 'stable');
TIdepartures24L = cell(length(uniqueTI), 1);

for i = 1:length(uniqueTI)
    % Index where TI == uniqueTI
    index = departures24L(:, 1) == uniqueTI(i);

    % Extract HDG and H
    TIdepartures24L{i} = departures24L(index, 2:4);
end

plot(str2double(TIdepartures24L{1,1}(:,2)), str2double(TIdepartures24L{1,1}(:,3)));
ylabel("IAS (kts)");
xlabel("Height (ft)")
hold on
yLimits = ylim;
yZone = [yLimits(1), yLimits(1), yLimits(2), yLimits(2)];
xZone = [825, 875, 875, 825];
fill(xZone, yZone, 'red', 'FaceAlpha', 0.3, 'EdgeColor', 'none');
