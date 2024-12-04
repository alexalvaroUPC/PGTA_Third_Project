function [aircraft] = aboveThresholdData(aircraft, U, V, shape)
switch shape
    case "Circle"
        RunwayWidth = 60;
        extraFactor = 1.5;

        AreaRadius = RunwayWidth/2*extraFactor/1852;
        for i = 1:numel(aircraft)
            myAC = aircraft(i);
            k = 1;
            m = 1;
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
            in = inpolygon(myAC.Uinterp, myAC.Vinterp, studyArea.Vertices(:,1), studyArea.Vertices(:,2));
            aircraft(i).ThrIAS = myAC.IASinterp(in);
            aircraft(i).ThrAlt = myAC.AltInterp(in);
            for j = 1:numel(myAC.IASinterp)
                if myAC.Uinterp(j) > -400
                    dist2Thr = sqrt((myAC.Uinterp(j)-U)^2+(myAC.Vinterp(j)-V)^2);
                    aircraft(i).ThrDist(m) = dist2Thr;
                    m = m +1 ;
                end
            end
        end
end