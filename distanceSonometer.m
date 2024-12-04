function [aircraft] = distanceSonometer(aircraft,U,V)
for i = 1:numel(aircraft)
    myAC = aircraft(i);
    distanceToSonometers = sqrt((myAC.U-U).^2+(myAC.V-V).^2);
    aircraft(i).SonometerDistances = distanceToSonometers;
end