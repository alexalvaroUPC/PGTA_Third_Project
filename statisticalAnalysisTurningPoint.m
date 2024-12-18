%% VECTOR PREPARATION

clear all
load("mydata_P3_00-24h.csv1.mat", "aircraft24L", "tVector24L")
k = 1;
for i = 1:numel(aircraft24L)
    if ~isempty(aircraft24L(i).turningAlt)
        if ~isnan(aircraft24L(i).turningAlt)
            if aircraft24L(i).turningRadial > 210 && aircraft24L(i).turningRadial < 245 && aircraft24L(i).turningAlt < 10
                Callsigns24L(k) = [aircraft24L(i).Callsign];
                TurningLAT(k) = [aircraft24L(i).turningLAT];
                TurningLON(k) = [aircraft24L(i).turningLON];
                TurningAlt(k) = [aircraft24L(i).turningAlt]*100;
                TurningRadial(k) = [aircraft24L(i).turningRadial];
                CriticalRadial(k) = [max(aircraft24L(i).radials)];
                SIDs(k) = [aircraft24L(i).SID];
                SIDgroups(k) = [aircraft24L(i).SIDgroup];
                k = k+1;
            end
        end
    end
end
clear aircraft24L
%% DATA CLASSIFICATION
[~, SIDgroupidx, ~] = find(SIDgroups == "G1");
G1TurningLAT = TurningLAT(SIDgroupidx);
G1TurningLON = TurningLON(SIDgroupidx);
G1TurningAlt = TurningAlt(SIDgroupidx);
G1TurningRadial = TurningRadial(SIDgroupidx);
G1CriticalRadial = CriticalRadial(SIDgroupidx);
[~, SIDgroupidx, ~] = find(SIDgroups == "G2");
G2TurningLAT = TurningLAT(SIDgroupidx);
G2TurningLON = TurningLON(SIDgroupidx);
G2TurningAlt = TurningAlt(SIDgroupidx);
G2TurningRadial = TurningRadial(SIDgroupidx);
G2CriticalRadial = CriticalRadial(SIDgroupidx);
[~, SIDgroupidx, ~] = find(SIDgroups == "G3");
G3TurningLAT = TurningLAT(SIDgroupidx);
G3TurningLON = TurningLON(SIDgroupidx);
G3TurningAlt = TurningAlt(SIDgroupidx);
G3TurningRadial = TurningRadial(SIDgroupidx);
G3CriticalRadial = CriticalRadial(SIDgroupidx);

%% Statistical data
[maxLAT, idxLATmax] = max(TurningLAT);
[minLAT, idxLATmin] = min(TurningLAT);
maxLATid = Callsigns24L(idxLATmax);
minLATid = Callsigns24L(idxLATmin);

[maxLON, idxLONmax] = max(TurningLON);
[minLON, idxLONmin] = min(TurningLON);
maxLONid = Callsigns24L(idxLONmax);
minLONid = Callsigns24L(idxLONmin);

[maxAlt, idxAltmax] = max(TurningAlt);
[minAlt, idxAltmin] = min(TurningAlt);
maxAltid = Callsigns24L(idxAltmax);
minAltid = Callsigns24L(idxAltmin);

[maxRadial, idxRadialmax] = max(TurningRadial);
[minRadial, idxRadialmin] = min(TurningRadial);
maxRadialid = Callsigns24L(idxRadialmax);
minRadialid = Callsigns24L(idxRadialmin);

meanTurningLAT = mean(TurningLAT);
meanTurningLON = mean(TurningLON);
meanTurningAlt = mean(TurningAlt);
meanTurningRadial = mean(TurningRadial);
meanCriticalRadial = mean(CriticalRadial);
desvTurningLAT = std(TurningLAT);
desvTurningLON = std(TurningLON);
desvTurningAlt = std(TurningAlt);
desvTurningRadial = std(TurningRadial);
desvCriticalRadial = std(CriticalRadial);
p95_TurningLAT = prctile(TurningLAT, 95);
p95_TurningLON = prctile(TurningLON, 95);
p95_TurningAlt = prctile(TurningAlt, 95);
p95_TurningRadial = prctile(TurningRadial, 95);
p95_CriticalRadial = prctile(CriticalRadial,95);

%% Statistical data per SID
% G1.meanTurningLON = mean(G1TurningLON);
% G1.meanTurningLAT = mean(G1TurningLAT);
G1.meanTurningAlt = mean(G1TurningAlt);
G1.meanTurningRadial = mean(G1TurningRadial);
G1.meanCriticalRadial = mean(G1CriticalRadial);
% G1.desvTurningLON = std(G1TurningLON);
% G1.desvTurningLAT = std(G1TurningLAT);
G1.desvTurningAlt = std(G1TurningAlt);
G1.desvTurningRadial = std(G1TurningRadial);
G1.desvCriticalRadial = std(G1CriticalRadial);
% G1.p95_TurningLON = prctile(G1TurningLON, 95);
% G1.p95_TurningLAT = prctile(G1TurningLAT, 95);
G1.p95_TurningAlt = prctile(G1TurningAlt, 95);
G1.p95_TurningRadial = prctile(G1TurningRadial, 95);
G1.p95_CriticalRadial = prctile(G1CriticalRadial, 95);

