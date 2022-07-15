---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by lucus.
--- DateTime: 5/7/2022 2:02 PM
---
---@alias ScoreNode分数显示控件
local ScoreNode = class("RestartLayer", function()
    return cc.Node:create()
end)

local Sound = require("JumpingTheGantry.Sound")


function ScoreNode:ctor(parent, iconPath)
    self:setAnchorPoint(cc.p(0.5, 0.5))
    self:addTo(parent)
    local bg = display.newSprite("JumpingTheGantry/highest_score_bg.png")
                      :setAnchorPoint(cc.p(0.5, 0.5))
    --:move(cc.p(0, 0))
                      :addTo(self)

    self.contentSize = bg:getContentSize()

    local icon = display.newSprite(iconPath)
                        :setAnchorPoint(cc.p(0.5, 0.5))
                        :addTo(bg)

    local localContentSize = icon:getContentSize()
    icon:setPosition(cc.p(localContentSize.width, self.contentSize.height / 2))

    local nodeScore = ccui.Layout:create()
    --:setBackGroundColor(cc.c3b(255, 255, 0))
    --:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid) --设置颜色
                          :setContentSize(self.contentSize.width - localContentSize.width * 2, self.contentSize.height)
                          :addTo(bg)
                          :setPosition(localContentSize.width + localContentSize.width / 2, 0)
    localContentSize = nodeScore:getContentSize()
    self.textScore = ccui.TextBMFont:create()
                         :setAnchorPoint(cc.p(0.5, 0.5))
                         :addTo(nodeScore)
                         :setPosition(localContentSize.width / 2, localContentSize.height / 2)

    self.textScore:setFntFile("JumpingTheGantry/Gameing/now_score.fnt")
    self.textScore:setString(0)
end

---@alias 设置分数
---@param value 需要设置的分数
function ScoreNode:setString(value)
    self.textScore:setString(value)
end

local userDefault = cc.UserDefault:getInstance()

local RestartLayer = class("RestartLayer", function()
    return cc.Node:create()
end)

function RestartLayer:ctor(parent, onPlayGame, cbHome)
    self.mainNode = self
    self.mainNode:setContentSize(cc.size(display.realWidth, display.realHeight))
    self.mainNode:setLocalZOrder(10)
    self.mainNode:addTo(parent)

    local title_sprite = display.newSprite("JumpingTheGantry/Over/over_title.png")
                                :setAnchorPoint(0.5, 0.5)
                                :addTo(self.mainNode)
    local localContentSize = title_sprite:getContentSize()
    title_sprite:setPosition(cc.p(display.realCx, display.realCy + 300))
    self.maxScore = ScoreNode.new(self.mainNode, "JumpingTheGantry/highest_score_icon.png")
                             :setPosition(cc.p(display.realCx, display.realCy + 100))
    self.maxScore:setString("0")

    self.nowScore = ScoreNode.new(self.mainNode, "JumpingTheGantry/Gameing/now_score_icon.png")
                             :setPosition(cc.p(display.realCx, display.realCy - 50))
    self.nowScore:setString("0")

    local button = ccui.Button:create("JumpingTheGantry/Over/btn_reset_game.png")
                       :setAnchorPoint(cc.p(0.5, 0.5))
                       :setPosition(cc.p(display.realCx, display.realCy - 200))
                       :addTo(self.mainNode)
    button:addClickEventListener(function(sender)
        if (onPlayGame) then
            onPlayGame()
        end
        Sound.onClicked()
    end)
    --self.btn_reset = button
    button = ccui.Button:create("JumpingTheGantry/Over/btn_next_time_player.png")
                 :setAnchorPoint(cc.p(0.5, 0.5))
                 :setPosition(cc.p(display.realCx, display.realCy - 350))
                 :addTo(self.mainNode)

    button:addClickEventListener(function(sender)
        Sound.onClicked()
        if (cbHome) then
            cbHome()
        end
    end)
end

function RestartLayer:showLayout(value)
    value = value or 0
    local historyHighScore = userDefault:getIntegerForKey(RestartLayer.HISTORY_HIGH_SCORE_KEY) or 0
    if value > historyHighScore then
        historyHighScore = value
        userDefault:setIntegerForKey(RestartLayer.HISTORY_HIGH_SCORE_KEY, historyHighScore)
    end
    self.nowScore:setString(value .. "")
    self.maxScore:setString(historyHighScore .. "")
    self:show()
end

RestartLayer.HISTORY_HIGH_SCORE_KEY = "HISTORY_HIGH_SCORE_KEY_TLM"
return RestartLayer