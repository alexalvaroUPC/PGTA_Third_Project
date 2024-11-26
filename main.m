close all
clear all

format long

% Abrir el archivo en modo lectura
filename = 'P3_08_12h.csv'; % Reemplaza con el nombre correcto
fileID = fopen(filename, 'r');

% Leer todo el archivo como texto
rawData = textscan(fileID, '%s', 'Delimiter', '\n', 'TextType', 'string');
fclose(fileID);

% Extraer las líneas del archivo
lines = rawData{1};

% Dividir la primera línea para obtener los encabezados
headers = strsplit(lines(1), ';');
numColumns = length(headers); % Número de columnas basado en los encabezados

% Inicializar la celda de datos con el tamaño adecuado
data = cell(length(lines)-1, numColumns);

% Procesar las filas restantes
for i = 2:length(lines)

    % Dividir cada línea por comas
    row = strsplit(lines(i), ';');
    
    % Ajustar el número de columnas de la fila al número de encabezados
    if length(row) < numColumns
        row = [row, repmat({''}, 1, numColumns - length(row))]; % Completar con celdas vacías
    elseif length(row) > numColumns
        row = row(1:numColumns); % Truncar al número de columnas
    end
    
    % Guardar la fila en la matriz de datos
    data(i-1, :) = cellstr(row); % Convertir de string a celda
end

% Convertir la celda de datos a matriz de celdas incluyendo encabezados
dataMatrix = [headers; data];

% Geodesic coordinates

for i=1:length(headers)
    if (headers(i) == 'LAT')
        LAT = dataMatrix(2:end,i);
    elseif (headers(i) == 'LON')
        LON = dataMatrix(2:end,i);
    elseif (headers(i) == 'H')
        H = dataMatrix(2:end,i);
    elseif (headers(i) == 'HDG')
        HDG = dataMatrix(2:end,i);
    elseif (headers(i) == 'TI')
        TI = dataMatrix(2:end,i);
    elseif (headers(i) == 'IAS')
        IAS = dataMatrix(2:end,i);
    end
end

LAT = strrep(LAT, ',', '.');
LON = strrep(LON, ',', '.');
H = strrep(H, ',', '.');

LAT = str2double(LAT);
LON = str2double(LON);
H = str2double(H);

[Xg, Yg, Zg] = geodesic2geocentric(LAT, LON, H);
[Xs, Ys, Zs] = geocentric2cartesian(Xg, Yg, Zg);
[U, V, Hs] = cartesian2stereographic(Xs, Ys, Zs);

% Conversion to NM => 1NM = 1852m
U = U/1852;
V = V/1852;

% Initialize departures in 24L matrix
departures24L = [];

HDG = strrep(HDG,',','.');
HDG = str2double(HDG);


IAS = strrep(IAS,',','.');
IAS = str2double(IAS); % in kts

H = H*3.28084; % Conversion to feet

for i=1:(length(dataMatrix)-1)
    if (HDG(i) >= -117 && HDG(i) <= -115)
        departures24L = [departures24L; TI(i), HDG(i), H(i), IAS(i)];
    end
end

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
