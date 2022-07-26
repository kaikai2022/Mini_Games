---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by lucus.
--- DateTime: 25/7/2022 11:13 AM
---
---@class BotPlayer 电脑人
local BotPlayer = class("BotPlayer", cc.Node)

---@public ctor 构造方法
---@param player PlayerNode player玩家
---@param enemyPlayer PlayerNode 敌人玩家 
function BotPlayer:ctor(player, enemyPlayer)
    self:addTo(player)
    self.player = player
    self.enemyPlayer = enemyPlayer
    self.oldState = {
        blood = enemyPlayer.player_blood.value
    }
    self:scheduleUpdateWithPriorityLua(handler(self, self._Update), 0)
end

local runTime = 0
local nowTime = 0.1
local isRuing = false
local playerMoveConfig = 0 -- math.random(-1, 2)
function BotPlayer:_Update(timer)
    if not self.player then
        return
    end

    if not self.player:getIsRunState() then
        --print("当前行动的不是自己")
        return
    end

    local nowState = {
        blood = self.enemyPlayer.player_blood.value
    }
    --上回合收到了伤害
    if self.oldState.blood > nowState.blood then
        print("受到了伤害")
        if not isRuing then
            runTime = math.random(2, 5)
            while playerMoveConfig == 0 do
                playerMoveConfig = math.random(-1, 1)
            end
            nowTime = 0
            local playerIcon = self.player:getChildByName("PlayerIcon")
            local enemyPlayerIcon = self.enemyPlayer:getChildByName("PlayerIcon")
            local playerIconWorldPos = playerIcon:getParent():convertToWorldSpace(cc.p(playerIcon:getPosition()))
            local enemyPlayerIconWorldPos = enemyPlayerIcon:getParent():convertToWorldSpace(cc.p(enemyPlayerIcon:getPosition()))
            self.player:setTouchStartPosition(0, math.abs(playerIconWorldPos.x - enemyPlayerIconWorldPos.x))
            self.player:setTouchMovePosition(math.random(20, 81))
            isRuing = true
        end
        self.player:iconMoveUp(math.abs(playerMoveConfig))
    else
        if not isRuing then
            runTime = math.random(0, 5)
            playerMoveConfig = math.random(-1, 1)
            nowTime = 0
            local playerIcon = self.player:getChildByName("PlayerIcon")
            local enemyPlayerIcon = self.enemyPlayer:getChildByName("PlayerIcon")
            local playerIconWorldPos = playerIcon:getParent():convertToWorldSpace(cc.p(playerIcon:getPosition()))
            local enemyPlayerIconWorldPos = enemyPlayerIcon:getParent():convertToWorldSpace(cc.p(enemyPlayerIcon:getPosition()))
            self.player:setTouchStartPosition(0, math.abs(playerIconWorldPos.x - enemyPlayerIconWorldPos.x))
            self.player:setTouchMovePosition(math.random(20, 81))
            isRuing = true
        end
    end
    print(playerMoveConfig)
    self.player:iconMove(playerMoveConfig)
    nowTime = nowTime + timer

    if nowTime >= runTime then
        if isRuing then
            playerMoveConfig = 0
            self.player:throwBombs()
            self.player:iconMove(0)
            self.player:iconMoveUp(0)
            self.player:setRunState(nil)
            isRuing = false
            if self.oldState.blood > nowState.blood then
                self.oldState.blood = nowState.blood
            end
        end
        return
    end
end

return BotPlayer