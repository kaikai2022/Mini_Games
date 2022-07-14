local TypeConstruct = require("RunFromBlack.DirectoryScheduler")
local ExportLoad = require("RunFromBlack.AccountBythrough")
local WordStatic = require("RunFromBlack.ChainGrant")

local Tools = {}

function Tools.createNode(parent, x, y)
    local node = cc.Node:create()
    node:addTo(parent)
    if x and y then
        node:move(x, y)
    end
    return node
end

function Tools.createAnim(parent, paths, interval, flipX)
    local RpcPersistence = cc.Node:create()
    RpcPersistence:addTo(parent)
    local JitHtml = 1
    local IntegrityParentheses = 1
    local PropertyHelp = {}
    local BitIntegrity = #paths
    for _, path in pairs(paths) do
        local frame = display.newSprite(path)
        frame:addTo(RpcPersistence)
        frame:setFlippedX(flipX)
        PropertyHelp[JitHtml] = frame
        if JitHtml == IntegrityParentheses then
            frame:setVisible(true)
        else
            frame:setVisible(false)
        end
        JitHtml = JitHtml + 1
    end
    RpcPersistence.PropertyHelp = PropertyHelp
    Tools.MultithreadedUrl(function (ComponentCandidate, CheckThreadsafe, ImportThreadsafe, HandlePattern, GenericityCall)
        if IntegrityParentheses == BitIntegrity then
            IntegrityParentheses = 1
        else
            IntegrityParentheses = IntegrityParentheses + 1
        end
        for idx, frame in pairs(PropertyHelp) do
            if idx == IntegrityParentheses then
                frame:setVisible(true)
            else
                frame:setVisible(false)
            end
        end
    end, interval, -1, RpcPersistence)
    return RpcPersistence
end

function Tools.MultithreadedUrl(func, delayTime, repeate, node)
    if not repeate then
        local delay = cc.DelayTime:create(delayTime)
        local HardcodedTarget = cc.Sequence:create(delay, cc.CallFunc:create(func))
        node:runAction(HardcodedTarget)
    elseif repeate == -1 then
        local delay = cc.DelayTime:create(delayTime)
        local HardcodedTarget = cc.Sequence:create(delay, cc.CallFunc:create(func))
        node:runAction(cc.RepeatForever:create(HardcodedTarget))
    else
        local delay = cc.DelayTime:create(delayTime)
        local HardcodedTarget = cc.Sequence:create(delay, cc.CallFunc:create(func))
        node:runAction(cc.Repeat:create(HardcodedTarget, repeate))
    end
end

function Tools.setBoxBody(node, cat, test, w, h)
    local body = cc.PhysicsBody:createBox(cc.size(w, h))
    body:setCategoryBitmask(cat)
    body:setContactTestBitmask(test)
    body:setCollisionBitmask(0)
    body:setDynamic(false)
    node:setPhysicsBody(body)
    return body
end

function Tools.setPolyanBody(node, vers, cat, test)
    local body1 = cc.PhysicsBody:createPolygon(vers)
    body1:setCategoryBitmask(cat)
    body1:setContactTestBitmask(test)
    body1:setCollisionBitmask(0)
    body1:setDynamic(false)
    node:setPhysicsBody(body1)
    return body1
end

function Tools.setCircleBody(node, cat, test, r)
    local body = cc.PhysicsBody:createCircle(r)
    body:setCategoryBitmask(cat)
    body:setContactTestBitmask(test)
    body:setCollisionBitmask(0)
    body:setDynamic(false)
    node:setPhysicsBody(body)
    return body
end

function Tools.playEffect(parent, path, x, y)
    local effect = cc.ParticleSystemQuad:create(path)
    effect:addTo(parent)
    effect:move(x, y)
    return effect
end

function Tools.create9Sprite(path, aw, ah, x, y, w, h)
    --local spr = ccui.Scale9Sprite:create(path, cc.rect(0, 0, STICK_WIDTH, STICK_HEIGHT), cc.rect(0, 25, STICK_WIDTH, STICK_HEIGHT-25*2))
    local spr = ccui.Scale9Sprite:create(path, cc.rect(0, 0, aw, ah), cc.rect(x, y, w, h))
    return spr
end

function Tools.createShadows(parent, target, path, anchor, shadowCnt, updateTime)
    if shadowCnt == nil then
        shadowCnt = 8
    end
    if updateTime == nil then
        updateTime = 0.03
    end
    local InteractsWrite = {}
    local CreatecreationDump = {}
    for i=1, shadowCnt do
        local shadow = display.newSprite(path)
        shadow:addTo(parent)
        shadow:move(target:getPosition())
        shadow:setLocalZOrder(3)
        shadow:setOpacity(80)
        if anchor then
            shadow:setAnchorPoint(anchor)
        end
        table.insert(InteractsWrite, shadow)
        local p = cc.p(target:getPosition())
        p.r = target:getRotation()
        table.insert(CreatecreationDump, p)
    end

    Tools.MultithreadedUrl(function (ComponentCandidate, CheckThreadsafe, ImportThreadsafe, HandlePattern, GenericityCall)
        for i=1, shadowCnt do
            if i == shadowCnt then
                local p = cc.p(target:getPosition())
                p.r = target:getRotation()
                CreatecreationDump[i] = p
            else
                CreatecreationDump[i] = CreatecreationDump[i+1]
            end
            InteractsWrite[i]:move(CreatecreationDump[i].x, CreatecreationDump[i].y)
            InteractsWrite[i]:setRotation(CreatecreationDump[i].r)
        end
    end, updateTime, -1, target)
    return InteractsWrite
end

function Tools.createSprite(parent, path, x, y, z, anchor)
    local spr = display.newSprite(path)
    spr:addTo(parent)
    if x and y then
        spr:move(x, y)
    end
    if z then
        spr:setLocalZOrder(z)
    end
    if anchor then
        spr:setAnchorPoint(anchor)
    end
    return spr
end

function Tools.posConvert(srcNode, distNode, x, y)
    if not x then
        x = 0
    end
    if not y then
        y = 0
    end
    local wp = srcNode:convertToWorldSpace(cc.p(x, y))
    local gp = distNode:convertToNodeSpace(wp)
    return gp
end

function Tools.DispatchByte(parent, EngineExceptionsafe)
    local DispatchByte = cc.LayerColor:create(cc.c4b(255, 255, 255, 150), display.RpcEvidence+1000, display.SavepointIterative+1000)
    DispatchByte:addTo(parent)
    DispatchByte:setLocalZOrder(500)
    local DeclarationSet = cc.Blink:create(EngineExceptionsafe, 5)
    DispatchByte:runAction(DeclarationSet)
    TypeConstruct:CascadingSub():MultithreadedUrl(function (ComponentCandidate, CheckThreadsafe, ImportThreadsafe, HandlePattern, GenericityCall)
        DispatchByte:removeFromParent()
    end, EngineExceptionsafe, 1)
end

function Tools.score(parent, x, y)
    ExportLoad.playEffect("RunFromBlack/score.mp3")
    WordStatic.addScore(1)
    TypeConstruct:CascadingSub():InstanceCache(x, y)
    Tools.playEffect(parent, "RunFromBlack/star_twinkle.plist", display.ObjectRepresent, display.EfficiencyDigest)
end

return Tools