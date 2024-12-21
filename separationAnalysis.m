function [infringementsLoA, infringementsRADAR_TMA, infringementsWake_TMA, infringementsRADAR_TWR, infringementsWake_TWR] = separationAnalysis(separations)
% LoA analysis
loaflag = false;
radarflagTMA = false;
wakeflagTMA = false;
radarflagTWR = false;
wakeflagTWR = false;
k = 1;
for i = 1:numel(separations)
    currentSep = separations(i);
    splitCallsigns = strsplit(currentSep.InvolvedAC, "_");
    splitClasses = strsplit(currentSep.ClassesInvolved, "_");
    splitSIDs = strsplit(currentSep.SIDsInvolved, "_");
    splitSIDgroups = strsplit(currentSep.SIDgroupsInvolved, "_");
    firstACcs = splitCallsigns{1};
    firstACtype = splitClasses{1};
    firstACSID = splitSIDs{1};
    firstACSIDgroup = splitSIDgroups{1};
    secondACcs = splitCallsigns{2};
    secondACtype = splitClasses{2};
    secondACSID = splitSIDs{2};
    secondACSIDgroup = splitSIDgroups{2};
    issameSIDgroup = firstACSIDgroup(2) == secondACSIDgroup(2);
    minSep = obtainLoAdistance(firstACtype, secondACtype, issameSIDgroup);
    if ~isempty(currentSep.TWRseparation)
        if currentSep.TWRseparation < minSep
            infringementsLoA(k).Infractor = secondACcs;
            infringementsLoA(k).InfractorSID = secondACSID;
            infringementsLoA(k).InfractorClass = secondACtype;
            infringementsLoA(k).Victim = firstACcs;
            infringementsLoA(k).VictimSID = firstACSID;
            infringementsLoA(k).VictimClass = firstACtype;
            infringementsLoA(k).SameSIDgroup = issameSIDgroup;
            infringementsLoA(k).Separation = currentSep.TWRseparation;
            infringementsLoA(k).RequiredSeparation = minSep;
            infringementsLoA(k).TimeOfInfraction = currentSep.TWRtime;
            loaflag = true;
            k = k+1;
        end
    end
end
% RADAR analysis
k = 1;
m = 1;
for i = 1:numel(separations)
    currentSep = separations(i);
    splitCallsigns = strsplit(currentSep.InvolvedAC, "_");
    splitSIDs = strsplit(currentSep.SIDsInvolved, "_");
    splitSIDgroups = strsplit(currentSep.SIDgroupsInvolved, "_");
    firstACcs = splitCallsigns{1};
    firstACSID = splitSIDs{1};
    firstACSIDgroup = splitSIDgroups{1};
    secondACcs = splitCallsigns{2};
    secondACSID = splitSIDs{2};
    secondACSIDgroup = splitSIDgroups{2};
    issameSIDgroup = firstACSIDgroup(2) == secondACSIDgroup(2);
    minSep = 3;
    if ~isempty(currentSep.Separations)
        [closestDistance, closestIdx] = min(currentSep.Separations);
        if closestDistance < minSep
            infringementsRADAR_TMA(k).Infractor = secondACcs;
            infringementsRADAR_TMA(k).InfractorSID = secondACSID;
            infringementsRADAR_TMA(k).Victim = firstACcs;
            infringementsRADAR_TMA(k).VictimSID = firstACSID;
            infringementsRADAR_TMA(k).SameSIDgroup = issameSIDgroup;
            infringementsRADAR_TMA(k).CriticalSeparation = closestDistance;
            infringementsRADAR_TMA(k).RequiredSeparation = minSep;
            infringementsRADAR_TMA(k).CriticalInstant = currentSep.timeInstants(closestIdx);
            radarflagTMA = true;
            k = k+1;
        end
        if currentSep.TWRseparation < minSep
            infringementsRADAR_TWR(m).Infractor = secondACcs;
            infringementsRADAR_TWR(m).InfractorSID = secondACSID;
            infringementsRADAR_TWR(m).Victim = firstACcs;
            infringementsRADAR_TWR(m).VictimSID = firstACSID;
            infringementsRADAR_TWR(m).SameSIDgroup = issameSIDgroup;
            infringementsRADAR_TWR(m).CriticalSeparation = closestDistance;
            infringementsRADAR_TWR(m).RequiredSeparation = minSep;
            infringementsRADAR_TWR(m).CriticalInstant = currentSep.timeInstants(closestIdx);
            radarflagTWR = true;
            m = m+1;
        end
    end
end
%Wake analysis
k = 1;
m = 1;
for i = 1:numel(separations)
    currentSep = separations(i);
    splitCallsigns = strsplit(currentSep.InvolvedAC, "_");
    splitWakes = strsplit(currentSep.WakesInvolved, "_");
    splitSIDs = strsplit(currentSep.SIDsInvolved, "_");
    splitSIDgroups = strsplit(currentSep.SIDgroupsInvolved, "_");
    firstACcs = splitCallsigns{1};
    firstACwake = splitWakes{1};
    firstACSID = splitSIDs{1};
    firstACSIDgroup = splitSIDgroups{1};
    secondACcs = splitCallsigns{2};
    secondACwake = splitWakes{2};
    secondACSID = splitSIDs{2};
    secondACSIDgroup = splitSIDgroups{2};
    issameSIDgroup = firstACSIDgroup(2) == secondACSIDgroup(2);
    minSep = obtainWakeDistance(firstACwake, secondACwake);
    if ~isempty(currentSep.Separations)
        if minSep ~= -1
            [closestDistance, closestIdx] = min(currentSep.Separations);
            if closestDistance < minSep
                infringementsWake_TMA(k).Infractor = secondACcs;
                infringementsWake_TMA(k).InfractorSID = secondACSID;
                infringementsWake_TMA(k).InfractorWake = secondACwake;
                infringementsWake_TMA(k).Victim = firstACcs;
                infringementsWake_TMA(k).VictimSID = firstACSID;
                infringementsWake_TMA(k).VictimWake = firstACwake;
                infringementsWake_TMA(k).SameSIDgroup = issameSIDgroup;
                infringementsWake_TMA(k).CriticalSeparation = closestDistance;
                infringementsWake_TMA(k).RequiredSeparation = minSep;
                infringementsWake_TMA(k).CriticalInstant = currentSep.timeInstants(closestIdx);
                wakeflagTMA = true;
                k = k+1;
            end
            if currentSep.TWRseparation < minSep
                infringementsWake_TWR(m).Infractor = secondACcs;
                infringementsWake_TWR(m).InfractorSID = secondACSID;
                infringementsWake_TWR(m).Victim = firstACcs;
                infringementsWake_TWR(m).VictimSID = firstACSID;
                infringementsWake_TWR(m).SameSIDgroup = issameSIDgroup;
                infringementsWake_TWR(m).CriticalSeparation = closestDistance;
                infringementsWake_TWR(m).RequiredSeparation = minSep;
                infringementsWake_TWR(m).CriticalInstant = currentSep.timeInstants(closestIdx);
                wakeflagTWR = true;
                m = m+1;
            end
        end
    end
end
if ~loaflag
    infringementsLoA = "None";
end
if ~radarflagTMA
    infringementsRADAR_TMA = "None";
end
if ~radarflagTWR
    infringementsRADAR_TWR = "None";
end
if ~wakeflagTMA
    infringementsWake_TMA = "None";
end
if ~wakeflagTWR
    infringementsWake_TWR = "None";
end