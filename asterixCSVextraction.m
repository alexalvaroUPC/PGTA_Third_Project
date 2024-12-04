function [dataMatrix, H, HDG, TI, IAS, U, V, Hs, correctedModeC] = asterixDataProcessing(dataMatrix)


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
    elseif (headers(i) == 'BP')
        BPstring = dataMatrix(2:end, i);
    elseif (headers(i) == 'FL')
        FLstring = dataMatrix(2:end,i);
    end
end

LAT = strrep(LAT, ',', '.');
LON = strrep(LON, ',', '.');
H = strrep(H, ',', '.');
FLstring = strrep(FLstring, ',', '.');
BPstring = strrep(BPstring, ',', '.');
LAT = str2double(LAT);
LON = str2double(LON);
H = str2double(H);

[Xg, Yg, Zg] = geodesic2geocentric(LAT, LON, H);
[Xs, Ys, Zs] = geocentric2cartesian(Xg, Yg, Zg);
[U, V, Hs] = cartesian2stereographic(Xs, Ys, Zs);
% Altitude correction
correctedModeC = zeros(size(LAT));
FL = -100*ones(size(FLstring));
BP = -100*ones(size(BPstring));
for i = 1:size(FLstring,1)
    if ((BPstring(i)~="N/A")&&(BPstring(i)~="NV"))
        BP(i) = str2double(BPstring(i));
    end
    if(FLstring(i) ~= "N/A")
        FL(i) = str2double(FLstring(i));
    end
end

for i = 1:size(correctedModeC,1)
    if ((BP(i)==-100) || (FL(i) == -100))
        correctedModeC(i) = "N/A";
    else
        if (FL(i) >=60.0 || BP(i)<=1013.3)
            correctedModeC(i) = "N/A";
        else
            correction = 1013.2;
            correctedModeC(i) = (FL(i) * 100 + (BP(i) - correction) * 30);
        end
    end
end
% Conversion to NM => 1NM = 1852m
U = U/1852;
V = V/1852;


HDG = strrep(HDG,',','.');
HDG = str2double(HDG);


IAS = strrep(IAS,',','.');
IAS = str2double(IAS); % in kts

H = H*3.28084; % Conversion to feet
end