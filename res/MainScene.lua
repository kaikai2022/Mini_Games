--------------------------------------------------------------
-- This file was automatically generated by Cocos Studio.
-- Do not make changes to this file.
-- All changes will be lost.
--------------------------------------------------------------

local luaExtend = require "LuaExtend"

-- using for layout to decrease count of local variables
local layout = nil
local localLuaFile = nil
local innerCSD = nil
local innerProject = nil
local localFrame = nil

local Result = {}
------------------------------------------------------------
-- function call description
-- create function caller should provide a function to 
-- get a callback function in creating scene process.
-- the returned callback function will be registered to 
-- the callback event of the control.
-- the function provider is as below :
-- Callback callBackProvider(luaFileName, node, callbackName)
-- parameter description:
-- luaFileName  : a string, lua file name
-- node         : a Node, event source
-- callbackName : a string, callback function name
-- the return value is a callback function
------------------------------------------------------------
function Result.create(callBackProvider)

local result={}
setmetatable(result, luaExtend)

--Create Scene
local Scene=cc.Node:create()
Scene:setName("Scene")

--Create bg
local bg = cc.Sprite:create("Scene/res/start_bg.png")
bg:setName("bg")
bg:setTag(2)
bg:setCascadeColorEnabled(true)
bg:setCascadeOpacityEnabled(true)
bg:setPosition(375.0000, 812.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(bg)
layout:setPositionPercentX(0.5000)
layout:setPositionPercentY(0.5000)
layout:setPercentWidth(1.0000)
layout:setPercentHeight(1.0000)
layout:setSize({width = 750.0000, height = 1624.0000})
bg:setBlendFunc({src = 770, dst = 771})
Scene:addChild(bg)

--Create Image_1
local Image_1 = ccui.ImageView:create()
Image_1:ignoreContentAdaptWithSize(false)
Image_1:loadTexture("Scene/res/max_score_icon.png",0)
Image_1:setScale9Enabled(true)
Image_1:setCapInsets({x = 34, y = 32, width = 25, height = 22})
Image_1:setLayoutComponentEnabled(true)
Image_1:setName("Image_1")
Image_1:setTag(13)
Image_1:setCascadeColorEnabled(true)
Image_1:setCascadeOpacityEnabled(true)
layout = ccui.LayoutComponent:bindLayoutComponent(Image_1)
layout:setPercentWidth(0.1027)
layout:setPercentHeight(0.0493)
layout:setSize({width = 77.0000, height = 80.0000})
layout:setLeftMargin(-38.5000)
layout:setRightMargin(711.5000)
layout:setTopMargin(1584.0000)
layout:setBottomMargin(-40.0000)
Scene:addChild(Image_1)

--Create logo
local logo = cc.Sprite:create("Scene/res/logo.png")
logo:setName("logo")
logo:setTag(4)
logo:setCascadeColorEnabled(true)
logo:setCascadeOpacityEnabled(true)
logo:setPosition(375.0000, 959.9500)
layout = ccui.LayoutComponent:bindLayoutComponent(logo)
layout:setPositionPercentX(0.5000)
layout:setPositionPercentY(0.5911)
layout:setPercentWidth(0.7267)
layout:setPercentHeight(0.5523)
layout:setSize({width = 545.0000, height = 897.0000})
layout:setLeftMargin(102.5000)
layout:setRightMargin(102.5000)
layout:setTopMargin(215.5500)
layout:setBottomMargin(511.4500)
logo:setBlendFunc({src = 1, dst = 771})
Scene:addChild(logo)

--Create sound_btn
local sound_btn = cc.Sprite:create("Scene/res/sound_on.png")
sound_btn:setName("sound_btn")
sound_btn:setTag(7)
sound_btn:setCascadeColorEnabled(true)
sound_btn:setCascadeOpacityEnabled(true)
sound_btn:setAnchorPoint(0.0000, 0.0000)
sound_btn:setPosition(570.0000, 1380.4000)
layout = ccui.LayoutComponent:bindLayoutComponent(sound_btn)
layout:setPositionPercentX(0.7600)
layout:setPositionPercentY(0.8500)
layout:setPercentWidth(0.1133)
layout:setPercentHeight(0.0517)
layout:setSize({width = 85.0000, height = 84.0000})
layout:setLeftMargin(570.0000)
layout:setRightMargin(95.0000)
layout:setTopMargin(159.6000)
layout:setBottomMargin(1380.4000)
sound_btn:setBlendFunc({src = 1, dst = 771})
Scene:addChild(sound_btn)

--Create score_node
local score_node=cc.Node:create()
score_node:setName("score_node")
score_node:setTag(9)
score_node:setCascadeColorEnabled(true)
score_node:setCascadeOpacityEnabled(true)
score_node:setPosition(375.0000, 146.1600)
layout = ccui.LayoutComponent:bindLayoutComponent(score_node)
layout:setPositionPercentXEnabled(true)
layout:setPositionPercentYEnabled(true)
layout:setPositionPercentX(0.5000)
layout:setPositionPercentY(0.0900)
layout:setLeftMargin(375.0000)
layout:setRightMargin(375.0000)
layout:setTopMargin(1477.8400)
layout:setBottomMargin(146.1600)
Scene:addChild(score_node)

--Create bg
local bg = cc.Sprite:create("Scene/res/max_score_bg.png")
bg:setName("bg")
bg:setTag(10)
bg:setCascadeColorEnabled(true)
bg:setCascadeOpacityEnabled(true)
layout = ccui.LayoutComponent:bindLayoutComponent(bg)
layout:setSize({width = 381.0000, height = 141.0000})
layout:setHorizontalEdge(3)
layout:setVerticalEdge(3)
layout:setLeftMargin(-190.5000)
layout:setRightMargin(-190.5000)
layout:setTopMargin(-70.5000)
layout:setBottomMargin(-70.5000)
bg:setBlendFunc({src = 1, dst = 771})
score_node:addChild(bg)

--Create icon
local icon = cc.Sprite:create("Scene/res/max_score_icon.png")
icon:setName("icon")
icon:setTag(11)
icon:setCascadeColorEnabled(true)
icon:setCascadeOpacityEnabled(true)
icon:setPosition(-97.0085, 0.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(icon)
layout:setSize({width = 77.0000, height = 80.0000})
layout:setHorizontalEdge(1)
layout:setVerticalEdge(3)
layout:setLeftMargin(-135.5085)
layout:setRightMargin(58.5085)
layout:setTopMargin(-40.0000)
layout:setBottomMargin(-40.0000)
icon:setBlendFunc({src = 1, dst = 771})
score_node:addChild(icon)

--Create Panel_1
local Panel_1 = ccui.Layout:create()
Panel_1:ignoreContentAdaptWithSize(false)
Panel_1:setClippingEnabled(false)
Panel_1:setBackGroundColorOpacity(102)
Panel_1:setLayoutComponentEnabled(true)
Panel_1:setName("Panel_1")
Panel_1:setTag(12)
Panel_1:setCascadeColorEnabled(true)
Panel_1:setCascadeOpacityEnabled(true)
Panel_1:setAnchorPoint(0.5000, 0.5000)
Panel_1:setPosition(65.4306, 0.0000)
Panel_1:setOpacity(249)
layout = ccui.LayoutComponent:bindLayoutComponent(Panel_1)
layout:setSize({width = 200.0000, height = 120.0000})
layout:setHorizontalEdge(2)
layout:setVerticalEdge(3)
layout:setLeftMargin(-34.5694)
layout:setRightMargin(-165.4306)
layout:setTopMargin(-60.0000)
layout:setBottomMargin(-60.0000)
score_node:addChild(Panel_1)

--Create Sprite_6
local Sprite_6 = cc.Sprite:create("Scene/res/max_score_tips.png")
Sprite_6:setName("Sprite_6")
Sprite_6:setTag(13)
Sprite_6:setCascadeColorEnabled(true)
Sprite_6:setCascadeOpacityEnabled(true)
Sprite_6:setPosition(100.0000, 96.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(Sprite_6)
layout:setPositionPercentXEnabled(true)
layout:setPositionPercentYEnabled(true)
layout:setPositionPercentX(0.5000)
layout:setPositionPercentY(0.8000)
layout:setPercentWidth(0.7700)
layout:setPercentHeight(0.3500)
layout:setSize({width = 154.0000, height = 42.0000})
layout:setLeftMargin(23.0000)
layout:setRightMargin(23.0000)
layout:setTopMargin(3.0000)
layout:setBottomMargin(75.0000)
Sprite_6:setBlendFunc({src = 1, dst = 771})
Panel_1:addChild(Sprite_6)

--Create number_text
local number_text = ccui.Text:create()
number_text:ignoreContentAdaptWithSize(true)
number_text:setTextAreaSize({width = 0, height = 0})
number_text:setFontSize(36)
number_text:setString([[0]])
number_text:setTextHorizontalAlignment(1)
number_text:setTextVerticalAlignment(1)
number_text:setLayoutComponentEnabled(true)
number_text:setName("number_text")
number_text:setTag(14)
number_text:setCascadeColorEnabled(true)
number_text:setCascadeOpacityEnabled(true)
number_text:setPosition(97.0190, 42.8664)
layout = ccui.LayoutComponent:bindLayoutComponent(number_text)
layout:setPositionPercentX(0.4851)
layout:setPositionPercentY(0.3572)
layout:setPercentWidth(0.0900)
layout:setPercentHeight(0.3000)
layout:setSize({width = 18.0000, height = 36.0000})
layout:setLeftMargin(88.0190)
layout:setRightMargin(93.9810)
layout:setTopMargin(59.1336)
layout:setBottomMargin(24.8664)
Panel_1:addChild(number_text)

--Create start_btn
local start_btn = ccui.Button:create()
start_btn:ignoreContentAdaptWithSize(false)
start_btn:loadTextureNormal("Scene/res/start_btn.png",0)
start_btn:loadTexturePressed("Scene/res/start_btn.png",0)
start_btn:loadTextureDisabled("Scene/res/start_btn.png",0)
start_btn:setTitleFontSize(14)
start_btn:setTitleColor({r = 65, g = 65, b = 70})
start_btn:setScale9Enabled(true)
start_btn:setCapInsets({x = 15, y = 11, width = 286, height = 128})
start_btn:setLayoutComponentEnabled(true)
start_btn:setName("start_btn")
start_btn:setTag(8)
start_btn:setCascadeColorEnabled(true)
start_btn:setCascadeOpacityEnabled(true)
start_btn:setPosition(375.0000, 341.0400)
layout = ccui.LayoutComponent:bindLayoutComponent(start_btn)
layout:setPositionPercentX(0.5000)
layout:setPositionPercentY(0.2100)
layout:setPercentWidth(0.4213)
layout:setPercentHeight(0.0924)
layout:setSize({width = 316.0000, height = 150.0000})
layout:setLeftMargin(217.0000)
layout:setRightMargin(217.0000)
layout:setTopMargin(1207.9600)
layout:setBottomMargin(266.0400)
Scene:addChild(start_btn)

--Create Button_1
local Button_1 = ccui.Button:create()
Button_1:ignoreContentAdaptWithSize(false)
Button_1:loadTextureNormal("Default/Button_Normal.png",0)
Button_1:loadTexturePressed("Default/Button_Press.png",0)
Button_1:loadTextureDisabled("Default/Button_Disable.png",0)
Button_1:setTitleFontSize(14)
Button_1:setTitleText("Button")
Button_1:setTitleColor({r = 65, g = 65, b = 70})
Button_1:setScale9Enabled(true)
Button_1:setCapInsets({x = 15, y = 11, width = 16, height = 14})
Button_1:setLayoutComponentEnabled(true)
Button_1:setName("Button_1")
Button_1:setTag(12)
Button_1:setCascadeColorEnabled(true)
Button_1:setCascadeOpacityEnabled(true)
Button_1:setPosition(130.0000, 878.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(Button_1)
layout:setPositionPercentX(0.1733)
layout:setPositionPercentY(0.5406)
layout:setPercentWidth(0.0613)
layout:setPercentHeight(0.0222)
layout:setSize({width = 46.0000, height = 36.0000})
layout:setLeftMargin(107.0000)
layout:setRightMargin(597.0000)
layout:setTopMargin(728.0000)
layout:setBottomMargin(860.0000)
Scene:addChild(Button_1)

--Create Animation
result['animation'] = ccs.ActionTimeline:create()
  
result['animation']:setDuration(0)
result['animation']:setTimeSpeed(1.0000)
--Create Animation List

result['root'] = Scene
return result;
end

return Result

