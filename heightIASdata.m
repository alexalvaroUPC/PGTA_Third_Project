function [aircraft] = heightIASdata(aircraft, tVector)
for i = 1:numel(aircraft)
    myAC = aircraft(i);
    if ~all(isnan(myAC.IAS))
        interpolatedIAS = smartInterpolation(myAC.TIMEseconds, myAC.IAS, tVector, myAC.interpStart, myAC.interpEnd);
        if ~all(isnan(aircraft(i).Alt))
            interpolatedAlt = smartInterpolation(myAC.TIMEseconds, myAC.Alt, tVector, myAC.interpStart, myAC.interpEnd);
            aircraft(i).IAS850 = median(interpolatedIAS(interpolatedAlt> 8.2 & interpolatedAlt< 8.8));
            aircraft(i).IAS1500 = median(interpolatedIAS(interpolatedAlt> 14.7 & interpolatedAlt< 15.3));
            aircraft(i).IAS3000 = median(interpolatedIAS(interpolatedAlt> 29.7 & interpolatedAlt< 30.3));
        end
    end
end