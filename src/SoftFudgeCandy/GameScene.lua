---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by lucus.
--- DateTime: 4/8/2022 3:46 PM
---

local GameScene = class("GameScene", function()
    return cc.Scene:createWithPhysics()
end)

local CandyNode = require("SoftFudgeCandy.CandyNode")
local newCandyNode
function GameScene:ctor()
    local rotateNode = cc.Node:create()
    rotateNode:addTo(self)
    rotateNode:setContentSize(cc.size(display.height, display.width))
    rotateNode:setAnchorPoint(cc.p(0.5, 0.5))
    rotateNode:setRotation(-90)
    rotateNode:move(display.cx, display.cy)
    self.rotateNode = rotateNode

    self.bg = ccui.ImageView:create("SoftFudgeCandy/images/game/bg.png")
                  :setContentSize(display.realWidth, display.realHeight)
                  :setScale9Enabled(true)
                  :setCapInsets({ x = 135, y = 135, width = 390, height = 750 })
                  :setAnchorPoint(0.5, 0.5)
                  :addTo(self.rotateNode)
                  :move(display.realCx, display.realCy)

    self:InitPhysicsWord()

    --newCandyNode = function()
    --    CandyNode:create()
    --             :addTo(self.bg)
    --             :move(math.random(90, display.realWidth - 90), display.realHeight - 75)
    --             :addClickEventListener(function()
    --        newCandyNode()
    --    end)
    --end
    --newCandyNode()

    --self:TestPhysics()
    --self:TestPhysics()
    --self:TestPhysics()
    --self:TestPhysics()
    --self:TestPhysics()
    --self:TestPhysics()
end

---@private 初始化物理世界
function GameScene:InitPhysicsWord()
    --self:getPhysicsWorld():setDebugDrawMask(cc.PhysicsWorld.DEBUGDRAW_ALL) -- cc.PhysicsWorld. DEBUGDRAW_ALL 显示包围盒 cc.PhysicsWorld.DEBUGDRAW_NONE 不显示包围盒

    local gravity = cc.p(98, 0)
    self:getPhysicsWorld():setGravity(gravity)

    local edgeBox = cc.PhysicsBody:createEdgeBox({
        width = display.realWidth - 90 * 2, height = display.realHeight,
    }, cc.PHYSICSBODY_MATERIAL_DEFAULT, 2)
    edgeBox:setPositionOffset(cc.p(-75, 0))
    self.bg:setPhysicsBody(edgeBox)

    local tempEdgeBox = cc.PhysicsShapeEdgeBox:create({
        width = (display.realWidth - 90 * 2), height = display.realHeight * 0.32,
    }, cc.PHYSICSBODY_MATERIAL_DEFAULT, 2
    )
    tempEdgeBox:setTag(2)
    edgeBox:addShape(tempEdgeBox)

    CandyNode.setParent(self.bg)
    for index = 0, 50 do
        CandyNode:create()
    end
    local delayDoSomething = function(callback, time)
        local handle
        handle = cc.Director:getInstance():getScheduler():scheduleScriptFunc(function()
            cc.Director:getInstance():getScheduler():unscheduleScriptEntry(handle)
            callback()
        end, time, false)

        return handle
    end
    delayDoSomething(function()
        edgeBox:removeShape(2,true)
    end, 0.2)
end

function GameScene:TestPhysics()
    ---- 材质类型
    --local MATERIAL_DEFAULT = cc.PhysicsMaterial(100, 0, 0.9)                      -- 密度、碰撞系数、摩擦力
    --
    ---- 球
    --local banana_bom = cc.Sprite:create("SoftFudgeCandy/images/game/Candys/1.png")
    --
    ---- 刚体
    --local body = cc.PhysicsBody:createCircle(banana_bom:getContentSize().width * 0.5, MATERIAL_DEFAULT)  -- 刚体大小，材质类型
    --
    ---- 设置球的刚体属性
    --banana_bom:setPhysicsBody(body)   -- 设置球的刚体
    --self.bg:addChild(banana_bom)
    --banana_bom:move(display.realCx, display.realCy)

    -- 触摸事件
    local function onTouchBegan(touch, event)
        local location = touch:getLocation()
        local arr = self:getPhysicsWorld():getShapes(location)

        local body = nil
        for _, obj in ipairs(arr) do
            if obj:getBody() then
                body = obj:getBody()
            end
        end

        if body then
            local mouse = cc.Node:create()
            local physicsBody = cc.PhysicsBody:create(PHYSICS_INFINITY, PHYSICS_INFINITY)
            mouse:setPhysicsBody(physicsBody)
            physicsBody:setDynamic(false)
            mouse:setPosition(location)
            self.bg:addChild(mouse)
            local joint = cc.PhysicsJointPin:construct(physicsBody, body, location)
            joint:setMaxForce(5000.0 * body:getMass())
            cc.Director:getInstance():getRunningScene():getPhysicsWorld():addJoint(joint)
            touch.mouse = mouse

            return true
        end

        return false
    end

    local function onTouchMoved(touch, event)
        if touch.mouse then
            touch.mouse:setPosition(touch:getLocation())
        end
    end

    local function onTouchEnded(touch, event)
        if touch.mouse then
            self.bg:removeChild(touch.mouse)
            touch.mouse = nil
        end
    end
    local touchListener = cc.EventListenerTouchOneByOne:create()
    touchListener:registerScriptHandler(onTouchBegan, cc.Handler.EVENT_TOUCH_BEGAN)
    touchListener:registerScriptHandler(onTouchMoved, cc.Handler.EVENT_TOUCH_MOVED)
    touchListener:registerScriptHandler(onTouchEnded, cc.Handler.EVENT_TOUCH_ENDED)
    local eventDispatcher = self.bg:getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(touchListener, self.bg)
end

return GameScene