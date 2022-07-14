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
    engine:playMusic("PartyWheel/Sound/BGM.mp3", isLoop)
    print("播放背景音乐")
end

---@field  结果页播放
function Sound.playResult()
    if Sound.pauseFlag then
        return
    end
    engine:stopMusic()
    engine:playEffect("PartyWheel/Sound/result.mp3", false)
end

---@field  结果页停止播放
function Sound.stopResult()
    if Sound.pauseFlag then
        return
    end
    Sound.playBgMusic()
end

---@field 开始旋转的声音
function Sound.playEffectWheelSpin()
    if Sound.pauseFlag then
        return
    end
    Sound.wheel_spin = engine:playEffect("PartyWheel/Sound/wheel_spin.mp3", true)
end

---@field 停止旋转的声音
function Sound.playEffectWheelStop()
    if Sound.wheel_spin then
        engine:stopEffect(Sound.wheel_spin)
        Sound.wheel_spin = nil
    end
    if Sound.pauseFlag then
        return
    end
    engine:playEffect("PartyWheel/Sound/wheel_stop.mp3")
end

function Sound.playGameFailedMusic()
    engine:stopMusic()
    --engine:playMusic("JumpingTheGantry/Sound/on_clicked.mp3")
end

function Sound.onClicked()
    if Sound.pauseFlag then
        return
    end
    printf("播放按钮点击声音")
    Sound.playEffect("PartyWheel/Sound/button.mp3")
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