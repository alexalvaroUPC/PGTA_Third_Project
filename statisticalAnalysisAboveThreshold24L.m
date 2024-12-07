%% VECTOR PREPARATION
k = 1;
for i = 1:numel(aircraft24L)
    if ~isempty(aircraft24L(i).ThrIAS)
        if ~isnan(aircraft24L(i).ThrIAS)
            Callsigns24L(k) = [aircraft24L(i).Callsign];
            ThresholdAlt24L(k) = [aircraft24L(i).ThrAlt]*100;
            ThresholdIAS24L(k) = [aircraft24L(i).ThrIAS];
            SIDs_24L(k) = [aircraft24L(i).SID];
            SIDgroups_24L(k) = [aircraft24L(i).SIDgroup];
            k = k+1;
        end
    end
end
%% DATA CLASSIFICATION
[~, SIDgroupidx, ~] = find(SIDgroups_24L == "G1");
G1ThrAlt_24L = ThresholdAlt24L(SIDgroupidx);
G1ThrIAS_24L = ThresholdIAS24L(SIDgroupidx);
[~, SIDgroupidx, ~] = find(SIDgroups_24L == "G2");
G2ThrAlt_24L = ThresholdAlt24L(SIDgroupidx);
G2ThrIAS_24L = ThresholdIAS24L(SIDgroupidx);
[~, SIDgroupidx, ~] = find(SIDgroups_24L == "G3");
G3ThrAlt_24L = ThresholdAlt24L(SIDgroupidx);
G3ThrIAS_24L = ThresholdIAS24L(SIDgroupidx);

%% FASTEST AND HIGHEST
[maxThrAlt_24L, idxAltMax] = max(ThresholdAlt24L);
[minThrAlt_24L, idxAltMin] = min(ThresholdAlt24L);
highestThr24L = Callsigns24L(idxAltMax);
lowestThr24L = Callsigns24L(idxAltMin);

[maxThrIAS_24L, idxIASmax] = max(ThresholdIAS24L);
[minThrIAS_24L, idxIASmin] = min(ThresholdIAS24L);
fastestThr24L = Callsigns24L(idxIASmax);
slowestThr24L = Callsigns24L(idxIASmin);

%% Statistical data
meanThrAlt_24L = mean(ThresholdAlt24L);
meanThrIAS_24L = mean(ThresholdIAS24L);
desvThrAlt_24L = std(ThresholdAlt24L);
desvThrIAS_24L = std(ThresholdIAS24L);
p95_ThrAlt_24L = prctile(ThresholdAlt24L, 95);
p95_ThrIAS_24L = prctile(ThresholdIAS24L, 95);

%% Statistical data per SID
G1.meanThrIAS_24L = mean(G1ThrIAS_24L);
G1.meanThrAlt_24L = mean(G1ThrAlt_24L);
G1.desvThrIAS_24L = std(G1ThrIAS_24L);
G1.desvThrAlt_24L = std(G1ThrAlt_24L);
G1.p95_ThrIAS_24L = prctile(G1ThrIAS_24L, 95);
G1.p95_ThrAlt_24L = prctile(G1ThrAlt_24L, 95);

G2.meanThrIAS_24L = mean(G2ThrIAS_24L);
G2.meanThrAlt_24L = mean(G2ThrAlt_24L);
G2.desvThrIAS_24L = std(G2ThrIAS_24L);
G2.desvThrAlt_24L = std(G2ThrAlt_24L);
G2.p95_ThrIAS_24L = prctile(G2ThrIAS_24L, 95);
G2.p95_ThrAlt_24L = prctile(G2ThrAlt_24L, 95);

G3.meanThrIAS_24L = mean(G3ThrIAS_24L);
G3.meanThrAlt_24L = mean(G3ThrAlt_24L);
G3.desvThrIAS_24L = std(G3ThrIAS_24L);
G3.desvThrAlt_24L = std(G3ThrAlt_24L);
G3.p95_ThrIAS_24L = prctile(G3ThrIAS_24L, 95);
G3.p95_ThrAlt_24L = prctile(G3ThrAlt_24L, 95);
%% Histogram for all A/C
figure
subplot(121)
histogram(ThresholdAlt24L)
ylabel("Count")
xlabel("Alt [ft]")
title('Altitude above threshold histogram')
subplot(122)
histogram(ThresholdIAS24L)
ylabel("Count")
xlabel("IAS [kt]")
title('IAS above threshold histogram')
%% Histograms by SID IAS above threshold
figure
subplot(131)
histogram(G1ThrIAS_24L, 'Normalization','count')
title('SID Group 1, IAS above threshold histogram')
xlabel("IAS [kt]")
subplot(132)
histogram(G2ThrIAS_24L, 'Normalization','count')
title('SID Group 2, IAS above threshold histogram')
xlabel("IAS [kt]")
subplot(133)
histogram(G3ThrIAS_24L, 'Normalization','count')
title('SID Group 3, IAS above threshold histogram')
xlabel("IAS [kt]")
%% Histograms by SID Altitude above threshold
figure
subplot(131)
histogram(G1ThrAlt_24L, 'Normalization','count')
title('SID Group 1, Altitude above threshold histogram')
xlabel("Atltitude [ft]")
subplot(132)
histogram(G2ThrAlt_24L, 'Normalization','count')
title('SID Group 2, Altitude above threshold histogram')
xlabel("Atltitude [ft]")
subplot(133)
histogram(G3ThrAlt_24L, 'Normalization','count')
title('SID Group 3, Altitude above threshold histogram')
xlabel("Atltitude [ft]")
