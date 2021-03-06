---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by lucus.
--- DateTime: 14/7/2022 4:16 PM
---

local LevelPanel = class("LevelPanel", function()
    return ccui.Layout:create()
end)
local Sound = require("GuessTheIdiom.Sound")
local IdiomConfig = require("GuessTheIdiom.IdiomConfig")

LevelPanel.lineMax = 3
LevelPanel.lineItemCount = 8
LevelPanel.buttons = {}
function LevelPanel:ctor(parent, pageIndex)
    self:addTo(parent)
    self.pageIndex = pageIndex or 0
    local parentSize = parent:getContentSize()
    self:setContentSize(parentSize.width, parentSize.height)
    --:setBackGroundImageColor(display.COLOR_RED)
    --:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid) --设置颜色
    local colors = {
        display.COLOR_RED, display.COLOR_BLUE, display.COLOR_GREEN
    }

    for panelIndex = 1, LevelPanel.lineMax do
        ---一排
        local panel = ccui.Layout:create()
        --:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
        --:setBackGroundColor(colors[panelIndex])
        --:setLeftMargin(10):setRightMargin(10)
        --                  :SpacingX(10)

                          :setContentSize(parentSize.width, parentSize.height / 3)
                          :setAnchorPoint(0, 1)
                          :addTo(self)

                          :setPosition(
                0,
                parentSize.height --最上面
                        -
                        ((parentSize.height / LevelPanel.lineMax) * (panelIndex - 1)
                        )
        )
        local panelSize = panel:getContentSize()
        for iconIndex = 1, LevelPanel.lineItemCount do
            local buttonPanel = ccui.Layout:create()
                                    :setAnchorPoint(cc.p(0.5, 0.5))
                                    :setContentSize(panelSize.width / (LevelPanel.lineItemCount), panelSize.height)
                                    :addTo(panel)
            --:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
            --:setBackGroundColor(cc.c3b(math.random(0, 255), math.random(0, 255), math.random(0, 255)))
            local buttonPanelSize = buttonPanel:getContentSize()
            local button = ccui.Button:create("GuessTheIdiom/images/LevelSelection/btn_bg.png")
                               :setAnchorPoint(cc.p(0.5, 0.5))
                               :addTo(buttonPanel)
                               :move(buttonPanelSize.width / 2, buttonPanelSize.height / 2)
            local tag = (panelIndex - 1) * LevelPanel.lineItemCount + iconIndex + (LevelPanel.lineMax * LevelPanel.lineItemCount * self.pageIndex)
            button:setTag(tag)
            local buttonContentSize = button:getContentSize()
            LevelPanel.buttons[tag] = button
            local leaveText = ccui.TextBMFont:create()
                                  :setAnchorPoint(0.5, 0.5)
                                  :addTo(button)
                                  :move(buttonContentSize.width / 2, buttonContentSize.height / 2 + 25)

            leaveText:setFntFile("GuessTheIdiom/Fnt/leave_num.fnt")
            leaveText:setString(tag)
            if (tag > 99) then
                leaveText:setScale(0.7)
                if (tag > #IdiomConfig) then
                    buttonPanel:hide()
                end
            end

            buttonPanel:setPosition(tag * (parentSize.width / LevelPanel.lineItemCount * LevelPanel.lineMax), panel:getContentSize().height / 2)
            local icon = display.newSprite("GuessTheIdiom/images/LevelSelection/not_player_icon.png")
                                :setAnchorPoint(cc.p(0.5, 0.5))
                                :addTo(button)
                                :move(buttonContentSize.width / 2, buttonContentSize.height / 2)

            button:scheduleUpdateWithPriorityLua(function()
                local index = cc.UserDefault:getInstance():getIntegerForKey(require("GuessTheIdiom.UserDefaultKey")) + 1
                if (tag > index) then
                    icon:show()
                    leaveText:hide()
                else
                    icon:hide()
                    leaveText:show()
                end
            end, 0)
            button:addClickEventListener(function()
                Sound.onClicked()
                if (self.callback) then
                    self.callback(tag)
                end
            end)
        end
        panel:setLayoutType(ccui.LayoutType.HORIZONTAL)
        --panel:requestDoLayout()
    end

    --self:scheduleUpdateWithPriorityLua(handler(self, self._Update), 10)
end

---@public addClickBtnEventListener 点击按钮的回调
---@param callback function 回调方法
function LevelPanel:setClickBtnEventListener(callback)
    self.callback = callback
end

return LevelPanel