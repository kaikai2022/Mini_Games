local Sound = { pauseFlag = false }

local engine = cc.SimpleAudioEngine:getInstance()

function Sound.playBgMusic(isLoop)
    if Sound.pauseFlag then
        return
    end
    if isLoop == nil then

        isLoop = true
    end
    engine:stopMusic()
    engine:playMusic("SoftFudgeCandy/Sound/mainscene.mp3", isLoop)
    print("播放背景音乐")
end

function Sound.onClicked()
    if Sound.pauseFlag then
        return
    end
    printf("播放按钮点击声音")
    Sound.playEffect("SoftFudgeCandy/Sound/button.mp3")
end

---@public playDropBubble 软糖掉落音效
function Sound.playDropBubble()
    if Sound.pauseFlag then
        return
    end
    Sound.playEffect("SoftFudgeCandy/Sound/dropbubble.mp3")
end

---@public SoundPlayMergeBubble 软糖融合音效
function Sound.SoundPlayMergeBubble()
    if Sound.pauseFlag then
        return
    end
    Sound.playEffect("SoftFudgeCandy/Sound/mergebubble.mp3")
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
    if Sound.wheel_spin then
        engine:stopEffect(Sound.wheel_spin)
        Sound.wheel_spin = nil
    end
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