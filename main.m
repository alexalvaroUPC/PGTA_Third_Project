close all
clear all

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
LAT = dataMatrix(2:end,3);
LON = dataMatrix(2:end,4);
H = dataMatrix(2:end,5);

LAT = strrep(LAT, ',', '.');
LON = strrep(LON, ',', '.');
H = strrep(H, ',', '.');

LAT = str2double(LAT);
LON = str2double(LON);
H = str2double(H);

[Xg, Yg, Zg] = geodesic2geocentric(LAT, LON, H);
[Xs, Ys, Zs] = geocentric2cartesian(Xg, Yg, Zg);
[U, V, Hs] = cartesian2stereographic(Xs, Ys, Zs);