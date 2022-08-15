--固定句式
local targetPlatform = cc.Application:getInstance():getTargetPlatform()
--把样例内容替换成自己SDK的名字
local Cocos2dxiOSLuaSDK = class("Cocos2dxiOSLuaSDK")

--格式为上面声明的名字:函数名 命名无特殊要求，但是此处函数名是cocos2dx开发者会看到并调用的，请做到一眼就能明白作用的效果
function Cocos2dxiOSLuaSDK:showDetailPageWithProductId(productId, callback)
	print("call showDetailPageWithProductId start")
	if (cc.PLATFORM_OS_ANDROID == targetPlatform) then
        --此处为安卓SDK调用逻辑，因为对于cocos2dx开发者而言，不关心是什么平台
        --所以需要实现lua调用一个函数自动识别平台并调用对应SDK的目的（安卓/iOS 共用一个lua桥接文件），此处需要给安卓开发者预留空间
	end
    if (cc.PLATFORM_OS_IPHONE == targetPlatform) or (cc.PLATFORM_OS_IPAD == targetPlatform) then --固定句式
        local luaoc = require "cocos.cocos2d.luaoc" --固定句式
        local args = {productId = productId, functionId = callback} --参数只能传字典或者不传,此处传入的回调函数并非函数而只是个标识符
        --前面是固定句式，第一个参数是OC桥接文件的类名，第二个参数是OC桥接文件中想要调用的方法名，第三个参数是传入的字典
        local ok, ret = luaoc.callStaticMethod("Cocos2dxiOSLuaSDKBridge","Cocos2dxiOSLuaSDKBridgeSelector",args)
        if not ok then
            print("luaoc showDetailPageWithProductId error:"..ret)
        end
    end
end

function Cocos2dxiOSLuaSDK:showDetailPage()
	print("call showDetailPage start")
	if (cc.PLATFORM_OS_ANDROID == targetPlatform) then

	end
    if (cc.PLATFORM_OS_IPHONE == targetPlatform) or (cc.PLATFORM_OS_IPAD == targetPlatform) then
        local luaoc = require "cocos.cocos2d.luaoc"
        local ok, ret = luaoc.callStaticMethod("Cocos2dxiOSLuaSDKBridge","Cocos2dxiOSLuaSDKBridgeNoParameterSelector")
        if not ok then
            print("luaoc showDetailPage error:"..ret)
        end
    end
end



function Cocos2dxiOSLuaSDK:hideGodAdBannerView()
    if (cc.PLATFORM_OS_ANDROID == targetPlatform) then

    end
    if (cc.PLATFORM_OS_IPHONE == targetPlatform) or (cc.PLATFORM_OS_IPAD == targetPlatform) then
        local luaoc = require "cocos.cocos2d.luaoc"
        local ok, ret = luaoc.callStaticMethod("GoogleAdModSDK","hideBannerView")
        if not ok then
            print("luaoc showDetailPage error:"..ret)
        end
    end
end

function Cocos2dxiOSLuaSDK:showGodAdBannerView()
    if (cc.PLATFORM_OS_ANDROID == targetPlatform) then

    end
    if (cc.PLATFORM_OS_IPHONE == targetPlatform) or (cc.PLATFORM_OS_IPAD == targetPlatform) then
        local luaoc = require "cocos.cocos2d.luaoc"
        local ok, ret = luaoc.callStaticMethod("GoogleAdModSDK","showBannerView")
        if not ok then
            print("luaoc showDetailPage error:"..ret)
        end
    end
end

return Cocos2dxiOSLuaSDK
