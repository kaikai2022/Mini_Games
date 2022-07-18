local MainScene = class("MainScene", function()
    return cc.Layer:create()
end)
local MiniGameController = require("GuessTheIdiom.MiniGameController")
---@public MainScene.NowLeave int 当前的等级
function MainScene:ctor()
    local rotateNode = cc.Node:create()
    rotateNode:addTo(self)
    rotateNode:setContentSize(cc.size(display.width, display.height))
    rotateNode:setAnchorPoint(cc.p(0.5, 0.5))
    --rotateNode:setRotation(0)
    rotateNode:move(display.cx, display.cy)
    self.rotateNode = rotateNode
    self.gameController = MiniGameController:create(self.rotateNode)

    self.keyListener = cc.EventListenerKeyboard:create()
    --handler(self,self.onKeyboard)用来关联方法，如果方法直接放在当前位置则可以直接使用无需handler
    self.keyListener:registerScriptHandler(handler(self, self.onKeyboard), cc.Handler.EVENT_KEYBOARD_RELEASED)
    local eventDispatch = self:getEventDispatcher()
    eventDispatch:addEventListenerWithSceneGraphPriority(self.keyListener, self)
end

local mExitTime = 0
function MainScene:onKeyboard(code, event)
    if code == cc.KeyCode.KEY_BACK then
        print("按下返回键")
        if ((os.time() - mExitTime) > 2000) then
            -- 如果两次按键时间间隔大于2000毫秒，则不退出

            --Toast.makeText(this, "再按一次退出程序", Toast.LENGTH_SHORT).show();
            mExitTime = os.time();-- 更新mExitTime
            print("再按一次退出程序")
            
        else
            cc.Director:getInstance():endToLua()
        end
    end
end

return MainScene