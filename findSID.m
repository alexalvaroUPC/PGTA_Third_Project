function [foundSID, SIDgroup] = findSID(SACTAroute, rwy)
SACTAroute = strrep(SACTAroute, "(", " ");
SACTAroute = strrep(SACTAroute, ")", " ");
SACTAroute = strsplit(SACTAroute, " ");
if rwy == "06R"
    appendSID = "-R";
else
    appendSID = "-Q";
end

G1_SID = ["OLOXO" "NATPI" "MOPAS" "LOBAR" "GRAUS" "MAMUK" "REBUL" "VIBOK" "DUQQI"];
G2_SID = ["LARPA" "DUNES" "SENIA" "LOTOS"];
G3_SID = ["AGENA" "DALIN" "DIPES"];

rwy06R_G1_SID = ["OLOXO-R" "NATPI-R" "MOPAS-R" "LOBAR-R" "GRAUS-R" "MAMUK-R" "REBUL-R" "VIBOK-R" "DUQQI-R"];
rwy06R_G2_SID = ["LARPA-R" "DUNES-R" "SENIA-R" "LOTOS-R"];
rwy06R_G3_SID = ["AGENA-R" "DALIN-R" "DIPES-R"];

rwy24L_G1_SID = ["OLOXO-Q" "NATPI-Q" "MOPAS-Q" "LOBAR-Q" "GRAUS-Q" "MAMUK-Q" "REBUL-Q" "VIBOK-Q" "DUQQI-Q"];
rwy24L_G2_SID = ["LARPA-Q" "DUNES-Q" "SENIA-Q" "LOTOS-Q"];
rwy24L_G3_SID = ["AGENA-Q" "DALIN-Q" "DIPES-Q"];

SIDname = "Unkown";
SIDgroup = "G0";
for i = 1:numel(SACTAroute)
    [~, idx, hitSID] = find(strcmp(G1_SID, SACTAroute{i}));
    if isempty(hitSID)
        [~, idx,hitSID] = find(strcmp(G2_SID, SACTAroute{i}));
        if isempty(hitSID)
            [~, idx,hitSID] = find(strcmp(G3_SID, SACTAroute{i}));
            if ~isempty(hitSID)
                SIDname = G3_SID(idx);
                SIDgroup = "G3";
            end
        else
            SIDname = G2_SID(idx);
            SIDgroup = "G2";
        end
    else
        SIDname = G1_SID(idx);
        SIDgroup = "G1";
    end
    foundSID = SIDname + appendSID;

end