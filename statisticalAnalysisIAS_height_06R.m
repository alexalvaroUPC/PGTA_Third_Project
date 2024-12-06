%% VECTOR PREPARATION
k = 1;
for i = 1:numel(aircraft06R)
    if ~isempty(aircraft06R(i).IAS850)
        if (aircraft06R(i).IAS850 > 0) && (aircraft06R(i).IAS1500 > 0) && (aircraft06R(i).IAS3000 > 0)
            Callsigns06R(k) = [aircraft06R(i).Callsign];
            IAS850_06R(k) = [aircraft06R(i).IAS850];
            IAS1500_06R(k) = [aircraft06R(i).IAS1500];
            IAS3000_06R(k) = [aircraft06R(i).IAS3000];
            SIDs_06R(k) = [aircraft06R(i).SID];
            SIDgroups_06R(k) = [aircraft06R(i).SIDgroup];
            k = k+1;
        end
    end
end
%% DATA CLASSIFICATION
[~, SIDgroupidx, ~] = find(SIDgroups_06R == "G1");
G1IAS85006R = IAS850_06R(SIDgroupidx);
G1IAS150006R = IAS1500_06R(SIDgroupidx);
G1IAS300006R = IAS3000_06R(SIDgroupidx);
[~, SIDgroupidx, ~] = find(SIDgroups_06R == "G2");
G2IAS85006R = IAS850_06R(SIDgroupidx);
G2IAS150006R = IAS1500_06R(SIDgroupidx);
G2IAS300006R = IAS3000_06R(SIDgroupidx);
[~, SIDgroupidx, ~] = find(SIDgroups_06R == "G3");
G3IAS85006R = IAS850_06R(SIDgroupidx);
G3IAS150006R = IAS1500_06R(SIDgroupidx);
G3IAS300006R = IAS3000_06R(SIDgroupidx);

%% FASTEST AND SLOWEST
[max850_06R, idx850max] = max(IAS850_06R);
[min850_06R, idx850min] = min(IAS850_06R);
fastest06R850 = Callsigns06R(idx850max);
slowest06R850 = Callsigns06R(idx850min);

[max1500_06R, idx1500max] = max(IAS1500_06R);
[min1500_06R, idx1500min] = min(IAS1500_06R);
fastest06R1500 = Callsigns06R(idx1500max);
slowest06R1500 = Callsigns06R(idx1500min);

[max3000_06R, idx3000max] = max(IAS3000_06R);
[min3000_06R, idx3000min] = min(IAS3000_06R);
fastest06R3000 = Callsigns06R(idx3000max);
slowest06R3000 = Callsigns06R(idx3000min);

%% Statistical data
mean850_06R = mean(IAS850_06R);
mean1500_06R = mean(IAS1500_06R);
mean3000_06R = mean(IAS3000_06R);
desv850_06R = std(IAS850_06R);
desv1500_06R = std(IAS1500_06R);
desv3000_06R = std(IAS3000_06R);
p95_850_06R = prctile(IAS850_06R, 95);
p95_1500_06R = prctile(IAS1500_06R, 95);
p95_3000_06R = prctile(IAS3000_06R, 95);

%% Statistical data per SID
G1mean850_06R = mean(G1IAS85006R);
G1mean1500_06R = mean(G1IAS150006R);
G1mean3000_06R = mean(G1IAS300006R);
G1desv850_06R = std(G1IAS85006R);
G1desv1500_06R = std(G1IAS150006R);
G1desv3000_06R = std(G1IAS300006R);
G1p95_850_06R = prctile(G1IAS85006R, 95);
G1p95_1500_06R = prctile(G1IAS150006R, 95);
G1p95_3000_06R = prctile(G1IAS300006R, 95);

G2mean850_06R = mean(G2IAS85006R);
G2mean1500_06R = mean(G2IAS150006R);
G2mean3000_06R = mean(G2IAS300006R);
G2desv850_06R = std(G2IAS85006R);
G2desv1500_06R = std(G2IAS150006R);
G2desv3000_06R = std(G2IAS300006R);
G2p95_850_06R = prctile(G2IAS85006R, 95);
G2p95_1500_06R = prctile(G2IAS150006R, 95);
G2p95_3000_06R = prctile(G2IAS300006R, 95);

G3mean850_06R = mean(G3IAS85006R);
G3mean1500_06R = mean(G3IAS150006R);
G3mean3000_06R = mean(G3IAS300006R);
G3desv850_06R = std(G3IAS85006R);
G3desv1500_06R = std(G3IAS150006R);
G3desv3000_06R = std(G3IAS300006R);
G3p95_850_06R = prctile(G3IAS85006R, 95);
G3p95_1500_06R = prctile(G3IAS150006R, 95);
G3p95_3000_06R = prctile(G3IAS300006R, 95);
%% Histogram for all A/C
figure
subplot(131)
histogram(IAS850_06R)
ylabel("Count")
xlabel("IAS [kt]")
title('IAS @850ft histogram')
subplot(132)
histogram(IAS1500_06R)
ylabel("Count")
xlabel("IAS [kt]")
title('IAS @1500ft histogram')
subplot(133)
histogram(IAS3000_06R)
ylabel("Count")
xlabel("IAS [kt]")
title('IAS @3000ft histogram')
%% Histograms by SID @850ft
figure
subplot(131)
histogram(G1IAS85006R, 'Normalization','count')
title('SID Group 1, IAS @850ft histogram')
xlabel("IAS [kt]")
subplot(132)
histogram(G2IAS85006R, 'Normalization','count')
title('SID Group 2, IAS @850ft histogram')
xlabel("IAS [kt]")
subplot(133)
histogram(G3IAS85006R, 'Normalization','count')
title('SID Group 3, IAS @850ft histogram')
xlabel("IAS [kt]")
%% Histograms by SID @1500ft
figure
subplot(131)
histogram(G1IAS150006R, 'Normalization','count')
title('SID Group 1, IAS @1500ft histogram')
xlabel("IAS [kt]")
subplot(132)
histogram(G2IAS150006R, 'Normalization','count')
title('SID Group 2, IAS @1500ft histogram')
xlabel("IAS [kt]")
subplot(133)
histogram(G3IAS150006R, 'Normalization','count')
title('SID Group 3, IAS @1500ft histogram')
xlabel("IAS [kt]")
%% Histograms by SID @3000ft
figure
subplot(131)
histogram(G1IAS300006R, 'Normalization','count')
title('SID Group 1, IAS @3000ft histogram')
xlabel("IAS [kt]")
subplot(132)
histogram(G2IAS300006R, 'Normalization','count')
title('SID Group 2, IAS @3000ft histogram')
xlabel("IAS [kt]")
subplot(133)
histogram(G3IAS300006R, 'Normalization','count')
title('SID Group 3, IAS @3000ft histogram')
xlabel("IAS [kt]")