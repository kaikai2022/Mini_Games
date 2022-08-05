---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by lucus.
--- DateTime: 4/8/2022 4:38 PM
---

local CandyNode = class("CandyNode", cc.Node)
---@private MaxId 最大的糖果等级
CandyNode.MaxId = 11
local MATERIAL_DEFAULT = cc.PhysicsMaterial(100, 0, 0.5)                      -- 密度、碰撞系数、摩擦力
function CandyNode.setParent(parent)
    CandyNode.parent = parent
end


-- 延时调用
-- @params callback(function) 回调函数
-- @params time(float) 延时时间(s)
-- @return 定时器
local delayDoSomething = function(callback, time)
    local handle
    handle = cc.Director:getInstance():getScheduler():scheduleScriptFunc(function()
        cc.Director:getInstance():getScheduler():unscheduleScriptEntry(handle)
        callback()
    end, time, false)

    return handle
end

---@private table_deduplicate_add table去重添加
---@param table_ table 需要添加的table
---@param item data 数据
local table_deduplicate_add = function(table_, item)
    local merge = true
    for _, temp_v2 in pairs(table_) do
        if item == temp_v2 then
            merge = false
            break
        end
    end
    if merge then
        table.insert(table_, item)
    end
end

---@private table_merge table合并
---@param ... data 所有需要合并的数据 可以是table可以是任何数据
local table_merge = function(...)
    local table_temp = {}
    for _, temp_v1 in pairs({ ... }) do
        if type(temp_v1) == "table" then
            for _, value in pairs(temp_v1) do
                table_deduplicate_add(table_temp, value)
            end
        else
            table_deduplicate_add(table_temp, temp_v1)
        end
    end
    return table_temp
end

function CandyNode:ctor(id)
    self:setCascadeOpacityEnabled(true)
    self:init(id)
    if (CandyNode.parent) then
        self:addTo(CandyNode.parent)
            :move(math.random(160, display.realWidth - 160),
                math.random(display.realHeight - 10, display.realHeight - 75)
        )
    end
    self:addClickEventListener(function()
        self:merging()
    end)
    self.createPosY = self:getPositionY()
    self:runAction(cc.Sequence:create(cc.DelayTime:create(5), cc.CallFunc:create(function()
        if self.createPosY > self:getPositionY() then
            return
        else
            ----瓶子满了 结束游戏
            cc.Director:getInstance():getRunningScene():gameOver()
        end
    end)))


    --cc.Director:getInstance():getScheduler():scheduleScriptFunc(function()
    --    dump(self.physicsBody:getVelocity())
    --end, 1, false)
end

---@public getAllCandyNodes  获取所有的挨着的相同的节点
function CandyNode:getAllCandyNodes(tables)
    if not self.contactNodes then
        return tables
    end
    for _, node in pairs(self.contactNodes) do
        local is_merge = true
        for _, node_temp in pairs(tables) do
            if node == node_temp then
                is_merge = false
                break
            end
        end
        if is_merge then
            table.insert(tables, node)
            tables = table_merge(tables, node:getAllCandyNodes(tables))
        end
    end
    tables = table_merge(tables, self.contactNodes)
    return tables
end

function CandyNode:init(id)
    local children = self:getChildren()
    for k, v in pairs(children) do
        self:removeChild(v)
    end
    self.id = id or math.random(1, 3)
    self.imagePath = string.format("SoftFudgeCandy/images/game/Candys/%s.png", self.id)
    self.sprite = ccui.Button:create(self.imagePath, self.imagePath, self.imagePath)
                      :addTo(self)
    self.size = self.sprite:getContentSize()
    if not self.physicsBody then
        local body = cc.PhysicsBody:createCircle(self.size.width * 0.5 - 1, MATERIAL_DEFAULT)  -- 刚体大小，材质类型
        self.physicsBody = body
        self:setPhysicsBody(body)
        local contactListener = cc.EventListenerPhysicsContact:create()
        contactListener:registerScriptHandler(handler(self, self.onContactBegin), cc.Handler.EVENT_PHYSICS_CONTACT_BEGIN)
        contactListener:registerScriptHandler(handler(self, self.onContactSeparate), cc.Handler.EVENT_PHYSICS_CONTACT_SEPARATE)
        local eventDispatcher = cc.Director:getInstance():getEventDispatcher()
        eventDispatcher:addEventListenerWithFixedPriority(contactListener, 1)
    else
        self.physicsBody:removeAllShapes()
        self.physicsBody:addShape(cc.PhysicsShapeCircle:create(self.size.width * 0.5 - 1, MATERIAL_DEFAULT))
        print(self.physicsBody:getCategoryBitmask())
    end

    self.physicsBody:setCategoryBitmask(0x01)
    self.physicsBody:setContactTestBitmask(0x01)
    self.physicsBody:setCollisionBitmask(0x01)
    self.physicsBody:addMass(self.id * 100)
    self.physicsBody:setEnabled(true)

    if self.callback then
        self.sprite:addClickEventListener(self.callback)
    end


