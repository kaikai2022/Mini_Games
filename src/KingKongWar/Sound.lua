local Sound = { pauseFlag = false }

local engine = cc.SimpleAudioEngine:getInstance()

local nowMoveEffect
function Sound.playBgMusic(isLoop)
    if isLoop == nil then
        isLoop = true
    end
    engine:stopMusic()
    engine:playMusic("KingKongWar/sound/bg.wav", isLoop)
end

function Sound.playMove()
    
    if not nowMoveEffect then
        if Sound.pauseFlag then
            return
        end
        nowMoveEffect = engine:playEffect("KingKongWar/sound/monkey_move.wav", true)
        print("开始播放移动声音")
    end
end

function Sound.stopMove()
    if nowMoveEffect then
        print("停止播放移动声音")
        engine:stopEffect(nowMoveEffect)
        nowMoveEffect = nil
    end
end

function Sound.playGameFailedMusic()
    engine:stopMusic()
    if Sound.pauseFlag then
        return
    end
    engine:playMusic("KingKongWar/sound/game_over.flac")
end

function Sound.onClicked()
    if Sound.pauseFlag then
        return
    end
    Sound.playEffect("JumpingTheGantry/Sound/on_clicked.mp3")
end

function Sound.playBoom()
    if Sound.pauseFlag then
        return
    end
    Sound.playEffect("KingKongWar/sound/boom.flac")
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