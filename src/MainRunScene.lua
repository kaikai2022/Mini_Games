---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by lucus.
--- DateTime: 15/7/2022 5:54 PM
---

local scenes = {

    --- 软软水果糖
    {
        name = "软软水果糖",
        isPhysics = false,
        layer = "SoftFudgeCandy.MainScene"
    },

    --- 跳跳熊
    {
        name = "跳跳熊",
        isPhysics = true,
        layer = "SuperBear.MainScene"
    },

    --- 猜谜语
    {
        name = "猜谜语",
        isPhysics = false,
        layer = "GuessTheIdiom.MainScene"
    },

    --- 跳龙门
    {
        name = "跳龙门",
        isPhysics = false,
        layer = "JumpingTheGantry.MainScene"
    },

    ---PartWheel
    {
        name = "PartWheel",
        isPhysics = false,
        layer = "PartyWheel.MainScene"   -- PartWheel
    },

    ---逃离黑洞
    {
        name = "逃离黑洞",
        isPhysics = true,
        layer = "RunFromBlack.MainScene"   -- 逃离黑洞
    },

    ---金刚大战
    {
        name = "金刚大战",
        isPhysics = true,
        layer = "KingKongWar.MainScene"
    },

}
local MainRunScene = class("MainRunScene", function()
    return cc.Scene:create()
end)

function MainRunScene:ctor()
    local layer = ccui.Layout:create()
                      :setContentSize(display.width, display.height)
                      :setAnchorPoint(cc.p(0, 0))
                      :addTo(self)
                      :setBackGroundColor(display.COLOR_GREEN)
                      :setBackGroundColorType(ccui.LayoutBackGroundColorType.solid) --设置颜色

    local scaleView = ccui.ScrollView:create()
                          :setContentSize(400, display.height - 200)
                          :setAnchorPoint(0.5, 0.5)
                          :addTo(layer):move(display.cx, display.cy)
                          :setBackGroundColor(display.COLOR_RED)
                          :setBackGroundColorType(ccui.LayoutBackGroundColorType.solid) --设置颜色
                          :setScrollBarEnabled(false)
    self.buttons = {}
    for index, game in ipairs(scenes) do
        local panel = ccui.Layout:create()
                          :setContentSize(400, 120)
                          :addTo(scaleView)
        local button = ccui.Button:create()
                           :ignoreContentAdaptWithSize(false)
                           :loadTextureNormal("Default/Button_Normal.png", 0)
                           :loadTexturePressed("Default/Button_Press.png", 0)
                           :loadTextureDisabled("Default/Button_Disable.png", 0)
                           :setScale9Enabled(true)
                           :setContentSize(300, 100)
                           :setAnchorPoint(0.5, 0.5)
                           :addTo(panel)
                           :setTitleText(game.name)
                           :setTitleFontSize(50)
                           :setTitleColor(display.COLOR_BLACK)
                           :move(200, 120 * 0.5)
        button:addClickEventListener(handler(self, self.runGame))
        self.buttons[button] = game
    end
    scaleView:setInnerContainerSize(cc.size(400, #scenes * 120));--设置ScrollView容器大小，随着ScrollView容纳的控件越多，此值的设置值应该也变大

    scaleView:setLayoutType(ccui.LayoutType.VERTICAL)
end
local isHow = true
function MainRunScene:runGame(sender)
    local sdk = require("Cocos2dxiOSLuaSDK")
    sdk:showVideo(function(rule)
        print(rule)
        --isHow = not rule
        if rule then
            local game = self.buttons[sender]
            print(game.name)
            local scene = nil
            if game.isPhysics then
                scene = cc.Scene:createWithPhysics()
            else
                scene = cc.Scene:create()
            end
            scene:addChild(require(game.layer).new())
            display.runScene(scene)
        end
    end)
    if isHow then
        return ;
    end
    --if isHow then
    --    sdk:hideGodAdBannerView()
    --else
    --    sdk:showGodAdBannerView()
    --end
    --isHow = not isHow
    --
    --return
    local game = self.buttons[sender]
    print(game.name)
    local scene = nil
    if game.isPhysics then
        scene = cc.Scene:createWithPhysics()
    else
        scene = cc.Scene:create()
    end
    scene:addChild(require(game.layer).new())
    display.runScene(scene)
    --cc.Director:getInstance():replaceScene(scene)
    --cc.Director:getInstance():setDisplayStats(true)
end

return MainRunScene