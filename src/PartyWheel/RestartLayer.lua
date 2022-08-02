---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by lucus.
--- DateTime: 5/7/2022 2:02 PM
---
---@alias ScoreNode分数显示控件
local Sound = require("PartyWheel.Sound")

local RestartLayer = class("RestartLayer", function()
    return cc.Node:create()
end)

function RestartLayer:ctor(parent, onPlayGame, cbHome)
    self.mainNode = self
    self:addTo(parent)
    cc.LayerColor:create(cc.c4b(0, 0, 0, 180), display.realWidth, display.realHeight)
      :setAnchorPoint(cc.p(0.5, 0.5))
      :move(cc.p(-display.realCx, -display.realCy))
      :addTo(self)

    local titleBg = cc.Sprite:create("PartyWheel/image/over_bg.png")
                      :addTo(self)
                      :setScale(display.width / CC_DESIGN_RESOLUTION.width)

    local titleContentSize = titleBg:getContentSize()
    cc.Sprite:create("PartyWheel/image/over_title.png")
      :setAnchorPoint(cc.p(0.5, 0.5))
      :addTo(titleBg)
      :setPosition(cc.p(titleContentSize.height / 2, titleContentSize.width))
      :setScale(display.width / CC_DESIGN_RESOLUTION.width)

    self.contentSprite = cc.Sprite:create("PartyWheel/image/overType/gongbei.png")
                           :setAnchorPoint(cc.p(0.5, 0.5))
                           :addTo(titleBg)
                           :setPosition(cc.p(titleContentSize.height / 2, titleContentSize.width / 2))
                           :setScale(display.width / CC_DESIGN_RESOLUTION.width)

    ccui.Button:create("PartyWheel/image/btn_resetGame.png")
        :setAnchorPoint(cc.p(0.5, 0.5))
        :addTo(self)
        :setScale(display.width / CC_DESIGN_RESOLUTION.width)

        :move(cc.p(0, -(titleContentSize.width / 2 + 150)))
        :addClickEventListener(function(sender)
        if (onPlayGame) then
            onPlayGame()
        end
        Sound.onClicked()
    end)
end

function RestartLayer:showLayout(fileName)
    self.contentSprite:setTexture(string.format("PartyWheel/image/overType/%s.png", fileName))
    self:show()
    Sound.playResult()
end

function RestartLayer:hideLayout()
    Sound.stopResult()
    self:hide()
end

RestartLayer.HISTORY_HIGH_SCORE_KEY = "HISTORY_HIGH_SCORE_KEY_TLM"
return RestartLayer