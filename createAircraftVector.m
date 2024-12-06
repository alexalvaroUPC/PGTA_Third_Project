function [runwayAircrafts, tVector] = createAircraftVector(dataMatrix)
currentCS = dataMatrix(2,9);
j = 1;
k = 1;
firstTime = min(str2double(dataMatrix(:,2)));
lastTime = max(str2double(dataMatrix(:,2)));
tVector = firstTime:lastTime;
for i = 2:size(dataMatrix,1)
    if currentCS == dataMatrix(i,9)
        AC(k).Callsign = currentCS;
        AC(k).TOtime = dataMatrix(i,16);
        AC(k).Wake = dataMatrix(i,17);
        AC(k).Class = dataMatrix(i,19);
        AC(k).SID = dataMatrix(i,20);
        AC(k).SIDgroup = dataMatrix(i,21);
        AC(k).TIME(j) = dataMatrix(i,1);
        AC(k).TIMEseconds(j) = str2double(dataMatrix(i,2));
        AC(k).LAT(j) = str2double(dataMatrix(i,3));
        AC(k).LON(j) = str2double(dataMatrix(i,4));
        % AC(k).H(j) = dataMatrix(i,5);
        AC(k).U(j) = str2double(dataMatrix(i,6));
        AC(k).V(j) = str2double(dataMatrix(i,7));
        AC(k).Hs(j) = dataMatrix(i,8);
        AC(k).Alt(j) = str2double(dataMatrix(i,12));
        AC(k).RA(j) = dataMatrix(i,13);
        AC(k).TTA(j) = dataMatrix(i,14);
        AC(k).IAS(j) = str2double(dataMatrix(i,15));
        AC(k).HDG(j) = str2double(dataMatrix(i,18));
        AC(k).IVV(j) = str2double(dataMatrix(i,22));
        j = j+1;
    else
        j = 1;
        k = k+1;
    end
    currentCS = dataMatrix(i,9);

end
for i = 1:numel(AC)
    startpoint = find(tVector == AC(i).TIMEseconds(1));
    endpoint = find(tVector == AC(i).TIMEseconds(end));
    AC(i).interpStart = startpoint;
    AC(i).interpEnd = endpoint;
    % interpolatedLAT = interp1(AC(i).TIMEseconds,AC(i).LAT,tVector, 'makima');
    % interpolatedLAT(1:startpoint-1) = -400;
    % interpolatedLAT(endpoint+1:end) = -400;
    % AC(i).LATinterp = interpolatedLAT;
    % interpolatedLON = interp1(AC(i).TIMEseconds,AC(i).LON,tVector, 'makima');
    % interpolatedLON(1:startpoint-1) = -400;
    % interpolatedLON(endpoint+1:end) = -400;
    % AC(i).LONinterp = interpolatedLON;
    % interpolatedU = interp1(AC(i).TIMEseconds,AC(i).U,tVector, 'makima');
    % interpolatedU(1:startpoint-1) = -400;
    % interpolatedU(endpoint+1:end) = -400;
    % AC(i).Uinterp = interpolatedU;
    % interpolatedV = interp1(AC(i).TIMEseconds,AC(i).V,tVector, 'makima');
    % interpolatedV(1:startpoint-1) = -400;
    % interpolatedV(endpoint+1:end) = -400;
    % AC(i).Vinterp = interpolatedV;
    % if ~all(isnan(AC(i).Alt))
    %     interpolatedAlt = interp1(AC(i).TIMEseconds,AC(i).Alt,tVector, 'makima');
    %     interpolatedAlt(1:startpoint-1) = -400;
    %     interpolatedAlt(endpoint+1:end) = -400;
    %     AC(i).AltInterp = interpolatedAlt;
    % end
    % if ~all(isnan(AC(i).IAS))
    %     interpolatedIAS = interp1(AC(i).TIMEseconds,AC(i).IAS,tVector, 'makima');
    %     interpolatedIAS(1:startpoint-1) = -400;
    %     interpolatedIAS(endpoint+1:end) = -400;
    %     AC(i).IASinterp = interpolatedIAS;
    % end
    % if ~all(isnan(AC(i).HDG))
    %     interpolatedHDG = interp1(AC(i).TIMEseconds,AC(i).HDG,tVector, 'makima');
    %     interpolatedHDG(1:startpoint-1) = -400;
    %     interpolatedHDG(endpoint+1:end) = -400;
    %     AC(i).HDGinterp = interpolatedHDG;
    % end
end
runwayAircrafts = AC;