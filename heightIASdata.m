function [aircraft] = heightIASdata(aircraft)
for i = 1:numel(aircraft)

    aircraft(i).IAS850 = median(aircraft(i).IASinterp(aircraft(i).AltInterp> 8.2 & aircraft(i).AltInterp< 8.8));
    aircraft(i).IAS1500 = median(aircraft(i).IASinterp(aircraft(i).AltInterp> 14.7 & aircraft(i).AltInterp< 15.3));
    aircraft(i).IAS3000 = median(aircraft(i).IASinterp(aircraft(i).AltInterp> 29.7 & aircraft(i).AltInterp< 30.3));
end