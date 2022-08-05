---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by lucus.
--- DateTime: 6/7/2022 5:49 PM
---
local SoundButtonNode = class("SoundButtonNode", function()
    return cc.Node:create()
end)

local Sound = require("SoftFudgeCandy.Sound")

local _allButtons = {}

function SoundButtonNode:ctor(part)
    self:setScale((display.width / CC_DESIGN_RESOLUTION.width))
    table.insert(_allButtons, self)
    if (part) then
        self:addTo(part)
    end
    local soundBtn = ccui.Button:create()
    soundBtn:addTo(self)
    --local btnSize = soundBtn:getContentSize()
    ----soundBtn:move(display.realCx + 300, display.realCy + 400)
    --local noSoundSprite = display.newSprite("PartyWheel/sound.png")
    --noSoundSprite:addTo(soundBtn)
    ----noSoundSprite:setVisible(Sound.isPause())
    --noSoundSprite:move(btnSize.width / 2 + 10, btnSize.height / 2)
    soundBtn:addClickEventListener(function(sender)
        local soundPause = Sound.isPause()
        if soundPause then
            Sound.resume()
            --noSoundSprite:setVisible(false)
            for _, v in pairs(_allButtons) do
                v:_changeImage()
            end
        else
            Sound.pause()
            --noSoundSprite:setVisible(true)
            for _, v in pairs(_allButtons) do
                v:_changeImage()
            end
        end
        Sound.onClicked()
    end)
    self.btn = soundBtn
    self:_changeImage()
    self:addNodeEvent()
end

function SoundButtonNode:_changeImage()
    local path = Sound.isPause() and "SoftFudgeCandy/images/start/btn_sound_off.png" or "SoftFudgeCandy/images/start/btn_sound_on.png"
    self.btn:loadTextureNormal(path)
end

function SoundButtonNode:addNodeEvent()
    --场景节点事件处理
    local function onNodeEvent(event)
        if event == "cleanup" then
            print("cleanup")
            for index, v in pairs(_allButtons) do
                if v == self then
                    table.remove(_allButtons, index)
                    return
                end
            end
        end
    end
    self:registerScriptHandler(onNodeEvent)
end
return SoundButtonNode