local writePath = cc.FileUtils:getInstance():getWritablePath()
cc.FileUtils:getInstance():setPopupNotify(false)
cc.FileUtils:getInstance():addSearchPath("src/")
cc.FileUtils:getInstance():addSearchPath("res/")
cc.FileUtils:getInstance():addSearchPath(writePath .. "src/")
cc.FileUtils:getInstance():addSearchPath(writePath .. "res/")
require("mobdebug").start()

require "config"
require "cocos.init"
local function main()
    local time_seed = os.time()
    math.randomseed(time_seed)

    --是否启用物理场景
    local isPhysics = false
    local scene = nil
    if isPhysics then
        scene = cc.Scene:createWithPhysics()
    else
        scene = cc.Scene:create()
    end
    --local layer = require("SuperBear.MainScene").new()   -- 竖版游戏
    --local layer = require("JumpingTheGantry.MainScene").new()   -- 跳龙门
    --local layer = require("PartyWheel.MainScene").new()   -- PartWheel

     --local layer = require("RunFromBlack.MainScene").new()   -- 横版游戏
    local layer = require("GuessTheIdiom.MainScene").new()   -- 猜谜语
    scene:addChild(layer)

    display.runScene(scene)
    cc.Director:getInstance():setDisplayStats(true)


end

local status, msg = xpcall(main, __G__TRACKBACK__)
if not status then
    print(msg)
end
