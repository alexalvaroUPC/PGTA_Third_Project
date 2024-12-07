%% VECTOR PREPARATION
k = 1;
for i = 1:numel(aircraft06R)
    if ~isempty(aircraft06R(i).ThrIAS)
        if ~isnan(aircraft06R(i).ThrIAS)
            Callsigns06R(k) = [aircraft06R(i).Callsign];
            ThresholdAlt06R(k) = [aircraft06R(i).ThrAlt]*100;
            ThresholdIAS06R(k) = [aircraft06R(i).ThrIAS];
            SIDs_06R(k) = [aircraft06R(i).SID];
            SIDgroups_06R(k) = [aircraft06R(i).SIDgroup];
            k = k+1;
        end
    end
end
%% DATA CLASSIFICATION
[~, SIDgroupidx, ~] = find(SIDgroups_06R == "G1");
G1ThrAlt_06R = ThresholdAlt06R(SIDgroupidx);
G1ThrIAS_06R = ThresholdIAS06R(SIDgroupidx);
[~, SIDgroupidx, ~] = find(SIDgroups_06R == "G2");
G2ThrAlt_06R = ThresholdAlt06R(SIDgroupidx);
G2ThrIAS_06R = ThresholdIAS06R(SIDgroupidx);
[~, SIDgroupidx, ~] = find(SIDgroups_06R == "G3");
G3ThrAlt_06R = ThresholdAlt06R(SIDgroupidx);
G3ThrIAS_06R = ThresholdIAS06R(SIDgroupidx);

%% FASTEST AND HIGHEST
[maxThrAlt_06R, idxAltMax] = max(ThresholdAlt06R);
[minThrAlt_06R, idxAltMin] = min(ThresholdAlt06R);
highestThr06R = Callsigns06R(idxAltMax);
lowestThr06R = Callsigns06R(idxAltMin);

[maxThrIAS_06R, idxIASmax] = max(ThresholdIAS06R);
[minThrIAS_06R, idxIASmin] = min(ThresholdIAS06R);
fastestThr06R = Callsigns06R(idxIASmax);
slowestThr06R = Callsigns06R(idxIASmin);

%% Statistical data
meanThrAlt_06R = mean(ThresholdAlt06R);
meanThrIAS_06R = mean(ThresholdIAS06R);
desvThrAlt_06R = std(ThresholdAlt06R);
desvThrIAS_06R = std(ThresholdIAS06R);
p95_ThrAlt_06R = prctile(ThresholdAlt06R, 95);
p95_ThrIAS_06R = prctile(ThresholdIAS06R, 95);

%% Statistical data per SID
G1.meanThrIAS_06R = mean(G1ThrIAS_06R);
G1.meanThrAlt_06R = mean(G1ThrAlt_06R);
G1.desvThrIAS_06R = std(G1ThrIAS_06R);
G1.desvThrAlt_06R = std(G1ThrAlt_06R);
G1.p95_ThrIAS_06R = prctile(G1ThrIAS_06R, 95);
G1.p95_ThrAlt_06R = prctile(G1ThrAlt_06R, 95);

G2.meanThrIAS_06R = mean(G2ThrIAS_06R);
G2.meanThrAlt_06R = mean(G2ThrAlt_06R);
G2.desvThrIAS_06R = std(G2ThrIAS_06R);
G2.desvThrAlt_06R = std(G2ThrAlt_06R);
G2.p95_ThrIAS_06R = prctile(G2ThrIAS_06R, 95);
G2.p95_ThrAlt_06R = prctile(G2ThrAlt_06R, 95);

G3.meanThrIAS_06R = mean(G3ThrIAS_06R);
G3.meanThrAlt_06R = mean(G3ThrAlt_06R);
G3.desvThrIAS_06R = std(G3ThrIAS_06R);
G3.desvThrAlt_06R = std(G3ThrAlt_06R);
G3.p95_ThrIAS_06R = prctile(G3ThrIAS_06R, 95);
G3.p95_ThrAlt_06R = prctile(G3ThrAlt_06R, 95);
%% Histogram for all A/C
figure
subplot(121)
histogram(ThresholdAlt06R)
ylabel("Count")
xlabel("Alt [ft]")
title('Altitude above threshold histogram')
subplot(122)
histogram(ThresholdIAS06R)
ylabel("Count")
xlabel("IAS [kt]")
title('IAS above threshold histogram')
%% Histograms by SID IAS above threshold
figure
subplot(131)
histogram(G1ThrIAS_06R, 'Normalization','count')
title('SID Group 1, IAS above threshold histogram')
xlabel("IAS [kt]")
subplot(132)
histogram(G2ThrIAS_06R, 'Normalization','count')
title('SID Group 2, IAS above threshold histogram')
xlabel("IAS [kt]")
subplot(133)
histogram(G3ThrIAS_06R, 'Normalization','count')
title('SID Group 3, IAS above threshold histogram')
xlabel("IAS [kt]")
%% Histograms by SID Altitude above threshold
figure
subplot(131)
histogram(G1ThrAlt_06R, 'Normalization','count')
title('SID Group 1, Altitude above threshold histogram')
xlabel("Atltitude [ft]")
subplot(132)
histogram(G2ThrAlt_06R, 'Normalization','count')
title('SID Group 2, Altitude above threshold histogram')
xlabel("Atltitude [ft]")
subplot(133)
histogram(G3ThrAlt_06R, 'Normalization','count')
title('SID Group 3, Altitude above threshold histogram')
xlabel("Atltitude [ft]")
