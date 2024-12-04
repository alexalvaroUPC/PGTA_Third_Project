function [distances] = distanceCalculation(aircrafts, UrwyDER, VrwyDER)
for i = 2:numel(aircrafts)
    firstAC = aircrafts(i-1);
    secondAC = aircrafts(i);
    distances(i-1).InvolvedAC = firstAC.Callsign + "_" + secondAC.Callsign;
    distances(i-1).WakesInvolved = firstAC.Wake + "_" + secondAC.Wake;
    distances(i-1).ClassesInvolved = firstAC.Class + "_" + secondAC.Class;
    k=1;
    crossed05NM = false;
    for j = 1:numel(firstAC.Uinterp)
        if sqrt((secondAC.Uinterp(j)-UrwyDER)^2+(secondAC.Vinterp(j)-VrwyDER)^2) >= 0.5
            if(firstAC.Uinterp(j)>-400)&&(secondAC.Uinterp(j)>-400)
                distances(i-1).Separations(k) = sqrt((firstAC.Uinterp(j)-secondAC.Uinterp(j))^2+(firstAC.Vinterp(j)-secondAC.Vinterp(j))^2);
                if ~crossed05NM
                    distances(i-1).TWRseparation =  distances(i-1).Separations(k);
                    crossed05NM = true;
                end
                k = k+1;
            end
        end
    end
end
end