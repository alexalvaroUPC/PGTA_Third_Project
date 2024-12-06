%% INITIAL FILE OPERATIONS
clear all
close all
format long
% dataFilename = 'P3_08_12h.csv';
dataFilename = 'P3_00-24h.csv';
dataMatrix = asterixCSVtoMatrix(dataFilename);
%% SEEK DEPARTURES
departureFilename = 'Inputs P3 - Atenea/2305_02_dep_lebl.xlsx';
classFilename = 'Inputs P3 - Atenea/Tabla_Clasificacion_aeronaves.xlsx';
[departures24L, departures06R] = findDepartures(departureFilename, dataMatrix, classFilename);
% clear dataMatrix
%% PROCESS DATA (conversions and altitude correction)
workingMatrix24L = asterixDataProcessing(departures24L);
workingMatrix06R = asterixDataProcessing(departures06R);
%% CREATE AICRAFT LISTS
[aircraft24L, tVector24L] = createAircraftVector(workingMatrix24L);
% Between 08-12 no aircraft depart from 06R
[aircraft06R, tVector06R] = createAircraftVector(workingMatrix06R);
% clear workingMatrix24L
% clear workingMatrix06R
%% INTEREST POINTS STEREOGRAPHIC COORDINATES
LATthr24L = 41.292219; 
LONthr24L = 2.103281;
Hthr24L = 8*0.3048;

LATthr06R = 41.282311;
LONthr06R = 2.07435;
Hthr06R = 8*0.3048;

LATcamping = 41.2719444444440;
LONcamping = 2.04777777778;
Hcamping = 0;

[Uthr24L, Vthr24L, HsThr24L] = singlePointGeodesic2Sterographic(LATthr24L,LONthr24L,Hthr24L);
[Uthr06R, Vthr06R, HsThr06R] = singlePointGeodesic2Sterographic(LATthr06R,LONthr06R,Hthr06R);
[Ucamping, Vcamping, HsCamping] = singlePointGeodesic2Sterographic(LATcamping,LONcamping,Hcamping);
%% DISTANCES BETWEEN SUCCESSIVE DEPARTURES
distances24L = distanceCalculation(aircraft24L, Uthr06R,Vthr06R, tVector24L);
distances06R = distanceCalculation(aircraft06R, Uthr24L, Vthr24L, tVector06R);
[LoAviolations24L, RADARviolations24L, WakeViolations24L] = separationAnalysis(distances24L);
[LoAviolations06R, RADARviolations06R, WakeViolations06R] = separationAnalysis(distances06R);

%% TURNING POINT DETECTION
aircraft24L = turningPointDetection(aircraft24L, tVector24L);

%% SONOMETER DISTANCES
[aircraft24L] = distanceSonometer(aircraft24L,Ucamping,Vcamping);

%% HEIGHT AND IAS ABOVE THRESHOLD
[aircraft24L] = aboveThresholdData(aircraft24L,Uthr06R,Vthr06R, "P24L", tVector24L);
[aircraft06R] = aboveThresholdData(aircraft06R, Uthr24L, Vthr24L, "Circle", tVector06R);

%% IAS vs HEIGHT ANALYSIS
aircraft24L = heightIASdata(aircraft24L, tVector24L);
aircraft06R = heightIASdata(aircraft06R, tVector06R);

%% SAVE DATA
savename = "mydata_" + dataFilename + ".mat";
save(savename, "aircraft24L", "aircraft06R", "distances24L", "distances06R", "LoAviolations24L", "LoAviolations06R", "RADARviolations24L", "RADARviolations06R", "WakeViolations24L", "WakeViolations06R");

%% Interp1 vs IVV interpolation
sampleAlt = aircraft24L(3).Alt*100;
IVV = aircraft24L(3).IVV;
j = 1;
for i = 1:numel(sampleAlt)
    interpolatedAlt(j) = sampleAlt(i);
    interpolatedAlt(j+1) = sampleAlt(i) + IVV(i)/60;
    interpolatedAlt(j+2) = sampleAlt(i) + IVV(i)/30;
    interpolatedAlt(j+3) = sampleAlt(i) + IVV(i)/20;
    j = j +4;
end
mbinterpAlt = smartInterpolation(aircraft24L(3).TIMEseconds,aircraft24L(3).Alt, tVector24L, aircraft24L(3).interpStart, aircraft24L(3).interpEnd)*100;
figure
subplot(121)
plot(interpolatedAlt);
title("Suggested interpolation using IVV")
subplot(122)
plot(mbinterpAlt(find(mbinterpAlt>-400)));
title("Matlab interpolation using Alt")
% Matlab interpolation shows good results and gets rid of NaN values that
% would appear using IVV. Therefore, we have decided to use interp1() to
% interpolate desired values due to its simplicity and ease of
% implementation.
