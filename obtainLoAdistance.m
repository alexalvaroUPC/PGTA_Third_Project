function [minSep] = obtainLoAdistance(firstACtype, secondACtype, issameSIDgroup)
switch firstACtype
    case "HP"
        if (secondACtype == "HP") || (secondACtype == "R") || (secondACtype == "LP")
            if issameSIDgroup
                minSep = 5;
            else
                minSep = 3;
            end
        else
            minSep = 3;
        end
    case "R"
        if (secondACtype == "HP")
            if issameSIDgroup
                minSep = 7;
            else
                minSep = 5;
            end
        elseif (secondACtype == "R") || (secondACtype == "LP")
            if issameSIDgroup
                minSep = 5;
            else
                minSep = 3;
            end
        else
            minSep = 3;
        end
    case "LP"
        if (secondACtype == "HP")
            if issameSIDgroup
                minSep = 8;
            else
                minSep = 6;
            end
        elseif (secondACtype == "R")
            if issameSIDgroup
                minSep = 6;
            else
                minSep = 4;
            end
        elseif (secondACtype == "LP")
            if issameSIDgroup
                minSep = 5;
            else
                minSep = 3;
            end
        else
            minSep = 3;
        end
    case "NR+"
        if (secondACtype == "HP")
            if issameSIDgroup
                minSep = 11;
            else
                minSep = 8;
            end
        elseif (secondACtype == "R")|| (secondACtype == "LP")
            if issameSIDgroup
                minSep = 9;
            else
                minSep = 6;
            end
        elseif (secondACtype == "NR+")
            if issameSIDgroup
                minSep = 5;
            else
                minSep = 3;
            end
        else
            minSep = 3;
        end
    case "NR-"
        if (secondACtype == "HP") || (secondACtype == "R") || (secondACtype == "LP")
            minSep = 9;
        elseif (secondACtype == "NR+")
            if issameSIDgroup
                minSep = 9;
            else
                minSep = 6;
            end
        elseif (secondACtype == "NR-")
            if issameSIDgroup
                minSep = 5;
            else
                minSep = 3;
            end
        else
            minSep = 3;
        end
    case "NR"
        if (secondACtype == "NR")
            if issameSIDgroup
                minSep = 5;
            else
                minSep = 3;
            end
        else
            minSep = 9;
        end
end
end