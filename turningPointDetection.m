function [aircraft] = turningPointDetection(aircraft)

for i=1:numel(aircraft)
    myAC = aircraft(i);
    differentialHDG = diff(myAC.HDGinterp);
    for j = 1:numel(differentialHDG)
        if differentialHDG(j) <-1.5 && differentialHDG(j) > -390
             aircraft(i).turningLAT = myAC.LATinterp(j);
             aircraft(i).turningLON = myAC.LONinterp(j);
             aircraft(i).turningAlt = myAC.AltInterp(j);
             aircraft(i).turningU = myAC.Uinterp(j);
             aircraft(i).turningV = myAC.Vinterp(j);
            j = numel(differentialHDG);
        end
    end
   
end
end