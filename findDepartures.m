function [departures24L, departures06R] = findDepartures(departureFilename, dataMatrix, classFilename)
[num,txt,raw] = xlsread(departureFilename);
[~,~,rawClasses] = xlsread(classFilename);
[~, idColumn, ~] = find(strcmp(raw,"Indicativo"));
[~, TOtimeColumn, ~] = find(strcmp(raw, "HoraDespegue"));
[~, wakeColumn,~] = find(strcmp(raw,"Estela"));
[~, classColumn,~] = find(strcmp(raw,"TipoAeronave"));
dataMatrix(1,size(dataMatrix,2)+1) = "TOTime";
dataMatrix(1,size(dataMatrix,2)+1) = "Wake";
dataMatrix(1,size(dataMatrix,2)+1) = "Class";
departures24L(1,:) = dataMatrix(1,:);
departures06R(1,:) = dataMatrix(1,:);
rowCount24 = 1;
rowCount06 = 1;
for i = 2:size(raw,1)
    [rowsHit, ~, ~] = find(strcmp(dataMatrix,raw{i, idColumn}));
    TOstring = strsplit(raw{i,TOtimeColumn}," ");
    TOmoment = TOstring{numel(TOstring)};
    [~,categoryColumn,~] = find(strcmp(rawClasses, raw{i,classColumn}));
    if isempty(categoryColumn)
        classType = "R";
    elseif rawClasses{1,categoryColumn} == "HP"
        classType = "HP";
    elseif rawClasses{1,categoryColumn} == "NR"
        classType = "NR";
    elseif rawClasses{1,categoryColumn} == "NR+"
        classType = "NR+";
    elseif rawClasses{1,categoryColumn} == "NR-"
        classType = "NR-";
    elseif rawClasses{1,categoryColumn} == "LP"
        classType = "LP";
    end
    if raw{i,wakeColumn} == "Pesada"
        wakeType = "H";
    elseif raw{i,wakeColumn} == "Media"
        wakeType = "M";
    else
        wakeType = "L";
    end
    for j = 1:numel(rowsHit)
        dataRow = rowsHit(j);
        if raw{i, end} == "LEBL-06R"
            departures06R(rowCount06+1, :) = [dataMatrix(dataRow,1:end-3) TOmoment wakeType classType];
            rowCount06 = rowCount06+1;
        else
            departures24L(rowCount24+1, :) = [dataMatrix(dataRow,1:end-3) TOmoment wakeType classType];
            rowCount24 = rowCount24+1;
        end
    end
end
end