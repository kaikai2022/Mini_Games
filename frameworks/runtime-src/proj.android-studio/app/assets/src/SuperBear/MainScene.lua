local MiniGameController = require("SuperBear.MiniGameController")
local StartLayer = require("SuperBear.StartLayer")
local RestartLayer = require("SuperBear.RestartLayer")
local Sound = require("SuperBear.Sound")
local MainScene = class("MainScene", function ()return cc.Layer:create() end)

local START_ACCELERATION = 0.4
local FLY_UP_SPEED = 15

local MAX_BLOCK_CNT = 4
local BLOCK_HEIGHT = 135


function MainScene:ctor()
    local rotateNode = cc.Node:create()
    rotateNode:addTo(self)
    rotateNode:setContentSize(cc.size(display.height, display.width))
    rotateNode:setAnchorPoint(cc.p(0.5, 0.5))
    rotateNode:setRotation(-90)
    rotateNode:move(display.cx, display.cy)
    self.rotateNode = rotateNode
    display.realWidth = display.height
    display.realHeight = display.width
    display.realCx = display.cy
    display.realCy = display.cx

    self.gameFlow = MiniGameController:create(self.rotateNode, StartLayer, RestartLayer)
    self.gameFlow:registMsg(MiniGameController.MSG_ON_START, handler(self, self.onStartGame))
    self.gameFlow:registMsg(MiniGameController.MSG_ON_TOUCH_BEGIN, handler(self, self.onTouchBegin))
    self.gameFlow:registMsg(MiniGameController.MSG_GAME_PAUSE, handler(self, self.onGamePause))
    self.gameFlow:registMsg(MiniGameController.MSG_GAME_RESUME, handler(self, self.onGameResume))
    self.gameFlow:registMsg(MiniGameController.MSG_SCENE_INIT_FINISH, handler(self, self.onSceneInit))
    self.gameFlow:registMsg(MiniGameController.MSG_ON_GAME_OVER, handler(self, self.onGameOver))
    self.gameFlow:registMsg(MiniGameController.MSG_ON_HOME, handler(self, self.onHome))
    self.gameFlow:registMsg(MiniGameController.MSG_FRAME_UPDATE, handler(self, self.onFrameUpdate))
    self.gameFlow:start()
    self.gameFlow:delayCall(handler(self, self.setPhysicsWorld), 0.1)

    local listener = cc.EventListenerAcceleration:create(handler(self, self.onAcceleration))
    self:getEventDispatcher():addEventListenerWithSceneGraphPriority(listener, self)
    self:setAccelerometerEnabled(true)
end

function MainScene:onSceneInit()
    self.gameNode = cc.Node:create()
    self.gameNode:addTo(self.rotateNode)
end

function MainScene:onStartGame()
    self.gameNode:removeAllChildren()
    self.gameOverFlag = false
    self:initBall()
    self:initBlock()
end

function MainScene:onTouchBegin(loc)
    if self.gameFlow:isGaming() and self.ballSprite.dropSpeed == 0 then
        self.ballSprite.dropSpeed = -FLY_UP_SPEED
        self.ballAcceleration = START_ACCELERATION
        self.ballSprite:initWithFile("SuperBear/man_jump.png")
        self.ballSprite:setLocalZOrder(1)
        self.ballSprite:setAnchorPoint(cc.p(0.5, 0))
        Sound.playEffect("SuperBear/jump.mp3")
    end
end

function MainScene:onGamePause()
    for _, block in pairs(self.blockList) do
        block:pause()
    end
end

function MainScene:onGameResume()
    for _, block in pairs(self.blockList) do
        block:resume()
    end
end

function MainScene:onGameOver()
end

function MainScene:onHome()
    self.gameNode:removeAllChildren()
end

function MainScene:onFrameUpdate()
    if self.gameFlow:isGaming() then
        self:ballUpdate()
    end
end

function MainScene:gameOver()
    self.gameOverFlag = true
    for _, block in pairs(self.blockList) do
        block:pause()
    end
    self.gameFlow:delayCall(function ()
        self.gameFlow:gameOver()
    end, 1, 1)
end


function MainScene:initBall()
    self.ballSprite = display.newSprite("SuperBear/man_stand.png")
    self.ballSprite:move(display.realCx, 135*2+7)
    self.ballSprite:setLocalZOrder(1)
    self.ballSprite:setAnchorPoint(cc.p(0.5, 0))
    self.ballSprite:addTo(self.gameNode)
    self.ballSprite.dropSpeed = 0
    self.ballAcceleration = 0

    local ballSize = self.ballSprite:getContentSize()
    local body = cc.PhysicsBody:createBox(cc.size(ballSize.width-20, ballSize.height-50))
    body:setCategoryBitmask(1)
    body:setContactTestBitmask(2)
    body:setCollisionBitmask(0)
    body:setGravityEnable(false)
    self.ballSprite.ballBody = body
    self.ballSprite:setPhysicsBody(body)
end

