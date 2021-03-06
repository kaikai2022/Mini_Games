---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by lucus.
--- DateTime: 14/7/2022 2:53 PM
---

local LevelSelection = class("LevelSelection", function()
    return cc.Node:create()
end)

local IdiomConfig = clone(require("GuessTheIdiom.IdiomConfig"))

local LevelPanel = require("GuessTheIdiom.LevelPanel")
local Sound = require("GuessTheIdiom.Sound")

function LevelSelection:ctor(parent)
    if (parent) then
        self:addTo(parent)
        self:setAnchorPoint(cc.p(0.5, 0.5))
            :setPosition(0, 0)
        --    :setPosition(display.cx, display.cy)
    end
    self.joinGameCallback = self.joinGameCallback or function(leave)
        print(leave)
    end
    local title = display.newSprite("GuessTheIdiom/images/LevelSelection/title.png")
                         :setAnchorPoint(cc.p(0.5, 1))
                         :addTo(self)
                         :setPosition(0, display.cy - 30)
    local titleSize = title:getContentSize()

    local pageButtonNode = cc.Node:create()
                             :addTo(self)

    local leaveText = ccui.TextBMFont:create()
                          :setAnchorPoint(cc.p(0.5, 0.5))
                          :addTo(pageButtonNode)
                          :move(0, 0)

    leaveText:setFntFile("GuessTheIdiom/Fnt/leave_number.fnt")
    leaveText:setString("D1Y")
    self.leaveText = leaveText
    local leaveText_height = 106

    pageButtonNode:setPosition(0, -display.cy + leaveText_height + 20)

    self.contentPageView = ccui.PageView:create()
                               :setContentSize(display.width - 200 * 2, display.height - titleSize.height - 30 * 4 - leaveText_height)
                               :setTouchEnabled(true)
                               :setAnchorPoint(cc.p(0.5, 0.5))
                               :addTo(self)
                               :setPosition(0, 0)
    --self.contentPageView:setBackGroundImageColor(display.COLOR_BLACK)
    --    :setBackGroundColorType(ccui.LayoutBackGroundColorType.solid) --设置颜色
    self.contentPageView:addEventListener(handler(self, self.onEvent))
    local count, index = 0, 0;
    while (count <= #IdiomConfig) do
        local panel = LevelPanel.new(self.contentPageView, index)
        count = count + LevelPanel.lineMax * LevelPanel.lineItemCount
        index = index + 1
        panel:setClickBtnEventListener(function(leave)
            if self.joinGameCallback then
                self.joinGameCallback(leave)
            end
        end)
    end
    self.contentPageView:setCurrentPageIndex(0)
    self:scheduleUpdateWithPriorityLua(handler(self, self._Update), 0)
    self:_UpdateLevelText()

    local leftButton = ccui.Button:create("GuessTheIdiom/images/LevelSelection/level_left.png", "GuessTheIdiom/images/LevelSelection/level_left_rollover.png")
                           :setAnchorPoint(cc.p(0.5, 0.5))
    --:loadTexturePressed("GuessTheIdiom/images/level_left_rollover.png")
                           :addTo(pageButtonNode)
                           :move(-180, -40)
    leftButton:addClickEventListener(function()
        print("上一页")
        Sound.onClicked()
        if (self.contentPageView:getCurrentPageIndex() > 0) then
            self.contentPageView:setCurrentPageIndex(self.contentPageView:getCurrentPageIndex() - 1)
        end
    end)

    local rightButton = ccui.Button:create("GuessTheIdiom/images/LevelSelection/level_right.png", "GuessTheIdiom/images/LevelSelection/level_right_rollover.png")
                            :setAnchorPoint(cc.p(0.5, 0.5))
    --:loadTexturePressed("GuessTheIdiom/images/level_left_rollover.png")
                            :addTo(pageButtonNode)
                            :move(180, -40)
    rightButton:addClickEventListener(function()
        print("下一页")
        Sound.onClicked()
        if (self.contentPageView:getCurrentPageIndex() < index) then
            self.contentPageView:setCurrentPageIndex(self.contentPageView:getCurrentPageIndex() + 1)
        end
    end)

    local backButton = ccui.Button:create("GuessTheIdiom/images/btn_back.png")
                           :setAnchorPoint(0, 0.5)
                           :addTo(self)
                           :move(-display.cx + 80, display.cy - 80)
    backButton:addClickEventListener(function(sender)
        Sound.onClicked()
        if (self.backCallback) then
            self.backCallback()
        end
    end)
end

function LevelSelection:setBackCallback(callback)
    self.backCallback = callback
end

function LevelSelection:_Update(time)
    --print(time)
    if self.nowPageIndex and self.contentPageView and (self.nowPageIndex ~= self.contentPageView:getCurrentPageIndex()) then
        self:_UpdateLevelText()
    end
end

function LevelSelection:_UpdateLevelText()
    self.nowPageIndex = self.contentPageView:getCurrentPageIndex() < 0 and 0 or self.contentPageView:getCurrentPageIndex()
    self.leaveText:setString(string.format("D%sY", self.nowPageIndex + 1))
end

--事件响应方法
function LevelSelection:onEvent(sender, event)
    if event == ccui.PageViewEventType.turning then
        local pageNum = sender:getCurrentPageIndex()
        print("is turning,this PageNum:" .. pageNum)
    end
end

---@public setJoinGameCallback 进入游戏
---@param callback function 进入游戏的回调
function LevelSelection:setJoinGameCallback(callback)
    self.joinGameCallback = callback
end

return LevelSelection