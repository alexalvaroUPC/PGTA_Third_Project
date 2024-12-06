%% VECTOR PREPARATION
k = 1;
for i = 1:numel(aircraft24L)
    if ~isempty(aircraft24L(i).IAS850)
        if (aircraft24L(i).IAS850 > 0) && (aircraft24L(i).IAS1500 > 0) && (aircraft24L(i).IAS3000 > 0)
            Callsigns24L(k) = [aircraft24L(i).Callsign];
            IAS850_24L(k) = [aircraft24L(i).IAS850];
            IAS1500_24L(k) = [aircraft24L(i).IAS1500];
            IAS3000_24L(k) = [aircraft24L(i).IAS3000];
            SIDs_24L(k) = [aircraft24L(i).SID];
            SIDgroups_24L(k) = [aircraft24L(i).SIDgroup];
            k = k+1;
        end
    end
end
%% DATA CLASSIFICATION
[~, SIDgroupidx, ~] = find(SIDgroups_24L == "G1");
G1IAS85024L = IAS850_24L(SIDgroupidx);
G1IAS150024L = IAS1500_24L(SIDgroupidx);
G1IAS300024L = IAS3000_24L(SIDgroupidx);
[~, SIDgroupidx, ~] = find(SIDgroups_24L == "G2");
G2IAS85024L = IAS850_24L(SIDgroupidx);
G2IAS150024L = IAS1500_24L(SIDgroupidx);
G2IAS300024L = IAS3000_24L(SIDgroupidx);
[~, SIDgroupidx, ~] = find(SIDgroups_24L == "G3");
G3IAS85024L = IAS850_24L(SIDgroupidx);
G3IAS150024L = IAS1500_24L(SIDgroupidx);
G3IAS300024L = IAS3000_24L(SIDgroupidx);

%% FASTEST AND SLOWEST
[max850_24L, idx850max] = max(IAS850_24L);
[min850_24L, idx850min] = min(IAS850_24L);
fastest24L850 = Callsigns24L(idx850max);
slowest24L850 = Callsigns24L(idx850min);

[max1500_24L, idx1500max] = max(IAS1500_24L);
[min1500_24L, idx1500min] = min(IAS1500_24L);
fastest24L1500 = Callsigns24L(idx1500max);
slowest24L1500 = Callsigns24L(idx1500min);

[max3000_24L, idx3000max] = max(IAS3000_24L);
[min3000_24L, idx3000min] = min(IAS3000_24L);
fastest24L3000 = Callsigns24L(idx3000max);
slowest24L3000 = Callsigns24L(idx3000min);

%% Statistical data
mean850_24L = mean(IAS850_24L);
mean1500_24L = mean(IAS1500_24L);
mean3000_24L = mean(IAS3000_24L);
desv850_24L = std(IAS850_24L);
desv1500_24L = std(IAS1500_24L);
desv3000_24L = std(IAS3000_24L);
p95_850_24L = prctile(IAS850_24L, 95);
p95_1500_24L = prctile(IAS1500_24L, 95);
p95_3000_24L = prctile(IAS3000_24L, 95);

%% Statistical data per SID
G1mean850_24L = mean(G1IAS85024L);
G1mean1500_24L = mean(G1IAS150024L);
G1mean3000_24L = mean(G1IAS300024L);
G1desv850_24L = std(G1IAS85024L);
G1desv1500_24L = std(G1IAS150024L);
G1desv3000_24L = std(G1IAS300024L);
G1p95_850_24L = prctile(G1IAS85024L, 95);
G1p95_1500_24L = prctile(G1IAS150024L, 95);
G1p95_3000_24L = prctile(G1IAS300024L, 95);

G2mean850_24L = mean(G2IAS85024L);
G2mean1500_24L = mean(G2IAS150024L);
G2mean3000_24L = mean(G2IAS300024L);
G2desv850_24L = std(G2IAS85024L);
G2desv1500_24L = std(G2IAS150024L);
G2desv3000_24L = std(G2IAS300024L);
G2p95_850_24L = prctile(G2IAS85024L, 95);
G2p95_1500_24L = prctile(G2IAS150024L, 95);
G2p95_3000_24L = prctile(G2IAS300024L, 95);

G3mean850_24L = mean(G3IAS85024L);
G3mean1500_24L = mean(G3IAS150024L);
G3mean3000_24L = mean(G3IAS300024L);
G3desv850_24L = std(G3IAS85024L);
G3desv1500_24L = std(G3IAS150024L);
G3desv3000_24L = std(G3IAS300024L);
G3p95_850_24L = prctile(G3IAS85024L, 95);
G3p95_1500_24L = prctile(G3IAS150024L, 95);
G3p95_3000_24L = prctile(G3IAS300024L, 95);
%% Histogram for all A/C
figure
subplot(131)
histogram(IAS850_24L)
ylabel("Count")
xlabel("IAS [kt]")
title('IAS @850ft histogram')
subplot(132)
histogram(IAS1500_24L)
ylabel("Count")
xlabel("IAS [kt]")
title('IAS @1500ft histogram')
subplot(133)
histogram(IAS3000_24L)
ylabel("Count")
xlabel("IAS [kt]")
title('IAS @3000ft histogram')
%% Histograms by SID @850ft
figure
subplot(131)
histogram(G1IAS85024L, 'Normalization','count')
title('SID Group 1, IAS @850ft histogram')
xlabel("IAS [kt]")
subplot(132)
histogram(G2IAS85024L, 'Normalization','count')
title('SID Group 2, IAS @850ft histogram')
xlabel("IAS [kt]")
subplot(133)
histogram(G3IAS85024L, 'Normalization','count')
title('SID Group 3, IAS @850ft histogram')
xlabel("IAS [kt]")
%% Histograms by SID @1500ft
figure
subplot(131)
histogram(G1IAS150024L, 'Normalization','count')
title('SID Group 1, IAS @1500ft histogram')
xlabel("IAS [kt]")
subplot(132)
histogram(G2IAS150024L, 'Normalization','count')
title('SID Group 2, IAS @1500ft histogram')
xlabel("IAS [kt]")
subplot(133)
histogram(G3IAS150024L, 'Normalization','count')
title('SID Group 3, IAS @1500ft histogram')
xlabel("IAS [kt]")
%% Histograms by SID @3000ft
figure
subplot(131)
histogram(G1IAS300024L, 'Normalization','count')
title('SID Group 1, IAS @3000ft histogram')
xlabel("IAS [kt]")
subplot(132)
histogram(G2IAS300024L, 'Normalization','count')
title('SID Group 2, IAS @3000ft histogram')
xlabel("IAS [kt]")
subplot(133)
histogram(G3IAS300024L, 'Normalization','count')
title('SID Group 3, IAS @3000ft histogram')
xlabel("IAS [kt]")