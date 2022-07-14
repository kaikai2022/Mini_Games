local Sound = require("JumpingTheGantry.Sound")
local SoundBtn = require("JumpingTheGantry.SoundButtonNode")

local StartLayer = class("StartLayer")
local LOCAL_SCALE = 0.8
local userDefault = cc.UserDefault:getInstance()
local RestartLayer = require("JumpingTheGantry.RestartLayer")

function StartLayer:ctor(parent, onPlayGame)
    self.mainNode = cc.Node:create()
    self.mainNode:setContentSize(cc.size(display.realWidth, display.realHeight))
    self.mainNode:setLocalZOrder(10)
    self.mainNode:addTo(parent)

    --local hill = display.newSprite("SuperBear/hill.png")
    --hill:addTo(self.mainNode)
    --hill:move(display.realCx, display.realCy)

    local logo = display.newSprite("JumpingTheGantry/logo.png")
    logo:addTo(self.mainNode)
    logo:move(display.realCx, display.realCy + 180)
        :setScale(LOCAL_SCALE)

    local startBtn = ccui.Button:create("JumpingTheGantry/btn_start.png")
    startBtn:addTo(self.mainNode)
    startBtn:move(display.realCx, display.realCy - 320):setScale(0.8)

    startBtn:addClickEventListener(function(sender)
        Sound.onClicked()
        onPlayGame()
    end)


    --local startText = cc.LabelTTF:create("开始", "", 100)
    --startText:setColor(cc.c3b(0, 0, 0))
    --startText:addTo(startBtn)
    --local startBgSize = startBtn:getContentSize()
    --startText:move(startBgSize.width/2, startBgSize.height/2)

    --local soundBtn = ccui.Button:create("JumpingTheGantry/sound.png")
    --soundBtn:addTo(self.mainNode)
    --soundBtn:setScale(LOCAL_SCALE)
    --local btnSize = soundBtn:getContentSize()
    --soundBtn:move(display.realCx + 300, display.realCy + 400)
    --local noSoundSprite = display.newSprite("JumpingTheGantry/no_sound.png")
    --noSoundSprite:addTo(soundBtn)
    ----noSoundSprite:setVisible(Sound.isPause())
    --noSoundSprite:move(btnSize.width / 2 - 10, btnSize.height / 2)
    --soundBtn:addClickEventListener(function(sender)
    --    local soundPause = Sound.isPause()
    --    if soundPause then
    --        Sound.resume()
    --        noSoundSprite:setVisible(false)
    --    else
    --        Sound.pause()
    --        noSoundSprite:setVisible(true)
    --    end
    --    Sound.onClicked()
    --end)
    --self.noSoundSprite = noSoundSprite

    local soundBtn = SoundBtn.new(self.mainNode)
    soundBtn:setScale(LOCAL_SCALE)
    soundBtn:move(display.realCx + 300, display.realCy + 400)

    local highestScore = display.newSprite("JumpingTheGantry/highest_score_bg.png")
                                :addTo(self.mainNode)
                                :setScale(LOCAL_SCALE)
    local highestScoreBgSize = highestScore:getContentSize()
    highestScore:move(highestScoreBgSize.width, highestScore:getContentSize().height / 2)
    local score_icon = display.newSprite("JumpingTheGantry/highest_score_icon.png")
    score_icon:addTo(highestScore)
    score_icon:setScale(LOCAL_SCALE)
    score_icon:move(65, highestScore:getContentSize().height / 2)

    local contentScorePanel = cc.Node:create()
    contentScorePanel:setContentSize(
            cc.size(highestScoreBgSize.width - score_icon:getContentSize().width - 65 * 2, highestScoreBgSize.height - 50 * 2))
    contentScorePanel:addTo(highestScore)
    contentScorePanel:move(highestScoreBgSize.width / 2 + 65, highestScoreBgSize.height / 2)
    display.newSprite("JumpingTheGantry/highest_score_str.png")
           :addTo(contentScorePanel)
           :setScale(LOCAL_SCALE)
           :move(0, contentScorePanel:getContentSize().height / 2)
    --display.newSprite("JumpingTheGantry/highest_score_str.png")
    --       :addTo(highestScore)
    --       :setScale(LOCAL_SCALE)
    --       :move(highestScore:getContentSize().width - 100, highestScore:getContentSize().height - 35)
    self.highestScore = ccui.TextBMFont:create()
    --:pos()
                            :setScale(LOCAL_SCALE)
                            :addTo(contentScorePanel)
                            :move(0, -contentScorePanel:getContentSize().height / 2)

    self.highestScore:setFntFile("JumpingTheGantry/Gameing/now_score.fnt")
    self:show()
end

function StartLayer:show()
    self.mainNode:setVisible(true)
    local historyHighScore = userDefault:getIntegerForKey(RestartLayer.HISTORY_HIGH_SCORE_KEY) or 0
    self.highestScore:setString(historyHighScore)
end

function StartLayer:hide()
    self.mainNode:setVisible(false)
end

function StartLayer:setScore(number)
    self.highestScore:setString(number)
end

return StartLayer