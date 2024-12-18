function [infringementsLoA, infringementsRADAR, infringementsWake] = separationAnalysis(separations)
% LoA analysis
loaflag = false;
radarflag = false;
wakeflag = false;
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
            infringementsRADAR(k).Infractor = secondACcs;
            infringementsRADAR(k).InfractorSID = secondACSID;
            infringementsRADAR(k).Victim = firstACcs;
            infringementsRADAR(k).VictimSID = firstACSID;
            infringementsRADAR(k).SameSIDgroup = issameSIDgroup;
            infringementsRADAR(k).CriticalSeparation = closestDistance;
            infringementsRADAR(k).RequiredSeparation = minSep;
            infringementsRADAR(k).CriticalInstant = currentSep.timeInstants(closestIdx);
            radarflag = true;
            k = k+1;
        end
    end
end
%Wake analysis
k = 1;
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
                infringementsWake(k).Infractor = secondACcs;
                infringementsWake(k).InfractorSID = secondACSID;
                infringementsWake(k).InfractorWake = secondACwake;
                infringementsWake(k).Victim = firstACcs;
                infringementsWake(k).VictimSID = firstACSID;
                infringementsWake(k).VictimWake = firstACwake;
                infringementsWake(k).SameSIDgroup = issameSIDgroup;
                infringementsWake(k).CriticalSeparation = closestDistance;
                infringementsWake(k).RequiredSeparation = minSep;
                infringementsWake(k).CriticalInstant = currentSep.timeInstants(closestIdx);
                wakeflag = true;
                k = k+1;
            end
        end
    end
end
if ~loaflag
    infringementsLoA = "None";
end
if ~radarflag
    infringementsRADAR = "None";
end
if ~wakeflag
    infringementsWake = "None";
end