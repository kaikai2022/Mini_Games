local Sound = { pauseFlag = false }

local engine = cc.SimpleAudioEngine:getInstance()

function Sound.playBgMusic(isLoop)
    if isLoop == nil then
        isLoop = true
    end
    engine:stopMusic()
    engine:playMusic("GuessTheIdiom/Sound/bg.mp3", isLoop)
end

function Sound.playGameFailedMusic()
    engine:stopMusic()
    engine:playMusic("GuessTheIdiom/Sound/on_clicked.mp3")
end

function Sound.onClicked()
    if Sound.pauseFlag then
        return
    end
    Sound.playEffect("GuessTheIdiom/Sound/on_clicked.mp3")
end

---@public playCorrect 回答正确的声音
function Sound.playCorrect()
    if Sound.pauseFlag then
        return
    end
    Sound.playEffect("GuessTheIdiom/Sound/correct.mp3")
end

---@public playWrong 回答错误的声音
function Sound.playWrong()
    if Sound.pauseFlag then
        return
    end
    Sound.playEffect("GuessTheIdiom/Sound/wrong.mp3")
end

function Sound.playEffect(path)
    engine:playEffect(path)
end

function Sound.playEffectLoop(path)
    return engine:playEffect(path, true)
end

function Sound.pauseEffect(soundId)
    engine:pauseEffect(soundId)
end

function Sound.resumeEffect(soundId)
    engine:resumeEffect(soundId)
end

function Sound.pause()
    engine:setEffectsVolume(0)
    engine:setMusicVolume(0)
    Sound.pauseFlag = true
end

function Sound.resume()
    engine:setMusicVolume(1)
    engine:setEffectsVolume(1)
    Sound.pauseFlag = false
end

function Sound.isPause()
    return Sound.pauseFlag
end

return Sound