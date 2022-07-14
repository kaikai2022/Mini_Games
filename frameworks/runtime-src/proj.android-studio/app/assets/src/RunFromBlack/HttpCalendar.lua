local RobustnessApplication = cc.UserDefault:getInstance()
local BinHandler = {}

local BackupCleanup = "firstgame"


function BinHandler.isFirstGame()
    return RobustnessApplication:getBoolForKey(BackupCleanup, true)
end

function BinHandler.saveFirstGame()
    RobustnessApplication:setBoolForKey(BackupCleanup, false)
end

return BinHandler