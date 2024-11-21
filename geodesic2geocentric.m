function [Xg, Yg, Zg] = geodesic2geocentric(LAT, LON, H)

format long

% WGS84
a = 6378137; % Semi-major axis
e_exp2 = 0.00669437999014; % Excentricity squared

LAT = deg2rad(LAT);
LON = deg2rad(LON);

% Radio de curvatura
N = a ./ sqrt(1 - e_exp2 .* (sin(LAT).^2));
    
% Conversión a coordenadas cartesianas
Xg = (N + H) .* cos(LAT) .* cos(LON);
Yg = (N + H) .* cos(LAT) .* sin(LON);
Zg = ((1 - e_exp2) .* N + H) .* sin(LAT);

end

