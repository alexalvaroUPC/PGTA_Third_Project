function [distances] = distanceCalculation(aircrafts)
for i = 2:numel(aircrafts)
    firstAC = aircrafts(i-1);
    secondAC = aircrafts(i);
    distances(i-1).InvolvedAC = firstAC.Callsign + "_" + secondAC.Callsign;
    distances(i-1).WakesInvolved = firstAC.Wake + "_" + secondAC.Wake;
    distances(i-1).ClassesInvolved = firstAC.Class + "_" + secondAC.Class;
    k=1;
    for j = 1:numel(firstAC.Uinterp)
        if(firstAC.Uinterp(j)>-100)&&(secondAC.Uinterp(j)>-100)
            distances(i-1).Separations(k) = sqrt((firstAC.Uinterp(j)-secondAC.Uinterp(j))^2+(firstAC.Vinterp(j)-secondAC.Vinterp(j))^2);
            k = k+1;
        end
    end
end