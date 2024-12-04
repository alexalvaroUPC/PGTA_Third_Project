function sortedByTOtime = asterixDataProcessing(dataMatrix)


% Geodesic coordinates
headers = dataMatrix(1,:);
for i=1:length(headers)
    if (headers(i) == 'TIME')
        TIME = dataMatrix(2:end,i);
    elseif (headers(i) == 'TIME(s)')
            TIMEseconds = dataMatrix(2:end,i);
    elseif (headers(i) == 'LAT')
        LAT = dataMatrix(2:end,i);
    elseif (headers(i) == 'LON')
        LON = dataMatrix(2:end,i);
    elseif (headers(i) == 'H')
        H = dataMatrix(2:end,i);
    elseif (headers(i) == 'HDG')
        HDG = dataMatrix(2:end,i);
    elseif (headers(i) == 'TI')
        TIcolumn = i;
        TI = dataMatrix(2:end,i);
    elseif (headers(i) == 'IAS')
        IAS = dataMatrix(2:end,i);
    elseif (headers(i) == 'BP')
        BPstring = dataMatrix(2:end, i);
    elseif (headers(i) == 'FL')
        FLstring = dataMatrix(2:end,i);
    elseif (headers(i) == 'RA')
        RA = dataMatrix(2:end,i);
    elseif (headers(i) == 'TTA')
        TTA = dataMatrix(2:end,i);
    elseif (headers(i) == 'TOTime')
        TOtimes = dataMatrix(2:end,i);
    elseif (headers(i) == "Wake")
        WakeTypes = dataMatrix(2:end,i);
    elseif (headers(i) == "Class")
        ClassTypes = dataMatrix(2:end,i);
    end
end

LAT = str2double(strrep(LAT, ',', '.')); LON = str2double(strrep(LON, ',', '.')); H = str2double(strrep(H, ',', '.')); 
FLstring = strrep(FLstring, ',', '.'); BPstring = strrep(BPstring, ',', '.'); 
HDG = str2double(strrep(HDG,',','.')); IAS = str2double(strrep(IAS,',','.'));
HDG(HDG<0) = HDG(HDG<0) + 360;
[Xg, Yg, Zg] = geodesic2geocentric(LAT, LON, H);
[Xs, Ys, Zs] = geocentric2cartesian(Xg, Yg, Zg);
[U, V, Hs] = cartesian2stereographic(Xs, Ys, Zs);
% Altitude correction
correctedModeC = zeros(size(LAT));
FL = -400*ones(size(FLstring));
BP = -400*ones(size(BPstring));
for i = 1:size(FLstring,1)
    if ((BPstring(i)~="N/A")&&(BPstring(i)~="NV"))
        BP(i) = str2double(BPstring(i));
    end
    if(FLstring(i) ~= "N/A")
        FL(i) = str2double(FLstring(i));
    end
end

for i = 1:size(correctedModeC,1)
    if ((BP(i)==-400) || (FL(i) == -400))
        correctedModeC(i) = FL(i);
    else
        if (FL(i) >=60.0 || BP(i)<=1013.3)
            correctedModeC(i) = FL(i);
        else
            correction = 1013.2;
            correctedModeC(i) = (FL(i) * 100 + (BP(i) - correction) * 30)/100;
        end
    end
end
% Conversion to NM => 1NM = 1852m
U = U/1852;
V = V/1852;

constructedHeaders = ["TIME" "TIME(s)" "LAT" "LON" "Hgeodesic" "U" "V" "Hstereo" "TI" "FL" "BP" "ModeCorrectionC" "RA" "TTA" "IAS" "TOtime" "Wake", "HDG", "Class"];
durationTOtimes = duration(TOtimes);
[sortedtimes, sortedidx] = sort(durationTOtimes);
constructedMatrix = [TIME, TIMEseconds, LAT, LON, H, U', V', Hs', TI, FLstring, BPstring, correctedModeC, RA, TTA, IAS, TOtimes, WakeTypes, HDG, ClassTypes]; 

% sortedByTOtime = [constructedHeaders; sortrows(constructedMatrix,16)];

sortedByTOtime = [constructedHeaders; constructedMatrix(sortedidx,:)];
end