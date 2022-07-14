local Sound = require("SuperBear.Sound")
local ImageNumber = require("SuperBear.ImageNumber")
local RestartLayer = class("RestartLayer")

function RestartLayer:ctor(parent, onPlayGame, cbHome)
    self.mainNode = cc.Node:create()
    self.mainNode:setContentSize(cc.size(display.realWidth, display.realHeight))
    self.mainNode:setLocalZOrder(10)
    self.mainNode:addTo(parent)

    local mask = display.newSprite("SuperBear/mask.png")
    mask:addTo(self.mainNode)
    local size = mask:getContentSize()
    mask:setScaleX(display.realWidth/size.width)
    mask:setScaleY(display.realHeight/size.height)
    mask:move(display.realCx, display.realCy)

    local logo = display.newSprite("SuperBear/logo.png")
    logo:addTo(self.mainNode)
    logo:move(display.realCx, display.realCy+400)

    local scoreLayer = cc.Node:create()
    scoreLayer:addTo(self.mainNode)
    scoreLayer:move(display.realCx, display.realCy+10)

    local scoreBg = display.newSprite("SuperBear/cur_score.png")
    scoreBg:addTo(scoreLayer)

    self.scoreText = ImageNumber:create(scoreLayer, 0, -70, 0)

    local highScoreLayer = cc.Node:create()
    highScoreLayer:addTo(self.mainNode)
    highScoreLayer:move(display.realCx, display.realCy+210)

    local highScoreBg = display.newSprite("SuperBear/top_score.png")
    highScoreBg:addTo(highScoreLayer)

    self.highScoreText = ImageNumber:create(highScoreLayer, 0, -70, 0)

    local startBtn = ccui.Button:create("SuperBear/btn_replay.png")
    startBtn:addTo(self.mainNode)
    startBtn:move(display.realCx, display.realCy-230)
    startBtn:addClickEventListener(function(sender)
        Sound.playEffect("SuperBear/start.mp3")
        onPlayGame()
    end)

    local homeBtn = ccui.Button:create("SuperBear/home.png")
    homeBtn:addTo(self.mainNode)
    homeBtn:move(100, display.realHeight-100)
    homeBtn:addClickEventListener(function(sender)
        cbHome()
    end)

    local soundBtn = ccui.Button:create("SuperBear/sound.png")
    soundBtn:addTo(self.mainNode)
    local btnSize = soundBtn:getContentSize()
    soundBtn:move(btnSize.width, btnSize.height)
    local noSoundSprite = display.newSprite("SuperBear/no_sound.png")
    noSoundSprite:addTo(soundBtn)
    noSoundSprite:setVisible(Sound.isPause())
    noSoundSprite:move(btnSize.width/2, btnSize.height/2+8)
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

function RestartLayer:show()
    self.mainNode:setVisible(true)
    self.noSoundSprite:setVisible(Sound.isPause())
end

function RestartLayer:hide()
    self.mainNode:setVisible(false)
end

function RestartLayer:setScore(score, highScore)
    self.scoreText:setNumber(score)
    self.highScoreText:setNumber(highScore)

end

return RestartLayer