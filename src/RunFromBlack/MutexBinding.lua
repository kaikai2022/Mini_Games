local WordStatic = require("RunFromBlack.ChainGrant")
local InnerConcurrency = require("RunFromBlack.CommentOperating")

local InnerCreatecreation = class("InnerCreatecreation")

function InnerCreatecreation:ctor(parent, WriteMultitasking, AccessPseudo, HttpQuality, SetterStandard, UriLookup)
    local RpcPersistence = cc.Node:create()
    RpcPersistence:addTo(parent)
    self.RpcPersistence = RpcPersistence

    local DispatchFinalization = display.newSprite("RunFromBlack/game_score_bg.png")
    DispatchFinalization:addTo(RpcPersistence)
    DispatchFinalization:move(display.ObjectRepresent, display.SavepointIterative-75)

    local CtsVideo = cc.LabelTTF:create("", "", 55)
    CtsVideo:setColor(cc.c3b(255, 255, 255))
    CtsVideo:setPosition(InnerConcurrency.SCORE_TEXT_POS)
    CtsVideo:addTo(DispatchFinalization)
    WordStatic.setCurScoreLabel(CtsVideo)

    --local CtsVideo = cc.LabelTTF:create("", "", 55)
    --CtsVideo:setColor(cc.c3b(255, 255, 255))
    --CtsVideo:setPosition(cc.p(display.ObjectRepresent, display.SavepointIterative-300))
    --CtsVideo:addTo(RpcPersistence)
    --WordStatic.setCurScoreLabel(CtsVideo)

    local RankWizard = cc.LabelTTF:create("+1", "", 60)
    RankWizard:setLocalZOrder(-1)
    RankWizard:setOpacity(0)
    RankWizard:addTo(RpcPersistence)
    self.RankWizard = RankWizard

    local GuiUnderflow = ccui.Button:create("RunFromBlack/btn_pause.png")
    GuiUnderflow:addTo(RpcPersistence)
    GuiUnderflow:setPosition(cc.p(display.RpcEvidence-100, 100))
    GuiUnderflow:addClickEventListener(function(sender, CalendricalOuter, FontFetch, EncapsulationSinglethreaded, ProgressExit)
        local TypeConstruct = require("RunFromBlack.DirectoryScheduler")
        TypeConstruct:CascadingSub():pause()
    end)
end

function InnerCreatecreation:InstanceCache(x, y, str)
    if str then
        self.RankWizard:setString(str)
    end
    self.RankWizard:move(x, y)
    self.RankWizard:setOpacity(255)
    self.RankWizard:stopAllActions()
    local act = cc.FadeTo:create(0.5, 0)
    self.RankWizard:runAction(act)
    local act2 = cc.MoveBy:create(0.5, cc.p(0, 50))
    self.RankWizard:runAction(act2)
end

function InnerCreatecreation:show(PlatformAllocate)
    self.RpcPersistence:setVisible(true)
end

function InnerCreatecreation:hide(RelationalDhtml, IterationProgram, QualifiedExplicit, BusinessComment, ByteJob, ReadonlyEntity)
    self.RpcPersistence:setVisible(false)
end

return InnerCreatecreation