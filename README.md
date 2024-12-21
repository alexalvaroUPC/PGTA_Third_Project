# PGTA_Third_Project
Third project of the PGTA subject

Guide for the MATLAB scripts found in this repository
*Flowchart is available at the wiki section of the repository at github.com*
  1. main.m calculates all data needed for statistical analysis. It can be ran by sections depending on the data to be extracted.
       Executing the "SAVING DATA" section will save the needed variables for statistical analysis. By loading the resulting "mydata_XXX.mat" file, analysis can take place anytime
  2. Scripts for statistical analysis
     
      a. distanceLossPlots.m
     
      b. statisticalAnalysisAboveThreshold06R.m
     
      c. statisticalAnalysisAboveThreshold24L.m
     
      d. statisticalAnalysisIAS_height_24L.m
     
      e. statisticalAnalysisIAS_height_06R.m
     
      f. statisticalAnalysisTurningPoint.m
     
      g. statsSonometerDistance.m

scatteredTurningPoint.kml containts the points where turning has been deemed to start

newdata_P3_00-24h.csv.mat has all the data updated to the last criteria for TO times, TMA and TWR distinguishments, 0,5NM criterion reviewed and fixed, aircraft departing from 24R/06L removed

mydata_P3_00-24h.csv.mat contains all the variables resulting from analyzing a full day of .csv files if the TO time window is set to 5 minutes

mydata_P3_00-24h_old.csv.mat contains data from old executions before amendments were made.
