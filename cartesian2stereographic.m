function [U, V, H] = cartesian2stereographic(Xs, Ys, Zs)

format long

% WGS84
a = 6378137; % Semi-major axis
e_exp2 = 0.00669437999014; % Excentricity squared

L = deg2rad(41.11571111); % System reference lat in rad

% Tangent radius of the estereogrpahic system
RTo = (a*(1-e_exp2))/(sqrt(1-e_exp2*(sin(L))^2)^3); % Can change depending on the referene system [m]

dxy = sqrt(Xs.^2 + Ys.^2);
hxy = 0; % In [m]

H = sqrt((dxy.^2)+(Zs + hxy + RTo).^2) - RTo;

% Scale factor
k = 2*RTo ./ (2*RTo+Zs+hxy+H);

% Stereographic coordinates
U = k .* Xs;
V = k .* Ys;


end