end

function CandyNode:addClickEventListener(callback)
    self.sprite:addClickEventListener(callback)
    self.callback = callback
end

function CandyNode:onContactBegin(contact)
    local nodeA = contact:getShapeA():getBody():getNode()
    local nodeB = contact:getShapeB():getBody():getNode()
    if nodeA ~= self and nodeB ~= self then
        return true
    end
    ---自己和其他发生了碰撞
    --- nodeB 设置成自己
    if nodeB ~= self then
        local temp = nodeA
        nodeA = nodeB
        nodeB = temp
    end

    if (nodeA.id == self.id) then
        self:mergeCheck(nodeA)
    end
    return true
end

function CandyNode:onContactSeparate(contact)
    local nodeA = contact:getShapeA():getBody():getNode()
    local nodeB = contact:getShapeB():getBody():getNode()
    if nodeA ~= self and nodeB ~= self then
        return true
    end
    ---自己和其他发生了碰撞
    --- nodeB 设置成自己
    if nodeB ~= self then
        local temp = nodeA
        nodeA = nodeB
        nodeB = temp
    end

    if (nodeA.id == self.id) then
        self:mergeCheckOut(nodeA)
    end
    return true
end

function CandyNode:mergeCheckOut(nodeA)
    if (not nodeA.id or nodeA.id ~= self.id) then
        print("2个不是同样的球")
        return
    end

    if nodeA == self then
        print("2个球就是自己")
        return
    end

    for pos, node in pairs(self.contactNodes) do
        if node == nodeA then
            table.remove(self.contactNodes, pos)
            return
        end
    end
    print("不应该这里 1")
end

---@public mergeCheck 检查是否可以融合
function CandyNode:mergeCheck(nodeA)
    if (not nodeA.id or nodeA.id ~= self.id) then
        print("2个不是同样的球")
        return
    end

    if nodeA == self then
        print("2个球就是自己")
        return
    end

    if not self.contactNodes then
        self.contactNodes = {}
        table.insert(self.contactNodes, self)
    end

    for k, node in pairs(self.contactNodes) do
        if node == nodeA then
            return
        end
    end
    table.insert(self.contactNodes, nodeA)

    --local nodePos = nodeA:getPositionY()
    --local selfPos = self:getPositionY()
    --print(nodePos)
    --print(selfPos)
    --if (nodePos > selfPos) then
    --    self:merging(nodeA)
    --else
    --    --nodeA:merging(self)
    --end
end

---@public merging 开始融合
function CandyNode:merging()
    local temp = {}
    temp = self:getAllCandyNodes(temp)
    if #temp < 2 then
        return
    end
    ---移除自己
    for k, node in ipairs(temp) do
        --node.physicsBody:removeFromWorld()
        node.physicsBody:setEnabled(false)
        node:runAction(
                cc.Sequence:create(
                        cc.MoveTo:create(0.5, cc.p(self:getPositionX(), self:getPositionY())),
                        cc.CallFunc:create(function()
                            if node ~= self then
                                node:score()
                            else
                                self:upgrade(#temp)
                            end
                        end)
                )
        )
    end
    if self.id < CandyNode.MaxId then
        self:runAction(cc.Sequence:create(
                cc.CallFunc:create(function()
                    self.sprite:setEnabled(false)
                    self.imagePath = string.format("SoftFudgeCandy/images/game/merging/%s.png", self.id)
                    self.sprite:loadTextures(self.imagePath, self.imagePath, self.imagePath)
                end),
        --cc.MoveTo:create(0.5, cc.p(self:getPositionX(), self:getPositionY())),
                cc.DelayTime:create(0.5),
                cc.CallFunc:create(function()
                    self.sprite:setEnabled(true)
                end)
        ))
    end
end

function CandyNode:upgrade(count)
    local addLeave = 1;
    while math.pow(2, addLeave + 1) < count do
        addLeave = addLeave + 1
    end
    print("开始升级 addLeave:", addLeave, ' count:', count)
    self:init(self.id + addLeave)
end

function CandyNode:score()
    print("开始加分 且删除自己")
    cc.Director:getInstance():getRunningScene():removeCandyNode(self)
    delayDoSomething(handler(self, self.removeSelf), 0.2)
end

return CandyNode