---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by lucus.
--- DateTime: 19/7/2022 2:10 PM
---

local GameScene = class("GameScene", function()
    return cc.Scene:createWithPhysics()
end)
local SoundNode = require("KingKongWar.SoundButtonNode")
local Sound = require("KingKongWar.Sound")

local director = cc.Director:getInstance()

local PlayerBloodNode = require("KingKongWar.PlayerBloodNode")
local PlayerNode = require("KingKongWar.PlayerNode")

local playerMoveConfig = 1
function GameScene:ctor(playerCount)
    local layer = ccui.Layout:create()
    --:setBackGroundColor(display.COLOR_RED)
    --:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid) --设置颜色
                      :addTo(self)
    ccui.ImageView:create("KingKongWar/images/bg.png")
        :setAnchorPoint(0, 0)
        :addTo(layer)

    SoundNode.new()
             :addTo(layer)
             :move(200, display.height - 90)

    self.mainLayer = layer
    self.playerCount = playerCount or 1
    director:pushScene(self)
    self:initPhysicsWorld()


    ---- 材质类型
    --local MATERIAL_DEFAULT = cc.PhysicsMaterial(1, 0, 0)                      -- 密度、碰撞系数、摩擦力
    --
    ---- 球
    --local banana_bom = cc.Sprite:create("KingKongWar/images/gaming/banana_bomb.png")
    --
    ---- 刚体
    --local body = cc.PhysicsBody:createBox(banana_bom:getContentSize(), MATERIAL_DEFAULT)  -- 刚体大小，材质类型
    --
    ---- 设置球的刚体属性
    --banana_bom:setPhysicsBody(body)   -- 设置球的刚体
    --banana_bom:setPosition(display.center)
    --layer:addChild(banana_bom)
    --
    ---- 触摸事件
    --local function onTouchBegan(touch, event)
    --    local location = touch:getLocation()
    --    local arr = self:getPhysicsWorld():getShapes(location)
    --
    --    local body = nil
    --    for _, obj in ipairs(arr) do
    --        if obj:getBody() then
    --            body = obj:getBody()
    --        end
    --    end
    --
    --    if body then
    --        local mouse = cc.Node:create()
    --        local physicsBody = cc.PhysicsBody:create(PHYSICS_INFINITY, PHYSICS_INFINITY)
    --        mouse:setPhysicsBody(physicsBody)
    --        physicsBody:setDynamic(false)
    --        mouse:setPosition(location)
    --        layer:addChild(mouse)
    --        local joint = cc.PhysicsJointPin:construct(physicsBody, body, location)
    --        joint:setMaxForce(5000.0 * body:getMass())
    --        cc.Director:getInstance():getRunningScene():getPhysicsWorld():addJoint(joint)
    --        touch.mouse = mouse
    --
    --        return true
    --    end
    --
    --    return false
    --end
    --
    --local function onTouchMoved(touch, event)
    --    if touch.mouse then
    --        touch.mouse:setPosition(touch:getLocation())
    --    end
    --end
    --
    --local function onTouchEnded(touch, event)
    --    if touch.mouse then
    --        layer:removeChild(touch.mouse)
    --        touch.mouse = nil
    --    end
    --end
    --local touchListener = cc.EventListenerTouchOneByOne:create()
    --touchListener:registerScriptHandler(onTouchBegan, cc.Handler.EVENT_TOUCH_BEGAN)
    --touchListener:registerScriptHandler(onTouchMoved, cc.Handler.EVENT_TOUCH_MOVED)
    --touchListener:registerScriptHandler(onTouchEnded, cc.Handler.EVENT_TOUCH_ENDED)
    --local eventDispatcher = layer:getEventDispatcher()
    --eventDispatcher:addEventListenerWithSceneGraphPriority(touchListener, layer)

    self:initUILayer()

    --self:scheduleUpdateWithPriorityLua(handler(self, self._update), 60)
    self:addNodeEvent()
end

function GameScene:addNodeEvent()
    --场景节点事件处理
    local function onNodeEvent(event)
        if event == "enter" then
            self:_onEnter()
        elseif event == "enterTransitionFinish" then
            self:onEnterTransitionFinish()
        elseif event == "exit" then
            self:onExit()
        elseif event == "exitTransitionStart" then
            self:onExitTransitionStart()
        elseif event == "cleanup" then
            self:cleanup()
        end
    end
    self:registerScriptHandler(onNodeEvent)
