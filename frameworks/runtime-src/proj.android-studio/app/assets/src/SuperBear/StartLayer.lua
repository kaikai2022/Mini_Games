local Sound = require("SuperBear.Sound")

local StartLayer = class("StartLayer")

function StartLayer:ctor(parent, onPlayGame)
    self.mainNode = cc.Node:create()
    self.mainNode:setContentSize(cc.size(display.realWidth, display.realHeight))
    self.mainNode:setLocalZOrder(10)
    self.mainNode:addTo(parent)

    local hill = display.newSprite("SuperBear/hill.png")
    hill:addTo(self.mainNode)
    hill:move(display.realCx, display.realCy)

    local logo = display.newSprite("SuperBear/logo.png")
    logo:addTo(self.mainNode)
    logo:move(display.realCx, display.realCy+380)

    local startBtn = ccui.Button:create("SuperBear/btn_start.png")
    startBtn:addTo(self.mainNode)
    startBtn:move(display.realCx, display.realCy)
    startBtn:addClickEventListener(function(sender)
        Sound.playEffect("SuperBear/start.mp3")
        onPlayGame()
    end)

    --local startText = cc.LabelTTF:create("开始", "", 100)
    --startText:setColor(cc.c3b(0, 0, 0))
    --startText:addTo(startBtn)
    --local startBgSize = startBtn:getContentSize()
    --startText:move(startBgSize.width/2, startBgSize.height/2)

    local soundBtn = ccui.Button:create("SuperBear/sound.png")
    soundBtn:addTo(self.mainNode)
    local btnSize = soundBtn:getContentSize()
    soundBtn:move(btnSize.width-30, btnSize.height+120)
    local noSoundSprite = display.newSprite("SuperBear/no_sound.png")
    noSoundSprite:addTo(soundBtn)
    noSoundSprite:setVisible(Sound.isPause())
    noSoundSprite:move(btnSize.width/2, btnSize.height/2)
    soundBtn:addClickEventListener(function (sender)
        local soundPause = Sound.isPause()
        if soundPause then
            Sound.resume()
            noSoundSprite:setVisible(false)
        else
            Sound.pause()
            noSoundSprite:setVisible(true)
        end
    end)
    self.noSoundSprite = noSoundSprite
end

function StartLayer:show()
    self.mainNode:setVisible(true)
    self.noSoundSprite:setVisible(Sound.isPause())
end

function StartLayer:hide()
    self.mainNode:setVisible(false)
end

return StartLayer