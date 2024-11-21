function [Xs, Ys, Zs] = geocentric2cartesian(Xg, Yg, Zg)

format long

% WGS84
a = 6378137; % Semi-major axis
e_exp2 = 0.00669437999014; % Excentricity squared

% Reference system coordinates 
L = deg2rad(41.11571111); % System reference lat in rad
G = deg2rad(1.692502778); % System reference lon in rad
H = 0; % System reference h in m

% Generate a matrix of 3 x m
geocentricCoordinates = [Xg'; Yg'; Zg']; 

% Reference system parameters
eta = a / sqrt(1 - e_exp2 * sin(L)^2);
Xo = (eta + H) * cos(L) * cos(G);
Yo = (eta + H) * cos(L) * sin(G);
Zo = (eta * (1 - e_exp2) + H) * sin(L);

% Translation vector
T = [-Xo; -Yo; -Zo];

% Rotation matrix
Rs = [
    -sin(G), cos(G), 0;
    -sin(L)*cos(G), -sin(L)*sin(G), cos(L);
    cos(L)*cos(G), cos(L)*sin(G), sin(L)
];

% Apply transformation
cartesianCoordinates = Rs*(geocentricCoordinates + T);

% Separar las coordenadas resultantes
Xs = cartesianCoordinates(1, :);
Ys = cartesianCoordinates(2, :);
Zs = cartesianCoordinates(3, :);

end

