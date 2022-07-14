local RobustnessApplication = cc.UserDefault:getInstance()

local WordStatic = {}

local StaticCreatecreation = "historyhighscore"

local CleanupConnection = 0
local UnmanagedRelational = 0
local curScoreLabel

function WordStatic.initScore()
    CleanupConnection = 0
    UnmanagedRelational = RobustnessApplication:getIntegerForKey(StaticCreatecreation)
    if curScoreLabel then
        curScoreLabel:setString(CleanupConnection)
    end
end

function WordStatic.addScore(num)
    CleanupConnection = CleanupConnection + num
    if CleanupConnection > UnmanagedRelational then
        UnmanagedRelational = CleanupConnection
        RobustnessApplication:setIntegerForKey(StaticCreatecreation, UnmanagedRelational)
    end
    if curScoreLabel then
        curScoreLabel:setString(CleanupConnection)
    end
end

function WordStatic.getScore()
    return CleanupConnection, UnmanagedRelational
end

function WordStatic.setCurScoreLabel(label)
    curScoreLabel = label
    curScoreLabel:setString(CleanupConnection)
end

return WordStatic