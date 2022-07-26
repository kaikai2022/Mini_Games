---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by lucus.
--- DateTime: 19/7/2022 7:16 PM
---

---@class PlayerNode 玩家对象
local PlayerNode = class("PlayerNode", function()
    return ccui.Layout:create()
end)
local Sound = require("KingKongWar.Sound")

local NodeMap = require("KingKongWar.NodeMap")

local PlayerArrowNode = require("KingKongWar.PlayerArrowNode")

local NodeBanana = require("KingKongWar.NodeBanana")

local BotNode = require("KingKongWar.BotPlayer")
local director = cc.Director:getInstance()
local colors = {
    display.COLOR_BLUE,
    display.COLOR_RED,
}

function PlayerNode:ctor(player, player_blood, callback)
    --self:setBackGroundColor(colors[player])
    --    :setBackGroundColorType(ccui.LayoutBackGroundColorType.solid) --设置颜色
    self.runTimerTextCallback = callback

    self.player = player or 1
    self.player_blood = player_blood
    self.width = display.width / 2
    self:setContentSize(self.width, display.height)
    local scene = director:getRunningScene()
    self:addTo(scene)
    self:setName("Player" .. self.player)
    self:setAnchorPoint(0, 0)
    self:move((self.player == 1) and 0 or display.cx, 45)
    self:setLocalZOrder(500)
    self:_createMap()

    local player_icon = display.newSprite(string.format("KingKongWar/images/gaming/icon_player%s.png", self.player))
                               :setAnchorPoint(0.5, 0)
                               :addTo(self)
                               :setTag(10)
                               :setName("PlayerIcon")
    if (self.player ~= 1) then
        player_icon:setScaleX(-1)
    end
    local player_icon_size = player_icon:getContentSize()
    player_icon:move(self.player ~= 1 and self.width - player_icon_size.width or player_icon_size.width, display.cy + player_icon_size.height)
    local offsetY = 20
    local player_icon_body = cc.PhysicsBody:createBox({ width = player_icon_size.width / 2, height = player_icon_size.height - offsetY },
            { density = 10, restitution = 0, friction = 10 })
    player_icon_body:setPositionOffset(cc.p(0, -offsetY / 2))
    player_icon:setPhysicsBody(player_icon_body)
    player_icon_body:setRotationEnable(false)
    player_icon_body:setCategoryBitmask(0x02) --00 00 10 group
    player_icon_body:setContactTestBitmask(0x01)

    --player_icon_body:setContactTestBitmask(0x02)
    --player_icon_body:setVelocity({ x = 10, 0 })
    --player_icon_body:setDynamic(false)
    --                :setGravityEnable(true)
    --                :setMass(100)
                    :applyForce({ x = 0, y = -100000 })
    --:addMass(10000)
    player_icon:scheduleUpdateWithPriorityLua(handler(self, self._moveUpdate), 60)
    self.player_icon = player_icon
    self.player_icon_size = player_icon_size

    local runTimerText = ccui.Text:create()
                             :setAnchorPoint(0.5, 1)
    if (self.player ~= 1) then
        runTimerText:setScaleX(-1)
    end
    runTimerText:addTo(player_icon)
    runTimerText:move(player_icon_size.width / 2, player_icon_size.height + 10)
    runTimerText:hide()
    self.runTimerText = runTimerText
    self.runTimerTextValue = 0
    self.runTimerText:setString(self.runTimerTextValue)
    --self.schedule = cc.Director:getInstance():getScheduler():scheduleScriptFunc(function()
    --    
    --end, 1, false)

    local delay = cc.DelayTime:create(1)
    local sequence = cc.Sequence:create(delay, cc.CallFunc:create(function()
        if self.runTimerTextValue <= 0 then
            return
        end
        self.runTimerTextValue = self.runTimerTextValue - 1
        --if self.runTimerTextValue <= 0 and (self.runTimerTextCallback) then
        --    self.runTimerText:hide()
        --    self.runTimerTextCallback()
        --end
        self.runTimerText:setString(self.runTimerTextValue)
        self:_runDelayTime()
    end))
    local action = cc.RepeatForever:create(sequence)
    self:runAction(action)


    --self:setTouchEnabled(true)

    --self.touchPos = nil
    --self:addTouchEventListener(function(sender, event)
    --    if (event == 0) then
    --        self.player_icon:setTexture(string.format("KingKongWar/images/gaming/icon_player%s_read.png", self.player))
    --    elseif (event == 2) then
    --        self.player_icon:setTexture(string.format("KingKongWar/images/gaming/icon_player%s.png", self.player))
    --    end
    --    print(sender)
    --end, 0)

    --self:onTouchBegan(function(sender)
    --    print("onTouchBegan" .. sender)
    --end)
    --
    --self:onTouchMoved(function(sender)
    --    print("onTouchMoved" .. sender)
    --end)
    --
    --self:onTouchEnded(function(sender)
    --    print("onTouchEnded" .. sender)
    --end)

    local listener = cc.EventListenerTouchOneByOne:create()
    ----listener:setSwallowTouches(true)
    listener:registerScriptHandler(handler(self, self._TouchBegan), cc.Handler.EVENT_TOUCH_BEGAN);
    listener:registerScriptHandler(handler(self, self._TouchMove), cc.Handler.EVENT_TOUCH_MOVED);
    listener:registerScriptHandler(handler(self, self._TouchEnded), cc.Handler.EVENT_TOUCH_ENDED);
    listener:registerScriptHandler(handler(self, self._TouchEnded), cc.Handler.EVENT_TOUCH_CANCELLED)
    self.listener = listener
    self:getEventDispatcher():addEventListenerWithSceneGraphPriority(listener, self);

    self:registerScriptHandler(function(event)
        if event == "enter" then
            print("enter")
        elseif event == "enterTransitionFinish" then
            print("enterTransitionFinish")

        elseif event == "exit" then
            print("exit")

        elseif event == "exitTransitionStart" then
            print("exitTransitionStart")
        elseif event == "cleanup" then
            print("cleanup")
        end
    end)
    --self:addTouchEventListener

    --self:onTouch(function(event)
    --    --print(type(touch), type(event), type(other))
    --    dump(event)
    --    --print(tolua.type(touch))
    --    --print(event)
    --    if (event.name == "began") then
    --        self:_TouchBegan()
    --        dump(event.target:getTouchBeganPosition())
    --    elseif event.name == "moved" then
    --        self:_TouchMove()
    --        --dump(event.target:getTouchPosition())
    --        
    --    else
    --        self:_TouchEnded()
    --        --dump(event.target:getTouchBeganPosition())
    --    end
    --end, 1)

    --self:onTouchMoved()
