function [Xg, Yg, Zg] = geodesic2geocentric(LAT, LON, H)

% WGS84
a = 6378137; % Semi-major axis
e_exp2 = 0.00669437999014; % Excentricity squared

Xg = zeros(size(LAT));
Yg = zeros(size(LAT));
Zg = zeros(size(LAT));

for i = 1:length(LAT)
    N = a / (sqrt(1 - e_exp2 * (sin(LAT(i)))^2));
    Xg(i) = (N + H(i)) * cos(LAT(i)) * cos(LON(i));
    Yg(i) = (N + H(i)) * cos(LAT(i)) * sin(LON(i));
    Zg(i) = ((1 - e_exp2) * N + H(i)) * sin(LAT(i));
end

end

