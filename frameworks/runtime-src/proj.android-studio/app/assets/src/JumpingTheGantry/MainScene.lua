local MainScene = class("MainScene", function()
    return cc.Layer:create()
end)
local MiniGameController = require("JumpingTheGantry.MiniGameController")
local StartLayer = require("JumpingTheGantry.StartLayer")
local RestartLayer = require("JumpingTheGantry.RestartLayer")
function MainScene:ctor()
    local rotateNode = cc.Node:create()
    rotateNode:addTo(self)
    rotateNode:setContentSize(cc.size(display.height, display.width))
    rotateNode:setAnchorPoint(cc.p(0.5, 0.5))
    rotateNode:setRotation(-90)
    rotateNode:move(display.cx, display.cy)
    self.rotateNode = rotateNode
    display.realWidth = display.height
    display.realHeight = display.width
    display.realCx = display.cy
    display.realCy = display.cx
    
    self.gameController = MiniGameController:create(self.rotateNode, StartLayer, RestartLayer)
    self.gameController:start()
end

return MainScene