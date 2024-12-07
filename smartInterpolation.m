function interpolatedData = smartInterpolation(x,v,xq, starting, ending)

interpolatedData = interp1(x,v,xq, 'makima');
interpolatedData(1:starting-1) = -400;
interpolatedData(ending+1:end) = -400;