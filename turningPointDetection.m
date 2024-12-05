function [aircraft] = turningPointDetection(aircraft)
LATdvor = 41.307111;
LONdvor = 2.107806;
radLATdvor = deg2rad(LATdvor);
radLONdvor = deg2rad(LONdvor);
for i=1:numel(aircraft)
    myAC = aircraft(i);
    differentialHDG = diff(myAC.HDGinterp);
    for j = 1:numel(differentialHDG)
        radLATt = deg2rad(myAC.LATinterp(j));
        radLONt = deg2rad(myAC.LONinterp(j));
        radial = atan2(sin(radLONt-radLONdvor)*cos(radLATt), cos(radLATdvor)*sin(radLATt)-sin(radLATdvor)*cos(radLATt)*cos(radLONt-radLONdvor));
        radial = rad2deg(radial);
        if radial<0 radial = radial+360; end
        % aircraft(i).radials(j) = radial;
        if differentialHDG(j) <-1.5 && differentialHDG(j) > -390
            aircraft(i).turningLAT = myAC.LATinterp(j);
            aircraft(i).turningLON = myAC.LONinterp(j);
            aircraft(i).turningAlt = myAC.AltInterp(j);
            aircraft(i).turningU = myAC.Uinterp(j);
            aircraft(i).turningV = myAC.Vinterp(j);

            aircraft(i).turningRadial = radial;
            j = numel(differentialHDG);
        end
    end

end
end