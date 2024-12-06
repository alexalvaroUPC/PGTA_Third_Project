function [aircraft] = aboveThresholdData(aircraft, U, V, shape, tVector)
switch shape
    case "Circle"
        RunwayWidth = 60;
        extraFactor = 1.5;

        AreaRadius = RunwayWidth/2*extraFactor/1852;
        for i = 1:numel(aircraft)
            myAC = aircraft(i);
            interpolatedU = smartInterpolation(myAC.TIMEseconds, myAC.U, tVector, myAC.interpStart, myAC.interpEnd);
            myAC.Uinterp = interpolatedU;
            interpolatedV = smartInterpolation(myAC.TIMEseconds, myAC.V, tVector, myAC.interpStart, myAC.interpEnd);
            myAC.Vinterp = interpolatedV;
            k = 1;
            m = 1;
             if ~all(isnan(myAC.IAS))
                interpolatedIAS = smartInterpolation(myAC.TIMEseconds, myAC.IAS, tVector, myAC.interpStart, myAC.interpEnd);
                myAC.IASinterp = interpolatedIAS;
                if ~all(isnan(myAC.Alt))
                    interpolatedAlt = smartInterpolation(myAC.TIMEseconds, myAC.Alt, tVector, myAC.interpStart, myAC.interpEnd);
                    myAC.AltInterp = interpolatedAlt;
                end
            end
            for j = 1:numel(myAC.IASinterp)
                if myAC.Uinterp(j) > -400
                    dist2Thr = sqrt((myAC.Uinterp(j)-U)^2+(myAC.Vinterp(j)-V)^2);
                    aircraft(i).ThrDist(m) = dist2Thr;
                    m = m +1 ;
                    if  dist2Thr < AreaRadius
                        aircraft(i).ThrIAS(k) = myAC.IASinterp(j);
                        aircraft(i).ThrAlt(k) = myAC.AltInterp(j);
                        k = k +1;
                    end
                end
            end
        end
    case "P24L"
        hthr = 8*0.3048;
        lat_lon__hgeo_vertices = [41.282328 2.073547 hthr;41.283486 2.076939 hthr;41.283003 2.077214 hthr;41.281847 2.073839 hthr];
        [Uvert, Vvert, HsVert] = singlePointGeodesic2Sterographic(lat_lon__hgeo_vertices(:,1), lat_lon__hgeo_vertices(:,2), lat_lon__hgeo_vertices(:,3));
        studyArea = polyshape(Uvert,Vvert);
        for i = 1:numel(aircraft)
            myAC = aircraft(i);
            k = 1;
            m = 1;
            interpolatedU = smartInterpolation(myAC.TIMEseconds, myAC.U, tVector, myAC.interpStart, myAC.interpEnd);
            myAC.Uinterp = interpolatedU;
            interpolatedV = smartInterpolation(myAC.TIMEseconds, myAC.V, tVector, myAC.interpStart, myAC.interpEnd);
            myAC.Vinterp = interpolatedV;

            [in, on] = inpolygon(myAC.Uinterp, myAC.Vinterp, studyArea.Vertices(:,1), studyArea.Vertices(:,2));
            if ~all(isnan(myAC.IAS))
                interpolatedIAS = smartInterpolation(myAC.TIMEseconds, myAC.IAS, tVector, myAC.interpStart, myAC.interpEnd);
                myAC.IASinterp = interpolatedIAS;
                if ~all(isnan(myAC.Alt))
                    interpolatedAlt = smartInterpolation(myAC.TIMEseconds, myAC.Alt, tVector, myAC.interpStart, myAC.interpEnd);
                    myAC.AltInterp = interpolatedAlt;
                    aircraft(i).ThrIAS = mean(myAC.IASinterp([in, on]));
                    aircraft(i).ThrAlt = mean(myAC.AltInterp([in, on]));
                end
            end

            for j = 1:numel(myAC.Uinterp)
                if myAC.Uinterp(j) > -400
                    dist2Thr = sqrt((myAC.Uinterp(j)-U)^2+(myAC.Vinterp(j)-V)^2);
                    aircraft(i).ThrDist(m) = dist2Thr;
                    m = m +1 ;
                end
            end
        end
end