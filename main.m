%% INITIAL FILE OPERATIONS
close all
format long
dataFilename = 'P3_08_12h.csv';
dataMatrix = asterixCSVtoMatrix(dataFilename);
%% SEEK DEPARTURES
departureFilename = 'Inputs P3 - Atenea/2305_02_dep_lebl.xlsx';
classFilename = 'Inputs P3 - Atenea/Tabla_Clasificacion_aeronaves.xlsx';
[departures24L, departures06R] = findDepartures(departureFilename, dataMatrix, classFilename);
clear dataMatrix
%% PROCESS DATA (conversions and altitude correction)
workingMatrix24L = asterixDataProcessing(departures24L);
workingMatrix06R = asterixDataProcessing(departures06R);
%% CREATE AICRAFT LISTS
aircraft24L = createAircraftVector(workingMatrix24L);
% Between 08-12 no aircraft depart from 06R
% aircraft066R = createAircraftVector(workingMatrix06R);
clear workingMatrix24L
clear workingMatrix06R
%% INTEREST POINTS STEREOGRAPHIC COORDINATES
LATthr24L = 41.292219; 
LONthr24L = 2.103281;
Hthr24L = 4;

LATthr06R = 41.282311;
LONthr06R = 2.07435;
Hthr06R = 4;

LATcamping = 41.2719444444440;
LONcamping = 2.04777777778;
Hcamping = 0;

[Uthr24L, Vthr24L, HsThr24L] = singlePointGeodesic2Sterographic(LATthr24L,LONthr24L,Hthr24L);
[Uthr06R, Vthr06R, HsThr06R] = singlePointGeodesic2Sterographic(LATthr06R,LONthr06R,Hthr06R);
[Ucamping, Vcamping, HsCamping] = singlePointGeodesic2Sterographic(LATcamping,LONcamping,Hcamping);
%% DISTANCES BETWEEN SUCCESSIVE DEPARTURES
distances24L = distanceCalculation(aircraft24L, Uthr06R,Vthr06R);
[LoAviolations, RADARviolations, WakeViolations] = separationAnalysis(distances24L);
%% TURNING POINT DETECTION
aircraft24L = turningPointDetection(aircraft24L);

%% SONOMETER DISTANCES
[aircraft24L] = distanceSonometer(aircraft24L,Ucamping,Vcamping);

%% HEIGHT AND IAS ABOVE THRESHOLD
[aircraft24L] = aboveThresholdData(aircraft24L,Uthr06R,Vthr06R, "P24L");

%% IAS vs HEIGHT ANALYSIS