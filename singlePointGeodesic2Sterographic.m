function [U,V, Hs] = singlePointGeodesic2Sterographic(LAT, LON, H)
[Xg, Yg, Zg] = geodesic2geocentric(LAT, LON, H);
[Xs, Ys, Zs] = geocentric2cartesian(Xg, Yg, Zg);
[U, V, Hs] = cartesian2stereographic(Xs, Ys, Zs);
U =  U/1852;
V = V/1852;
end