end

function GameScene:initPhysicsWorld()
    -- 世界大小
    self.visibleSize = cc.Director:getInstance():getVisibleSize()

    -- 设置物理世界重力
    --local gravity = cc.p(0, -98)
    --self:getPhysicsWorld():setGravity(gravity)

    -- 物理世界显示包围盒
    --self:getPhysicsWorld():setDebugDrawMask(cc.PhysicsWorld.DEBUGDRAW_ALL) -- cc.PhysicsWorld. DEBUGDRAW_ALL 显示包围盒 cc.PhysicsWorld.DEBUGDRAW_NONE 不显示包围盒

    local centerNode = cc.Node:create()
                         :addTo(self)
                         :move(display.cx, display.cy)
    local centerBody = cc.PhysicsBody:createBox({ width = 1, height = display.height })
    centerBody:setCollisionBitmask(0x02)
    centerBody:setDynamic(false)
    --centerBody:setPositionOffset(cc.p(display.cx, display.cy))
    centerNode:setPhysicsBody(centerBody)
    -- 创建物理边框
    local edgeBody = cc.PhysicsBody:createEdgeBox(self.visibleSize, cc.PhysicsMaterial(1, 1, 0), 3)
    local edgeNode = cc.Node:create()
    self:addChild(edgeNode)
    edgeNode:setPosition(self.visibleSize.width * 0.5, self.visibleSize.height * 0.5)
    edgeNode:setPhysicsBody(edgeBody)

    local mapBody = cc.PhysicsBody:createEdgeBox({ width = display.width, height = 0.5 }, cc.PHYSICSBODY_MATERIAL_DEFAULT, 2)
    self.mainLayer:setPhysicsBody(mapBody)
    mapBody:setPositionOffset(cc.p(display.cx, 45))
end

