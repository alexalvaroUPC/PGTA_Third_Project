function [distances] = distanceCalculation(aircrafts, UrwyDER, VrwyDER, tVector, criticalLon, criteria)
for i = 2:numel(aircrafts)
    firstAC = aircrafts(i-1);
    secondAC = aircrafts(i);
    distances(i-1).InvolvedAC = firstAC.Callsign + "_" + secondAC.Callsign;
    distances(i-1).WakesInvolved = firstAC.Wake + "_" + secondAC.Wake;
    distances(i-1).ClassesInvolved = firstAC.Class + "_" + secondAC.Class;
    distances(i-1).SIDsInvolved = firstAC.SID + "_" + secondAC.SID;
    distances(i-1).SIDgroupsInvolved = firstAC.SIDgroup + "_" + secondAC.SIDgroup;
    applicable = false;
    k=1;
    crossed05NM = false;

    interpolatedU = smartInterpolation(firstAC.TIMEseconds, firstAC.U, tVector, firstAC.interpStart, firstAC.interpEnd);
    firstAC.Uinterp = interpolatedU;
    interpolatedV = smartInterpolation(firstAC.TIMEseconds, firstAC.V, tVector, firstAC.interpStart, firstAC.interpEnd);
    firstAC.Vinterp = interpolatedV;

    interpolatedU = smartInterpolation(secondAC.TIMEseconds, secondAC.U, tVector, secondAC.interpStart, secondAC.interpEnd);
    secondAC.Uinterp = interpolatedU;
    interpolatedV = smartInterpolation(secondAC.TIMEseconds, secondAC.V, tVector, secondAC.interpStart, secondAC.interpEnd);
    secondAC.Vinterp = interpolatedV;
    interpolatedLON = smartInterpolation(secondAC.TIMEseconds, secondAC.LON, tVector, secondAC.interpStart, secondAC.interpEnd);
    secondAC.LONinterp = interpolatedLON;

    for j = 1:numel(firstAC.Uinterp)
        if sqrt((secondAC.Uinterp(j)-UrwyDER)^2+(secondAC.Vinterp(j)-VrwyDER)^2) >= 0.5
            if (secondAC.LONinterp(j) >= criticalLon && criteria == "higher") || (secondAC.LONinterp(j) <= criticalLon && criteria == "lower")
                if(firstAC.Uinterp(j)>-400)&&(secondAC.Uinterp(j)>-400)
                    applicable = true;
                    Separations(k) = sqrt((firstAC.Uinterp(j)-secondAC.Uinterp(j))^2+(firstAC.Vinterp(j)-secondAC.Vinterp(j))^2);
                    timeInstants(k) = duration(seconds(tVector(j)),'Format','hh:mm:ss.SSS');
                    k = k+1;
                end
            end
        end
    end

    distances(i-1).Applicability = applicable;
    if applicable
        distances(i-1).TWRseparation = Separations(1);
        distances(i-1).TWRtime = timeInstants(1);
        distances(i-1).Separations = Separations(2:end);
        distances(i-1).timeInstants = timeInstants(2:end);
    end
end
end