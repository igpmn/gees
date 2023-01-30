
cd(userpath)
disp("    Setting up workshop repositories in " + pwd())

geesDir = "igpmn-gees";
irisDir = "iris-bleeding";
timeStamp = string(datestr(now(), 30));

saveDirectoryWhenNeeded(geesDir, timeStamp);
saveDirectoryWhenNeeded(irisDir, timeStamp);

status = system("git clone --filter=blob:none https://github.com/igpmn/gees.git " + geesDir);
if status~=0
    error("Cannot clone IGPMN GEES model repository.");
end

status = system("git clone --filter=blob:none https://github.com/IRIS-Solutions-Team/IRIS-Toolbox.git " + irisDir);
if status~=0
    error("Cannot clone Iris Toolbox repository.");
end


function saveDirectoryWhenNeeded(dir, stamp)
    if exist(dir, "dir")
        dirStamped = dir + "-" + stamp;
        disp("    Moving the existing "+dir+" to "+dirStamped);
        movefile(dir, dirStamped);
    end
end%