end

function PlayerNode:_runDelayTime()
    if self.runTimerTextValue <= 0 and (self.runTimerTextCallback) then
        self.runTimerText:hide()
        self.runTimerTextCallback()
    end
end

---@public 玩家
function PlayerNode:setBot(enemyPlayer)
    self.bot = BotNode.new(self, enemyPlayer)
end

---@private _createMap 创建地图
function PlayerNode:_createMap()
    local width = self.player == 1 and 0 or self.width
    local nowWidthIndex = 0
    while nowWidthIndex < 10 do
        --for v, config in ipairs(NodeMap.config) do
        --math.randomseed(tostring(os.time()):reverse():sub(1, 6))
        local index = math.random(1, #NodeMap.config)
        local config = NodeMap.config[index]
        local map = NodeMap.new(index)
        map:setAnchorPoint(self.player == 1 and 0 or 1, 0)
           :addTo(self)
        map:move(width, 0)
        width = width + map:getContentSize().width * (self.player == 1 and 1 or -1)
        nowWidthIndex = nowWidthIndex + map.config.width
    end
end

---@public iconMove 玩家物体移动
function PlayerNode:iconMove(value)
    --self.player_icon_body:setVelocity({ x = value, 0 })
    --self.player_icon:setPositionX(self.player_icon:getPositionX() + value)
    --self.player_icon:
    self.lf_rt = value
    if (value ~= 0) then
        Sound.playMove()
    else
        Sound.stopMove()
    end
end

function PlayerNode:_moveUpdate(timer)
    if (self.lf_rt and self.lf_rt ~= 0) then
        if self.nowPositionX ~= self.player_icon:getPositionX() then
            print("没有移动")
            self.up = 2
        end
        self.nowPositionX = self.player_icon:getPositionX() + self.lf_rt
        self.player_icon:setPositionX(self.nowPositionX)
    end
    if (self.up and self.up ~= 0) then
        self.player_icon:getPhysicsBody():setGravityEnable(false)
        self.player_icon:setPositionY(self.player_icon:getPositionY() + self.up)
    else
        self.player_icon:getPhysicsBody():setGravityEnable(true)
    end
    self.up = 0
end

function PlayerNode:_TouchBegan(touch, event)
    if self.bot then
        return
    end
    if self.isRun ~= self.player then
        return false
    end

    local locationPos = touch:getLocation()
    self:setTouchStartPosition(locationPos.y)
    return true
end

function PlayerNode:_TouchMove(touch, event)
    if self.bot then
        return
    end
    if self.isRun ~= self.player then
        return
    end
    local locationPos = touch:getLocation()
    --self.playerArrowNode:setTouchPosition(locationPos.y)
    self:setTouchMovePosition(locationPos.y)
end

---投掷香蕉炸弹时的开始位置Value
function PlayerNode:setTouchStartPosition(value, distance)
    self.player_icon:setTexture(string.format("KingKongWar/images/gaming/icon_player%s_read.png", self.player))
    self.playerArrowNode = PlayerArrowNode.new(distance)
    self.playerArrowNode:addTo(self.player_icon)
        :move(self.player_icon_size.width + 10, self.player_icon_size.height / 2)
    self.playerArrowNode:setStartTouchPosition(value)
end

---投掷香蕉炸弹时的移动位置Value
function PlayerNode:setTouchMovePosition(value)
    if self.playerArrowNode then
        self.playerArrowNode:setTouchPosition(value)
    end
end

---@public throwBombs 投掷炸弹
function PlayerNode:throwBombs()
    if self.playerArrowNode then
        self.runTimerTextValue = 0
        NodeBanana.new(self.playerArrowNode, self)
        self.playerArrowNode = nil
        self:_runDelayTime()
    end
    self.player_icon:setTexture(string.format("KingKongWar/images/gaming/icon_player%s.png", self.player))
end

function PlayerNode:_TouchEnded(touch, event)
    if self.bot then
        return
    end
    if self.isRun ~= self.player then
        return
    end
    self:throwBombs()
end

function PlayerNode:setRunState(isSelf)
    self.isRun = isSelf
    if self.isRun == self.player then
        self.runTimerTextValue = 15
        self.runTimerText:setString(self.runTimerTextValue)
        self.runTimerText:show()
    else
        if self.playerArrowNode then
            self.playerArrowNode:removeSelf()
            self.player_icon:setTexture(string.format("KingKongWar/images/gaming/icon_player%s.png", self.player))
            self.playerArrowNode = nil
        end
    end
end

---@public getIsRunState 此时是否是自己增在行动中
function PlayerNode:getIsRunState()
    return self.isRun == self.player
end

return PlayerNode