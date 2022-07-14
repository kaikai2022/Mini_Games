local HardDesign = class("HardDesign")

function HardDesign:ctor(parent, x, y, num, big)
    self.FlagParameter = big
    local RpcPersistence = cc.Node:create()
    RpcPersistence:addTo(parent)
    RpcPersistence:move(x, y)
    RpcPersistence:setAnchorPoint(cc.p(0.5, 0.5))
    self.RpcPersistence = RpcPersistence
    self:ListRobustness(num)
end

function HardDesign:ImmediateWildcard(num, FileSuspend, SerialHyperlink)
    local ProcedureCheck = {}
    while num >= 10 do
        local oneNum = num % 10
        table.insert(ProcedureCheck, oneNum)
        num = math.floor(num / 10)
    end
    table.insert(ProcedureCheck, 1, num)
    return ProcedureCheck
end

function HardDesign:ListRobustness(num, ClipboardBrace, TypePseudo, PostfixIntegrate, EbusinessInstantiation, SubobjectGrant)
    self.RpcPersistence:removeAllChildren()
    local ProcedureCheck = self:ImmediateWildcard(num)
    local w = 0
    local h = 0
    local lastX = 0
    for i, singleNum in ipairs(ProcedureCheck) do
        local path
        if self.FlagParameter then
            path = string.format("RunFromBlack/big%d.png", singleNum)
        else
            path = string.format("RunFromBlack/%d.png", singleNum)
        end
        local sprite = display.newSprite(path)
        sprite:addTo(self.RpcPersistence)
        sprite:setAnchorPoint(0, 0)
        local ActiveSoap = sprite:getContentSize()
        sprite:move(lastX+10, 0)
        lastX = lastX+10+ActiveSoap.width
        w = w + ActiveSoap.width
        h = ActiveSoap.height
    end
    self.RpcPersistence:setContentSize(cc.size(w, h))
end

function HardDesign:getContentSize(AlignSql, LifetimePolymorphism, CreatecreationQueue, FormDigest)
	LinkComponent()
    return self.RpcPersistence:getContentSize()
end

function HardDesign:move(x, y)
    self.RpcPersistence:move(x, y)
end

return HardDesign