function MainScene:ballUpdate()
    if self.gameOverFlag or (self.ballAcceleration == 0 and self.ballSprite.dropSpeed == 0) then
        return
    end
    local x, y = self.ballSprite:getPosition()
    local upFlag = self.ballSprite.dropSpeed < 0
    self.ballSprite.dropSpeed = self.ballSprite.dropSpeed + self.ballAcceleration
    local newPoxY = y-self.ballSprite.dropSpeed
    local minY = self.showBlockCnt*135+7
    if newPoxY < minY then
        newPoxY = minY
        self.ballAcceleration = 0
        self.ballSprite.dropSpeed = 0
        Sound.playEffect("SuperBear/score.mp3")
        addScore(1)
        self.gameFlow:showScoreTip(x, newPoxY+300)
        self.ballSprite:initWithFile("SuperBear/man_stand.png")
        self.ballSprite:setLocalZOrder(1)
        self.ballSprite:setAnchorPoint(cc.p(0.5, 0))
        if self.showBlockCnt > MAX_BLOCK_CNT then
            local moveDownTime = 0.1
            for _, oneBlock in pairs(self.blockList) do
                local act6 = cc.MoveBy:create(moveDownTime, cc.p(0, -135))
                oneBlock:runAction(act6)
            end
            local act7 = cc.MoveBy:create(moveDownTime, cc.p(0, -135))
            self.ballSprite:runAction(act7)
            self.showBlockCnt = self.showBlockCnt - 1
            self.gameFlow:delayCall(function ()
                self:createOneMoveBlock()
            end, moveDownTime, 1)
        else
            self:createOneMoveBlock()
        end
    end
    if upFlag and self.ballSprite.dropSpeed > 0 then
        self.ballSprite:initWithFile("SuperBear/man_down.png")
        Sound.playEffect("SuperBear/drop.mp3")
        self.ballSprite:setLocalZOrder(1)
        self.ballSprite:setAnchorPoint(cc.p(0.5, 0))
        self.showBlockCnt = self.showBlockCnt + 1
    end
    self.ballSprite:setPositionY(newPoxY)
end

function MainScene:initBlock()
    self.minMoveTime = 0.5
    self.blockList = {}
    self.blockCnt = 0
    self.showBlockCnt = 0
    for i=1, 2 do
        local offsetX = math.random() * 20
        if self.blockCnt % 2 == 0 then
            offsetX = -offsetX
        end
        local block = self:createOneBlock()
        block:move(display.realCx+offsetX, BLOCK_HEIGHT*(i-1))
        self.showBlockCnt = self.showBlockCnt + 1
    end
    self:createOneMoveBlock()
end

function MainScene:createOneMoveBlock()
    local offsetX = math.random() * 20
    if self.blockCnt % 2 == 0 then
        offsetX = -offsetX
    end
    local block = self:createOneBlock()
    block:move(display.realWidth+209+offsetX, BLOCK_HEIGHT*(self.showBlockCnt))

    local time = self.minMoveTime + math.random() * 1
    if self.blockCnt < 7 then
        time = self.minMoveTime + 1
    end
    local act1 = cc.MoveBy:create(time, cc.p(-(display.realCx+209), 0))
    local act2 = cc.CallFunc:create(function ()

    end)
    block:runAction(cc.Sequence:create(act1, act2))
end

function MainScene:createOneBlock()
    local blockType = math.random(1, 12)
    local block = display.newSprite(string.format("SuperBear/block%d.png", blockType))
    block:addTo(self.gameNode)
    block:setAnchorPoint(cc.p(0.5, 0))
    table.insert(self.blockList, block)

    local body = cc.PhysicsBody:createBox(cc.size(421, 100))
    body:setCategoryBitmask(2)
    body:setContactTestBitmask(1)
    body:setCollisionBitmask(0)
    body:setGravityEnable(false)
    block:setPhysicsBody(body)
    self.blockCnt = self.blockCnt + 1
    return block
end

function MainScene:onContactBegin(contact)
    local bodyA = contact:getShapeA():getBody()
    local bodyB = contact:getShapeB():getBody()
    self.ballSprite.ballBody:setVelocity(cc.p(0, -1000))
    self.ballSprite.ballBody:setGravityEnable(true)
    local x, y = self.ballSprite:getPosition()
    local emitter = cc.ParticleSystemQuad:create("SuperBear/water.plist")
    emitter:addTo(self.gameNode)
    emitter:move(x+93, y+93)
    Sound.playEffect("SuperBear/crash.mp3")
    self:gameOver()
end

function MainScene:setPhysicsWorld()
    local scene = cc.Director:getInstance():getRunningScene()
    local world = scene:getPhysicsWorld()
    world:setGravity(cc.p(100, 0))
    --world:setDebugDrawMask(cc.PhysicsWorld.DEBUGDRAW_ALL)

    local contactListener = cc.EventListenerPhysicsContact:create()
    contactListener:registerScriptHandler(handler(self, self.onContactBegin), cc.Handler.EVENT_PHYSICS_CONTACT_BEGIN)
    local eventDispatcher = self:getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(contactListener, self)
end


return MainScene
