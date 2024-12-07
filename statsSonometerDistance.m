
%% Prepare Vector

MinSonometerDistance=[aircraft24L.SonometerMinimumDistance];
% figure()
% histogram(MinSonometerDistance)
% ylabel("Count")
% xlabel("Distance [NM]")
% title('Minimum Distance to Sonometer')
Max_MinSonometerDistance=max(MinSonometerDistance);
Min_MinSonometerDistance=min(MinSonometerDistance);
Mean_MinSonometerDistance=mean(MinSonometerDistance);
Stddev_MinSonometerDistance=std(MinSonometerDistance);
perc_MinSonometerDistance=prctile(MinSonometerDistance,95);

% for i=1:numel(aircraft24L)
%     % if aircraft24L(i).SonometerMinimumDistance == Max_MinSonometerDistance
%     %     aircraft24L(i).Callsign
%     % end
%     % if aircraft24L(i).SonometerMinimumDistance == Min_MinSonometerDistance
%     %     aircraft24L(i).Callsign
%     % end
% end

%% Total Sonometer Lengths

figure;
hold on;
for i = 1:length(aircraft24L)
    plot(aircraft24L(i).SonometerDistances);
end
hold off;
xlabel('Time');
ylabel('Distance from Sonometer');
title('Aircraft Distances Over Time');
legend({aircraft24L.Callsign}, 'Location', 'eastoutside');

maxLength = max(cellfun(@length, {aircraft24L.SonometerDistances}));
paddedData = cellfun(@(x) [x, nan(1, maxLength-length(x))], {aircraft24L.SonometerDistances}, 'UniformOutput', false);

