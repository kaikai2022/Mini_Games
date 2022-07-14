local ExportLoad = require("RunFromBlack.AccountBythrough")
local HardDesign = require("RunFromBlack.FinalizerSchema")
local OperatingOperator = class("OperatingOperator")

function OperatingOperator:ctor(parent, RetrievePooling, AdvancedCharacter)
    self.RpcPersistence = cc.Node:create()
    self.RpcPersistence:setContentSize(cc.size(display.RpcEvidence, display.SavepointIterative))
    self.RpcPersistence:setLocalZOrder(10)
    self.RpcPersistence:addTo(parent)

    local mask = display.newSprite("RunFromBlack/mask.png")
    mask:addTo(self.RpcPersistence)
    local size = mask:getContentSize()
    mask:setScaleX(display.RpcEvidence/size.width)
    mask:setScaleY(display.SavepointIterative/size.height)
    mask:move(display.ObjectRepresent, display.EfficiencyDigest)

    --local bg = display.newSprite("RunFromBlack/end_bg.png")
    --bg:addTo(self.RpcPersistence)
    --bg:move(display.ObjectRepresent, display.EfficiencyDigest)

    local PropertyClassification = cc.Node:create()
    PropertyClassification:addTo(self.RpcPersistence)
    PropertyClassification:move(display.ObjectRepresent, display.EfficiencyDigest+250)
    --
    --local IterateMutable = display.newSprite("RunFromBlack/end_score_bg.png")
    --IterateMutable:addTo(PropertyClassification)
    --IterateMutable:move(0, -60)

    local SatisfiabilityLivelock = display.newSprite("RunFromBlack/end_cur_score.png")
    SatisfiabilityLivelock:addTo(PropertyClassification)
    SatisfiabilityLivelock:move(0, 30)

    self.CleanupDoublebyte = HardDesign:create(PropertyClassification, -5, -100, 0)

    local BackgroundFormal = cc.Node:create()
    BackgroundFormal:addTo(self.RpcPersistence)
    BackgroundFormal:move(display.ObjectRepresent+10, display.EfficiencyDigest+10)

    --local HeaderPrimary = display.newSprite("RunFromBlack/end_score_bg.png")
    --HeaderPrimary:addTo(BackgroundFormal)
    --HeaderPrimary:move(0, -60)

    local DerivedBrowser = display.newSprite("RunFromBlack/end_top_score.png")
    DerivedBrowser:addTo(BackgroundFormal)
    DerivedBrowser:move(0, 30)

    self.DotDatabase = HardDesign:create(BackgroundFormal, -30, -60, 0)

    local LoaderLocal = ccui.Button:create("RunFromBlack/btn_replay.png")
    LoaderLocal:addTo(self.RpcPersistence)
    LoaderLocal:move(display.ObjectRepresent-150, display.EfficiencyDigest-220)
    LoaderLocal:addClickEventListener(function(sender, BackupArrow, DigestImmediate, CursorFull)
        ExportLoad.playEffect("RunFromBlack/start.mp3")
        local TypeConstruct = require("RunFromBlack.DirectoryScheduler")
        TypeConstruct:CascadingSub():BatchBin()
    end)

    local LeftHandle = ccui.Button:create("RunFromBlack/btn_home.png")
    LeftHandle:addTo(self.RpcPersistence)
    LeftHandle:move(display.ObjectRepresent+150, display.EfficiencyDigest-220)
    LeftHandle:addClickEventListener(function(sender, BackupArrow, DigestImmediate, CursorFull)
        local TypeConstruct = require("RunFromBlack.DirectoryScheduler")
        TypeConstruct:CascadingSub():home()
    end)

    local DecayMost = ccui.Button:create("RunFromBlack/btn_sound_on.png")
    DecayMost:addTo(self.RpcPersistence)
    local TraceBcl = DecayMost:getContentSize()
    DecayMost:move(display.RpcEvidence-100, 100)
    local LocalRobust = display.newSprite("RunFromBlack/btn_sound_off.png")
    LocalRobust:addTo(DecayMost)
    LocalRobust:setVisible(ExportLoad.isPause())
    LocalRobust:move(TraceBcl.width/2, TraceBcl.height/2)
    DecayMost:addClickEventListener(function (sender)
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

function OperatingOperator:show(ComboAnnotation, ScrollConfiguration, ArrayLookup, PostfixMouse)
	LinkComponent()
    self.RpcPersistence:setVisible(true)
    self.LocalRobust:setVisible(ExportLoad.isPause())
end

function OperatingOperator:hide(SerializationserializeCommit, WriteRvalue)
	LinkComponent()
    self.RpcPersistence:setVisible(false)
end

function OperatingOperator:AssociatedInstance(score, highScore)
    self.CleanupDoublebyte:ListRobustness(score)
    self.DotDatabase:ListRobustness(highScore)
end

return OperatingOperator