function GameScene:initUILayer()
    local vsSprite = display.newSprite("KingKongWar/images/gaming/vs.png")
                            :setAnchorPoint(0.5, 0.5)
    self.uiLayer = ccui.Layout:create()
                       :setContentSize(display.width, display.height)
    --:setBackGroundColor(display.COLOR_RED)
    --:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid) --设置颜色
                       :addTo(self)
                       :setLocalZOrder(1000)
    local node_blood_bar = cc.Node:create()
                             :addTo(self.uiLayer)
                             :move(display.cx, display.height - 100)
    vsSprite:addTo(node_blood_bar)
            :setLocalZOrder(10)

    display.newSprite("KingKongWar/images/gaming/blood_bar_bg.png")
           :addTo(node_blood_bar)
    self.player1_blood = PlayerBloodNode.new(1)
                                        :addTo(node_blood_bar)
    self.player2_blood = PlayerBloodNode.new(2)
                                        :addTo(node_blood_bar)
    --local testButton = ccui.Button:create("KingKongWar/images/gaming/blood_bar_bg.png")
    --                       :addTo(node_blood_bar)
    --                       :move(0, -100)
    --
    --testButton:addClickEventListener(function()
    --    self.player2_blood:setValue(self.player2_blood.value - 1)
    --end)

    ---@private TouchNodeHeight 按钮离屏幕的Y距离
    local TouchNodeHeight = 80
    ---@private TouchNodeWidth 按钮离屏幕的x距离
    local TouchNodeWidth = 300
    ---@private btn_padding 按钮间的距离
    local btn_padding = 25
    local player1TouchNode = cc.Node:create()
                               :addTo(self.uiLayer)
                               :move(TouchNodeWidth, TouchNodeHeight)
    local player1_left_btn = ccui.Button:create("KingKongWar/images/gaming/btn_player1_left.png")
                                 :setAnchorPoint(1, 0.5)
                                 :addTo(player1TouchNode)
                                 :move(-btn_padding, 0)
    player1_left_btn:addTouchEventListener(function(sender, event)
        if event == 0 then
            if self.player1 then
                self.player1:iconMove(-playerMoveConfig)
            end
        elseif event == 2 then
            if self.player1 then
                self.player1:iconMove(0)
            end
        end
    end)
    local player1_right_btn = ccui.Button:create("KingKongWar/images/gaming/btn_player1_right.png")
                                  :setAnchorPoint(0, 0.5)
                                  :addTo(player1TouchNode)
                                  :move(btn_padding, 0)

    player1_right_btn:addTouchEventListener(function(sender, event)
        if event == 0 then
            if self.player1 then
                self.player1:iconMove(playerMoveConfig)
            end
        elseif event == 2 then
            if self.player1 then
                self.player1:iconMove(0)
            end
        end
    end)

    local player1_up_btn = ccui.Button:create("KingKongWar/images/gaming/btn_player1_right.png")
                               :setAnchorPoint(0, 0.5)
                               :addTo(player1TouchNode)
                               :move(0, 35)
                               :setRotation(-90)
    player1_up_btn:addTouchEventListener(function(sender, event)
        if event == 0 then
            if self.player1 then
                self.player1:iconMoveUp(playerMoveConfig)
            end
        elseif event == 2 then
            if self.player1 then
                self.player1:iconMoveUp(0)
            end
        end
    end)

    local player2TouchNode = cc.Node:create()
                               :addTo(self.uiLayer)
                               :move(display.width - TouchNodeWidth, TouchNodeHeight)
    if self.playerCount == 1 then
        player2TouchNode:hide()
    else
    end
    local player2_left_btn = ccui.Button:create("KingKongWar/images/gaming/btn_player2_left.png")
                                 :setAnchorPoint(1, 0.5)
                                 :addTo(player2TouchNode)
                                 :move(-btn_padding, 0)
    player2_left_btn:addTouchEventListener(function(sender, event)
        if event == 0 then
            if self.player2 then
                self.player2:iconMove(-playerMoveConfig)
            end
        elseif event == 2 then
            if self.player2 then
                self.player2:iconMove(0)
            end
        end
    end)
    local player2_right_btn = ccui.Button:create("KingKongWar/images/gaming/btn_player2_right.png")
                                  :setAnchorPoint(0, 0.5)
                                  :addTo(player2TouchNode)
                                  :move(btn_padding, 0)
    player2_right_btn:addTouchEventListener(function(sender, event)
        if event == 0 then
            if self.player2 then
                self.player2:iconMove(playerMoveConfig)
            end
        elseif event == 2 then
            if self.player2 then
                self.player2:iconMove(0)
            end
        end
    end)

    local player2_up_btn = ccui.Button:create("KingKongWar/images/gaming/btn_player2_right.png")
                               :setAnchorPoint(0, 0.5)
                               :addTo(player2TouchNode)
                               :move(0, 35)
                               :setRotation(-90)
    player2_up_btn:addTouchEventListener(function(sender, event)
        if event == 0 then
            if self.player2 then
                self.player2:iconMoveUp(playerMoveConfig)
            end
        elseif event == 2 then
            if self.player2 then
                self.player2:iconMoveUp(0)
            end
        end
    end)
    self:resetPlayerData()



    --local button = ccui.Button:create("KingKongWar/images/over/btn_reset.png")
    --                   :addTo(self.uiLayer)
    --                   :move(display.width - 300, display.height - 300)
    --                   :setLocalZOrder(100000)
    --button:addClickEventListener(function()
    --    require("KingKongWar.OverScene"):create(1)
    --end)
end

---@public GameScene.resetPlayerData 重置游戏数据
function GameScene:resetPlayerData()
    self.player1_blood:resetValue()
    self.player2_blood:resetValue()
end

function GameScene:_onEnter()
    print("GameScene onEnter")
end

function GameScene:_changePlayer()
    self.isRunPlayer = self.isRunPlayer == 1 and 2 or 1;
    --self[string.format("player%s", self.isRunPlayer)]:setRunState(self.isRunPlayer)
    self.player1:setRunState(self.isRunPlayer)
    self.player2:setRunState(self.isRunPlayer)
end

function GameScene:onEnterTransitionFinish()
    print("GameScene onEnterTransitionFinish")
    self.player1 = PlayerNode.new(1, self.player1_blood, handler(self, self._changePlayer))
    self.player2 = PlayerNode.new(2, self.player2_blood, handler(self, self._changePlayer))
    if self.playerCount == 1 then
        self.player2:setBot(self.player1)

    end
    self:_changePlayer()
    --self.schedule = cc.Director:getInstance():getScheduler():scheduleScriptFunc(function()
    --    self:_changePlayer()
    --end, 15, false)
end

function GameScene:onExit()
    print("GameScene onExit")
    Sound.stopMove()
end

function GameScene:onExitTransitionStart()
    print("GameScene onExitTransitionStart")

end

function GameScene:cleanup()
    print("GameScene cleanup")
end

return GameScene