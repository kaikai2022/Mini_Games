local Sound = require("PartyWheel.Sound")
local SoundBtn = require("PartyWheel.SoundButtonNode")

local StartLayer = class("StartLayer", function()
    return cc.Node:create()
end)

function StartLayer:ctor(parent, onPlayGame)
    self.mainNode = self
    --self.mainNode:setContentSize(cc.size(display.realWidth, display.realHeight))
    self.mainNode:setLocalZOrder(10)
    self.mainNode:addTo(parent)


    --local hill = display.newSprite("SuperBear/hill.png")
    --hill:addTo(self.mainNode)
    --hill:move(display.realCx, display.realCy)

    local logo = display.newSprite("PartyWheel/image/logo.png")
    logo:addTo(self.mainNode)
    --logo:move(display.realCx, display.realCy + 180)

    local startBtn = ccui.Button:create("PartyWheel/image/btn_start_game.png")
                         :setAnchorPoint(cc.p(0.5, 0.5))
    startBtn:addTo(self.mainNode)
    startBtn:move(cc.p(0, -logo:getContentSize().height / 2 - 150))

    startBtn:addClickEventListener(function(sender)
        Sound.onClicked()
        onPlayGame()
    end)
    SoundBtn.new(self)
            :move(cc.p(-display.realCx + 100, display.realCy - 150))
end

return StartLayer