figure;
imagesc(cell2mat(paddedData)');
colorbar;
xlabel('Aircraft');
ylabel('Time');
title('Distance Heatmap');
set(gca, 'XTick', 1:length(aircraft24L), 'XTickLabel', {aircraft24L.Callsign}, 'XTickLabelRotation', 45);

% figure;
% boxplot({aircraft24L.SonometerDistances}, 'Labels', {aircraft24L.Callsign});
% ylabel('Distance from Sonometer');
% title('Distribution of Aircraft Distances');
% xtickangle(45);

% [X, Y] = meshgrid(1:maxLength, 1:length(aircraft24L));
% Z = cell2mat(paddedData)';
% 
% figure;
% surf(X, Y, Z);
% xlabel('Time');
% ylabel('Aircraft');
% zlabel('Distance');
% title('3D Surface Plot of Aircraft Distances');
% colorbar;
% set(gca, 'YTick', 1:length(aircraft24L), 'YTickLabel', {aircraft24L.Callsign});

figure;
hold on;
for i = 1:length(aircraft24L)
    scatter(i * ones(size(aircraft24L(i).SonometerDistances)), aircraft24L(i).SonometerDistances, [], 1:length(aircraft24L(i).SonometerDistances), 'filled');
end
hold off;
xlabel('Aircraft');
ylabel('Distance from Sonometer');
title('Aircraft Distances Over Time');
colorbar;
colormap(jet);
set(gca, 'XTick', 1:length(aircraft24L), 'XTickLabel', {aircraft24L.Callsign}, 'XTickLabelRotation', 45);

figure;
area(cell2mat(paddedData)');
xlabel('Time');
ylabel('Cumulative Distance');
title('Stacked Area Plot of Aircraft Distances');
legend({aircraft24L.Callsign}, 'Location', 'eastoutside');


% %% Separate per Class
% r=1;
% n=1;
% h=1;
% for i=1:numel(aircraft24L)
%     if aircraft24L(i).Class == "R"
%         SonometerDistance_ClassR(r) = [aircraft24L(i).SonometerMinimumDistance];
%         r=r+1;
%     end
%     if aircraft24L(i).Class == "NR+"
%         SonometerDistance_ClassNR(n) = [aircraft24L(i).SonometerMinimumDistance];
%         n=n+1;
%     end
%     if aircraft24L(i).Class == "HP"
%         SonometerDistance_ClassHP(h) = [aircraft24L(i).SonometerMinimumDistance];
%         h=h+1;
%     end
% end
% 
% MaxClassR = max(SonometerDistance_ClassR);
% MinClassR = min(SonometerDistance_ClassR);
% MeanClassR = mean(SonometerDistance_ClassR);
% stdClassR = std(SonometerDistance_ClassR);
% percClassR = prctile(SonometerDistance_ClassR, 95);
% MaxClassNR = max(SonometerDistance_ClassNR);
% MinClassNR = min(SonometerDistance_ClassNR);
% MeanClassNR = mean(SonometerDistance_ClassNR);
% stdClassNR = std(SonometerDistance_ClassNR);
% percClassNR = prctile(SonometerDistance_ClassNR, 95);
% MaxClassHP = max(SonometerDistance_ClassHP);
% MinClassHP = min(SonometerDistance_ClassHP);
% MeanClassHP = mean(SonometerDistance_ClassHP);
% stdClassHP = std(SonometerDistance_ClassHP);
% percClassHP = prctile(SonometerDistance_ClassHP, 95);
% 
% for i=1:numel(aircraft24L)
%     % if aircraft24L(i).SonometerMinimumDistance == MaxClassR
%     %     aircraft24L(i).Callsign
%     % end
%     % if aircraft24L(i).SonometerMinimumDistance == MinClassR
%     %     aircraft24L(i).Callsign
%     % end
%     % if aircraft24L(i).SonometerMinimumDistance == MaxClassNR
%     %     aircraft24L(i).Callsign
%     % end
%     % if aircraft24L(i).SonometerMinimumDistance == MinClassNR
%     %     aircraft24L(i).Callsign
%     % end
%     % if aircraft24L(i).SonometerMinimumDistance == MaxClassHP
%     %     aircraft24L(i).Callsign
%     % end
%     if aircraft24L(i).SonometerMinimumDistance == MinClassHP
%         aircraft24L(i).Callsign
%     end
% end
% 
% 
% figure()
% subplot 131
% histogram(SonometerDistance_ClassR)
% ylabel("Count")
% xlabel("Distance [NM]")
% title('Minimum Distance to Sonometer @Class = R')
% subplot 132
% histogram(SonometerDistance_ClassNR)
% ylabel("Count")
% xlabel("Distance [NM]")
% title('Minimum Distance to Sonometer @Class = NR+')
% subplot 133
% histogram(SonometerDistance_ClassHP)
% ylabel("Count")
% xlabel("Distance [NM]")
% title('Minimum Distance to Sonometer @Class = HP')

% %% Separate per Wake
% m=1;
% h=1;
% l=1;
% for i=1:numel(aircraft24L)
%     if aircraft24L(i).Wake == "M"
%         SonometerDistance_WakeM(m) = [aircraft24L(i).SonometerMinimumDistance];
%         m=m+1;
%     end
%     if aircraft24L(i).Wake == "H"
%         SonometerDistance_WakeH(h) = [aircraft24L(i).SonometerMinimumDistance];
%         h=h+1;
%     end
%     if aircraft24L(i).Wake == "L"
%         SonometerDistance_WakeL(l) = [aircraft24L(i).SonometerMinimumDistance];
%         l=l+1;
%     end
% end
% 
% MaxWakeL = max(SonometerDistance_WakeL);
% MinWakeL = min(SonometerDistance_WakeL);
% mean(SonometerDistance_WakeL)
% std(SonometerDistance_WakeL)
% prctile(SonometerDistance_WakeL, 95)
% MaxWakeM = max(SonometerDistance_WakeM);
% MinWakeM = min(SonometerDistance_WakeM);
% mean(SonometerDistance_WakeM)
% std(SonometerDistance_WakeM)
% prctile(SonometerDistance_WakeM, 95)
% MaxWakeH = max(SonometerDistance_WakeH);
% MinWakeH = min(SonometerDistance_WakeH);
% mean(SonometerDistance_WakeH)
% std(SonometerDistance_WakeH)
% prctile(SonometerDistance_WakeH, 95)
% 
% for i=1:numel(aircraft24L)
%     % if aircraft24L(i).SonometerMinimumDistance == MaxWakeL
%     %     aircraft24L(i).Callsign
%     % end
%     % if aircraft24L(i).SonometerMinimumDistance == MinWakeL
%     %     aircraft24L(i).Callsign
%     % end
%     % if aircraft24L(i).SonometerMinimumDistance == MaxWakeM
%     %     aircraft24L(i).Callsign
%     % end
%     % if aircraft24L(i).SonometerMinimumDistance == MinWakeM
%     %     aircraft24L(i).Callsign
%     % end
%     % if aircraft24L(i).SonometerMinimumDistance == MaxWakeH
%     %     aircraft24L(i).Callsign
%     % end
%     if aircraft24L(i).SonometerMinimumDistance == MinWakeH
%         aircraft24L(i).Callsign
%     end
% end
% 
% 
% figure()
% subplot 131
% histogram(SonometerDistance_WakeL)
% ylabel("Count")
% xlabel("Distance [NM]")
% title('Minimum Distance to Sonometer @Wake = L')
% subplot 132
% histogram(SonometerDistance_WakeM)
% ylabel("Count")
% xlabel("Distance [NM]")
% title('Minimum Distance to Sonometer @Wake = M')
% subplot 133
% histogram(SonometerDistance_WakeH)
% ylabel("Count")
% xlabel("Distance [NM]")
% title('Minimum Distance to Sonometer @Wake = H')

% %% Separate per SID
% g1=1;
% g2=1;
% g3=1;
% for i=1:numel(aircraft24L)
%     if aircraft24L(i).SIDgroup == "G1"
%         SonometerDistance_G1(g1) = [aircraft24L(i).SonometerMinimumDistance];
%         g1=g1+1;
%     end
%     if aircraft24L(i).SIDgroup == "G2"
%         SonometerDistance_G2(g2) = [aircraft24L(i).SonometerMinimumDistance];
%         g2=g2+1;
%     end
%     if aircraft24L(i).SIDgroup == "G3"
%         SonometerDistance_G3(g3) = [aircraft24L(i).SonometerMinimumDistance];
%         g3=g3+1;
%     end
% end
% 
% MaxG1 = max(SonometerDistance_G1);
% MinG1 = min(SonometerDistance_G1);
% MeanG1 = mean(SonometerDistance_G1);
% stdG1 = std(SonometerDistance_G1);
% percG1 = prctile(SonometerDistance_G1, 95);
% MaxG2 = max(SonometerDistance_G2);
% MinG2 = min(SonometerDistance_G2);
% MeanG2 = mean(SonometerDistance_G2);
% stdG2 = std(SonometerDistance_G2);
% percG2 = prctile(SonometerDistance_G2, 95);
% MaxG3 = max(SonometerDistance_G3);
% MinG3 = min(SonometerDistance_G3);
% MeanG3 = mean(SonometerDistance_G3);
% stdG3 = std(SonometerDistance_G3);
% percG3 = prctile(SonometerDistance_G3, 95);
% 
% for i=1:numel(aircraft24L)
%     % if aircraft24L(i).SonometerMinimumDistance == MaxG1
%     %     aircraft24L(i).Callsign
%     % end
%     % if aircraft24L(i).SonometerMinimumDistance == MinG1
%     %     aircraft24L(i).Callsign
%     % end
%     % if aircraft24L(i).SonometerMinimumDistance == MaxG2
%     %     aircraft24L(i).Callsign
%     % end
%     % if aircraft24L(i).SonometerMinimumDistance == MinG2
%     %     aircraft24L(i).Callsign
%     % end
%     % if aircraft24L(i).SonometerMinimumDistance == MaxG3
%     %     aircraft24L(i).Callsign
%     % end
%     if aircraft24L(i).SonometerMinimumDistance == MinG3
%         aircraft24L(i).Callsign
%     end
% end
% 
% 
% % figure()
% % subplot 131
% % histogram(SonometerDistance_G1)
% % ylabel("Count")
% % xlabel("Distance [NM]")
% % title('Minimum Distance to Sonometer @SID Group 1')
% % subplot 132
% % histogram(SonometerDistance_G2)
% % ylabel("Count")
% % xlabel("Distance [NM]")
% % title('Minimum Distance to Sonometer @SID Group 2')
% % subplot 133
% % histogram(SonometerDistance_G3)
% % ylabel("Count")
% % xlabel("Distance [NM]")
% % title('Minimum Distance to Sonometer @SID Group 3')