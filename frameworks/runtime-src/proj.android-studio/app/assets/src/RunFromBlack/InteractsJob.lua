
local UnmarshalStream = {
    Z_ORDER_BG = -10,               -- 游戏背景图的Z Order，父节点为mainNode
    Z_ORDER_UI = 10,                -- 游戏UI主节点的Z Order，父节点为mainNode
    Z_ORDER_CLICK_EFFECT = 9999,    -- 点击特效Z Order，父节点为mainNode
}
return UnmarshalStream