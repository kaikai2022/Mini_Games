local MainScene = class("MainScene", function()
    return cc.Layer:create()
end)
local MiniGameController = require("PartyWheel.MiniGameController")
local StartLayer = require("PartyWheel.StartLayer")
local RestartLayer = require("PartyWheel.RestartLayer")
local Sound = require("PartyWheel.Sound")
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
    Sound.playBgMusic()
    self.gameController = MiniGameController:create(self.rotateNode, StartLayer, RestartLayer)
    --self.gameController:start()
end

return MainScene