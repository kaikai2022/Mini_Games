local MainScene = class("MainScene", function()
    return cc.Layer:create()
end)
local MiniGameController = require("GuessTheIdiom.MiniGameController")
---@public MainScene.NowLeave int 当前的等级
function MainScene:ctor()
    local rotateNode = cc.Node:create()
    rotateNode:addTo(self)
    rotateNode:setContentSize(cc.size(display.width, display.height))
    rotateNode:setAnchorPoint(cc.p(0.5, 0.5))
    --rotateNode:setRotation(0)
    rotateNode:move(display.cx, display.cy)
    self.rotateNode = rotateNode
    self.gameController = MiniGameController:create(self.rotateNode)
end

return MainScene