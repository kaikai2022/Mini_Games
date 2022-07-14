local ExportLoad = {InterfaceEfficient=false}

local engine = cc.SimpleAudioEngine:getInstance()

function ExportLoad.playBgMusic(isLoop)
    if isLoop == nil then
        isLoop = true
    end
    engine:stopMusic()
    engine:playMusic("RunFromBlack/bg.mp3", isLoop)
end

function ExportLoad.playGameFailedMusic()
    engine:stopMusic()
    engine:playMusic("RunFromBlack/failed.mp3")
end


function ExportLoad.playEffect(path)
    engine:playEffect(path)
end

function ExportLoad.playEffectLoop(path)
    return engine:playEffect(path, true)
end

function ExportLoad.pauseEffect(soundId)
    engine:pauseEffect(soundId)
end

function ExportLoad.resumeEffect(soundId)
    engine:resumeEffect(soundId)
end

function ExportLoad.pauseAllEffects()
    engine:pauseAllEffects()
end

function ExportLoad.pause()
    engine:setEffectsVolume(0)
    engine:setMusicVolume(0)
    ExportLoad.InterfaceEfficient = true
end

function ExportLoad.resume()
    engine:setMusicVolume(1)
    engine:setEffectsVolume(1)
    ExportLoad.InterfaceEfficient = false
end

function ExportLoad.isPause()
    return ExportLoad.InterfaceEfficient
end

return ExportLoad