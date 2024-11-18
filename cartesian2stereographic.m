function [U, V, H] = cartesian2stereographic(Xs, Ys, Zs)

% Tangent radius of the estereogrpahic system
RTo = 6368942.808; % Can change depending on the referene system

% Scale factor
k = 2 * RTo ./ (2 * RTo + Zs);

% Stereographic coordinates
U = k .* Xs;
V = k .* Ys;

H = sqrt(Xs.^2 + Ys.^2); % Height at the stereographic plane

end

