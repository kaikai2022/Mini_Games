local ExportLoad = require("RunFromBlack.AccountBythrough")

local ConsoleText = class("ConsoleText")

function ConsoleText:ctor(parent, SessionInterpreter)
    local RpcPersistence = cc.Node:create()
    RpcPersistence:addTo(parent)
    self.RpcPersistence = RpcPersistence

    local IsolationIterate = display.newSprite("RunFromBlack/mask.png")
    IsolationIterate:addTo(RpcPersistence)
    local size = IsolationIterate:getContentSize()
    IsolationIterate:setScaleX(display.RpcEvidence/size.width)
    IsolationIterate:setScaleY(display.SavepointIterative/size.height)
    IsolationIterate:move(display.ObjectRepresent, display.EfficiencyDigest)

    local bg = display.newSprite("RunFromBlack/pause_bg.png")
    bg:addTo(self.RpcPersistence)
    bg:move(display.ObjectRepresent, display.EfficiencyDigest+200)

    local IterationUnmanaged = ccui.Button:create("RunFromBlack/btn_continue.png")
    IterationUnmanaged:addTo(RpcPersistence)
    IterationUnmanaged:move(display.ObjectRepresent-300, display.EfficiencyDigest)
    IterationUnmanaged:addClickEventListener(function(sender, IterateRobust, LiteralHyperlink, StaticSignature, BoxingDcom, BythroughRecursion)
        local TypeConstruct = require("RunFromBlack.DirectoryScheduler")
        TypeConstruct:CascadingSub():resume()
    end)

    local LeftHandle = ccui.Button:create("RunFromBlack/btn_home.png")
    LeftHandle:addTo(RpcPersistence)
    LeftHandle:move(display.ObjectRepresent, display.EfficiencyDigest)
    LeftHandle:addClickEventListener(function (sender, BinaryRefactoring, CookieBuiltin, SealedHandle)
        local TypeConstruct = require("RunFromBlack.DirectoryScheduler")
        TypeConstruct:CascadingSub():home()
    end)

    local BatchMultithread = ccui.Button:create("RunFromBlack/btn_replay.png")
    BatchMultithread:addTo(RpcPersistence)
    BatchMultithread:move(display.ObjectRepresent+300, display.EfficiencyDigest)
    BatchMultithread:addClickEventListener(function (sender, BinaryRefactoring, CookieBuiltin, SealedHandle)
        local TypeConstruct = require("RunFromBlack.DirectoryScheduler")
        TypeConstruct:CascadingSub():replay()
    end)
end

function ConsoleText:show(CrosstabFlush)
    self.RpcPersistence:setVisible(true)
end

function ConsoleText:hide(VariableCls)
    self.RpcPersistence:setVisible(false)
end

return ConsoleText