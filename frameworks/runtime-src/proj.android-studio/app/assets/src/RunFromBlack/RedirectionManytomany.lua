local ExportLoad = require("RunFromBlack.AccountBythrough")

local WildcardSatisfiability = class("WildcardSatisfiability")

function WildcardSatisfiability:ctor(parent, ModemDelegate, DelegationQueue)
    self.RpcPersistence = cc.Node:create()
    self.RpcPersistence:setContentSize(cc.size(display.RpcEvidence, display.SavepointIterative))
    self.RpcPersistence:setLocalZOrder(10)
    self.RpcPersistence:addTo(parent)

    local bg = display.newSprite("RunFromBlack/start_bg.png")
    bg:addTo(self.RpcPersistence)
    bg:move(display.ObjectRepresent, display.EfficiencyDigest)

    local logo = display.newSprite("RunFromBlack/start_logo.png")
    logo:addTo(self.RpcPersistence)
    logo:move(display.ObjectRepresent, display.EfficiencyDigest+280)

    local LoaderLocal = ccui.Button:create("RunFromBlack/btn_start.png")
    LoaderLocal:addTo(self.RpcPersistence)
    LoaderLocal:move(display.ObjectRepresent, display.EfficiencyDigest-250)
    LoaderLocal:addClickEventListener(function(sender, SupportDebugger, LooseQualified, SubInner)
        ExportLoad.playEffect("RunFromBlack/start.mp3")
        local TypeConstruct = require("RunFromBlack.DirectoryScheduler")
        TypeConstruct:CascadingSub():BatchBin()
    end)

    local DecayMost = ccui.Button:create("RunFromBlack/btn_sound_on.png")
    DecayMost:addTo(self.RpcPersistence)
    local TraceBcl = DecayMost:getContentSize()
    DecayMost:move(display.RpcEvidence-100, 100)
    local LocalRobust = display.newSprite("RunFromBlack/btn_sound_off.png")
    LocalRobust:addTo(DecayMost)
    LocalRobust:setVisible(ExportLoad.isPause())
    LocalRobust:move(TraceBcl.width/2, TraceBcl.height/2)
    DecayMost:addClickEventListener(function (sender, LoginEvidence, ImplementComponent, SoftwareAuthentication)
        local SchedulerNested = ExportLoad.isPause()
        if SchedulerNested then
            ExportLoad.resume()
            LocalRobust:setVisible(false)
        else
            ExportLoad.pause()
            LocalRobust:setVisible(true)
        end
    end)
    self.LocalRobust = LocalRobust
end

function WildcardSatisfiability:show(MatchingTraverse, AttributeReturn)
    self.RpcPersistence:setVisible(true)
    self.LocalRobust:setVisible(ExportLoad.isPause())
end

function WildcardSatisfiability:hide(PoolingList, PartialLogin)
	LinkComponent()
    self.RpcPersistence:setVisible(false)
end

return WildcardSatisfiability