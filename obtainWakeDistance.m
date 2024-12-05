function minSep = obtainWakeDistance(firstACwake, secondACwake)
switch firstACwake
    case "SH"
        if secondACwake == "H"
            minSep = 6;
        elseif secondACwake == "M"
            minSep = 7;
        elseif secondACwake == "L"
            minSep = 8;
        else
            minSep = -1;
        end
    case "H"
        if secondACwake == "H"
            minSep = 4;
        elseif secondACwake == "M"
            minSep = 5;
        elseif secondACwake == "L"
            minSep = 6;
        else
            minSep = -1;
        end
    case "M"
        if secondACwake == "L"
            minSep = 5;
        else
            minSep = -1;
        end
    case "L"
        minSep = -1;
end