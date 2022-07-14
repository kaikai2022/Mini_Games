local TypeConstruct = require("RunFromBlack.DirectoryScheduler")
local PointerInitialize = {}


-- 以下是MoveWithFingerPortrait --

local  CharacterImport = class("MoveWithFinger")
PointerInitialize.CharacterImport = CharacterImport

function CharacterImport:ctor(MutableBrace, ControlMultithread, IncrementalDeclaration)
    TypeConstruct:CascadingSub():DialogAllocator(TypeConstruct.ScrollIncremental, handler(self, self.AppendOuter))
    TypeConstruct:CascadingSub():DialogAllocator(TypeConstruct.ResolveUnderflow, handler(self, self.InstantiationDebug))
    TypeConstruct:CascadingSub():DialogAllocator(TypeConstruct.TransactionBracket, handler(self, self.PlaceholderParameterize))
    TypeConstruct:CascadingSub():DialogAllocator(TypeConstruct.IdlMetadata, handler(self, self.PlaceholderParameterize))
end

function CharacterImport:CascadingSub(UriResolution, DirectoryImplicit, ConfigurationGroup, ScrollHierarchy)
    if not CharacterImport.PaletteStandard then
        CharacterImport.PaletteStandard = CharacterImport.new()
    end
    return CharacterImport.PaletteStandard
end

function CharacterImport:OuterAddin(target, rate)
    self.target = target
    self.rate = rate
end

function CharacterImport:AppendOuter(loc, InvokeInvariants, FunctionImmediate, BooleanRecordset, VendorIncremental)
    if not TypeConstruct:CascadingSub():UmlLink() or TypeConstruct:CascadingSub():RepresentImplementation() or not self.target then
        return
    end
    self.IdleHot = cc.p(loc.y, display.width - loc.x)
    self.ExceptionsafeInfinite = cc.p(self.target:getPosition())
end

function CharacterImport:InstantiationDebug(loc)
    if not TypeConstruct:CascadingSub():UmlLink() or TypeConstruct:CascadingSub():RepresentImplementation() or not self.target then
        return
    end
    local curPos = cc.p(loc.y, display.width - loc.x)
    local nx = self.ExceptionsafeInfinite.x + (curPos.x - self.IdleHot.x) * self.rate
    local ny = self.ExceptionsafeInfinite.y + (curPos.y - self.IdleHot.y) * self.rate
    if nx < 0 then
        nx = 0
    elseif nx > display.height then
        nx = display.height
    end
    if ny < 0 then
        ny = 0
    elseif ny > display.width then
        ny = display.width
    end
    self.target:setPosition(nx, ny)
end

function CharacterImport:PlaceholderParameterize(loc, IterativeDestroy, QualifiedBracket, StreamEnum)
    self.IdleHot = nil
    self.ExceptionsafeInfinite = nil
end

-- 是MoveWithFinger结束 --


-- 以下是MoveWithFingerPortrait --

local ServerXsl = class("ServerXsl")
PointerInitialize.ServerXsl = ServerXsl

function ServerXsl:ctor(cb, DestroyRevoke, ImplementJit, ArgumentAngle, DisassemblerTemplate, VendorApproximate)
    local ParameterizeAggregation = cc.EventListenerTouchOneByOne:create()
    ParameterizeAggregation:registerScriptHandler(handler(self, ServerXsl.AppendOuter), cc.Handler.EVENT_TOUCH_BEGAN)
    ParameterizeAggregation:registerScriptHandler(handler(self, ServerXsl.PlaceholderParameterize), cc.Handler.EVENT_TOUCH_ENDED)
    ParameterizeAggregation:registerScriptHandler(handler(self, ServerXsl.PlaceholderParameterize), cc.Handler.EVENT_TOUCH_CANCELLED)
    local OperatingLinkage = cc.Director:getInstance()
    local EbusinessOperation = OperatingLinkage:getEventDispatcher()
    EbusinessOperation:addEventListenerWithFixedPriority(ParameterizeAggregation, 1)
    self.ParameterizeAggregation = ParameterizeAggregation
    self.cb = cb
end

function ServerXsl:EngineIndex(ImportSavepoint, AppendRecursion, ResultPoint, FunctorConstruct, InvokeBackward, AllocatorCil)
    local OperatingLinkage = cc.Director:getInstance()
    local EbusinessOperation = OperatingLinkage:getEventDispatcher()
    EbusinessOperation:removeEventListener(self.ParameterizeAggregation)
end

function ServerXsl:AppendOuter(touch, event)
    if not TypeConstruct:CascadingSub():UmlLink() or TypeConstruct:CascadingSub():RepresentImplementation() then
        return true
    end
    self.CacheCasting = touch:getLocation()
    return true
end

function ServerXsl:PlaceholderParameterize(touch, event)
    if not TypeConstruct:CascadingSub():UmlLink() or TypeConstruct:CascadingSub():RepresentImplementation() or not self.CacheCasting then
        return
    end
    local endPos = touch:getLocation()
    local cmpX = endPos.x - self.CacheCasting.x
    local cmpY = endPos.y - self.CacheCasting.y
    if math.abs(cmpX) > math.abs(cmpY) then
        if cmpX < 0 then
            self.cb(4)          -- up
        else
            self.cb(3)
        end
    else
        if cmpY < 0 then
            self.cb(1)          -- left
        else
            self.cb(2)
        end
    end
end

return PointerInitialize