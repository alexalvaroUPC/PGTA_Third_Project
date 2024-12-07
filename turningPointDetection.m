function [aircraft] = turningPointDetection(aircraft, tVector)
LATdvor = 41.307111;
LONdvor = 2.107806;
radLATdvor = deg2rad(LATdvor);
radLONdvor = deg2rad(LONdvor);
for i=1:numel(aircraft)
    myAC = aircraft(i);
    if ~all(isnan(myAC.HDG))
        interpolatedHDG = smartInterpolation(myAC.TIMEseconds, myAC.HDG, tVector, myAC.interpStart, myAC.interpEnd);
        myAC.HDGinterp = interpolatedHDG;
        differentialHDG = diff(myAC.HDGinterp);
        interpolatedLAT = smartInterpolation(myAC.TIMEseconds, myAC.LAT, tVector, myAC.interpStart, myAC.interpEnd);
        myAC.LATinterp = interpolatedLAT;
        interpolatedLON = smartInterpolation(myAC.TIMEseconds, myAC.LON, tVector, myAC.interpStart, myAC.interpEnd);
        myAC.LONinterp = interpolatedLON;
        interpolatedU = smartInterpolation(myAC.TIMEseconds, myAC.U, tVector, myAC.interpStart, myAC.interpEnd);
        myAC.Uinterp = interpolatedU;
        interpolatedV = smartInterpolation(myAC.TIMEseconds, myAC.V, tVector, myAC.interpStart, myAC.interpEnd);
        myAC.Vinterp = interpolatedV;
        if ~all(isnan(myAC.Alt))
            interpolatedAlt = smartInterpolation(myAC.TIMEseconds, myAC.Alt, tVector, myAC.interpStart, myAC.interpEnd);
            myAC.AltInterp = interpolatedAlt;
        end
        for j = 1:numel(differentialHDG)
            radLATt = deg2rad(myAC.LATinterp(j));
            radLONt = deg2rad(myAC.LONinterp(j));
            radial = atan2(sin(radLONt-radLONdvor)*cos(radLATt), cos(radLATdvor)*sin(radLATt)-sin(radLATdvor)*cos(radLATt)*cos(radLONt-radLONdvor));
            radial = rad2deg(radial);
            if radial<0 radial = radial+360; end
            % aircraft(i).radials(j) = radial;
            if mean(differentialHDG(j:j+4)) <-1.4 && differentialHDG(j) > -390
                aircraft(i).turningLAT = myAC.LATinterp(j);
                aircraft(i).turningLON = myAC.LONinterp(j);
                aircraft(i).turningAlt = myAC.AltInterp(j);
                aircraft(i).turningU = myAC.Uinterp(j);
                aircraft(i).turningV = myAC.Vinterp(j);

                aircraft(i).turningRadial = radial;
                % j = numel(differentialHDG)+1;
                break
            end
        end
    end


end
end