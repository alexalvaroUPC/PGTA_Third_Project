function [dataMatrix] = asterixCSVtoMatrix(filename)
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
end