% G2.meanTurningLON = mean(G2TurningLON);
% G2.meanTurningLAT = mean(G2TurningLAT);
G2.meanTurningAlt = mean(G2TurningAlt);
G2.meanTurningRadial = mean(G2TurningRadial);
G2.meanCriticalRadial = mean(G2CriticalRadial);
% G2.desvTurningLON = std(G2TurningLON);
% G2.desvTurningLAT = std(G2TurningLAT);
G2.desvTurningAlt = std(G2TurningAlt);
G2.desvTurningRadial = std(G2TurningRadial);
G2.desvCriticalRadial = std(G2CriticalRadial);
% G2.p95_TurningLON = prctile(G2TurningLON, 95);
% G2.p95_TurningLAT = prctile(G2TurningLAT, 95);
G2.p95_TurningAlt = prctile(G2TurningAlt, 95);
G2.p95_TurningRadial = prctile(G2TurningRadial, 95);
G2.p95_CriticalRadial = prctile(G2CriticalRadial, 95);

% G3.meanTurningLON = mean(G3TurningLON);
% G3.meanTurningLAT = mean(G3TurningLAT);
G3.meanTurningAlt = mean(G3TurningAlt);
G3.meanTurningRadial = mean(G3TurningRadial);
G3.meanCriticalRadial = mean(G3CriticalRadial);
% G3.desvTurningLON = std(G3TurningLON);
% G3.desvTurningLAT = std(G3TurningLAT);
G3.desvTurningAlt = std(G3TurningAlt);
G3.desvTurningRadial = std(G3TurningRadial);
G3.desvCriticalRadial = std(G3CriticalRadial);
% G3.p95_TurningLON = prctile(G3TurningLON, 95);
% G3.p95_TurningLAT = prctile(G3TurningLAT, 95);
G3.p95_TurningAlt = prctile(G3TurningAlt, 95);
G3.p95_TurningRadial = prctile(G3TurningRadial, 95);
G3.p95_CriticalRadial = prctile(G3CriticalRadial, 95);
%% Histogram for all A/C
figure
subplot(151)
histogram(TurningLAT)
ylabel("Count")
xlabel("LAT [º]")
title('Latitude at turning point')
subplot(152)
histogram(TurningLON)
ylabel("Count")
xlabel("LON [º]")
title('Longitude at turning point')
subplot(153)
histogram(TurningAlt)
ylabel("Count")
xlabel("Altitude [ft]")
title('Altitude at turning point')
subplot(154)
histogram(TurningRadial)
ylabel("Count")
xlabel("Radial [º]")
title('DVOR radial at turning point')
subplot(155)
histogram(CriticalRadial)
ylabel("Count")
xlabel("Radial [º]")
title('DVOR critical radial')
%% Histograms by SID Radial
figure
subplot(131)
histogram(G1TurningRadial, 'Normalization','count')
title('SID Group 1, Radial at turning point')
xlabel("Radial [º]")
subplot(132)
histogram(G2TurningRadial, 'Normalization','count')
title('SID Group 2, Radial at turning point')
xlabel("Radial [º]")
subplot(133)
histogram(G3TurningRadial, 'Normalization','count')
title('SID Group 3, Radial at turning point')
xlabel("Radial [º]")
%% Histograms by SID Radial critical
figure
subplot(131)
histogram(G1CriticalRadial, 'Normalization','count')
title('SID Group 1, Radial critical point')
xlabel("Radial [º]")
subplot(132)
histogram(G2CriticalRadial, 'Normalization','count')
title('SID Group 2, Radial critical point')
xlabel("Radial [º]")
subplot(133)
histogram(G3CriticalRadial, 'Normalization','count')
title('SID Group 3, Radial critical point')
xlabel("Radial [º]")

%% Histograms by SID Alt
figure
subplot(131)
histogram(G1TurningAlt, 'Normalization','count')
title('SID Group 1, Altitude at turning point')
xlabel("Altitude [ft]")
subplot(132)
histogram(G2TurningAlt, 'Normalization','count')
title('SID Group 2, Altitude at turning point')
xlabel("Altitude [ft]")
subplot(133)
histogram(G3TurningAlt, 'Normalization','count')
title('SID Group 3, Altitude at turning point')
xlabel("Altitude [ft]")

%% Scatter LON, LAT
figure
scatter3(TurningLAT, TurningLON, TurningAlt)
title("Turning point")
xlabel("LAT [º]")
ylabel("LON [º]")
zlabel("Altitude [ft]")
figure
subplot(131)
scatter(TurningLAT, TurningLON)
title("Turning point LAT vs LON")
xlabel("LAT [º]")
ylabel("LON [º]")
subplot(132)
scatter(TurningLAT,TurningAlt)
title("Turning point LAT vs Altitude")
xlabel("LAT [º]")
ylabel("Altitude [ft]")
subplot(133)
scatter(TurningLON,TurningAlt)
title("Turning point LON vs Altitude")
xlabel("LON [º]")
ylabel("Altitude [ft]")
%% Export to KML
KMLfilename = "scatteredTurningPoint.kml";

kmlwritepoint(KMLfilename, TurningLAT, TurningLON);