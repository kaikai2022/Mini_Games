//
//  GoogleAdModSDK.m
//  MyLuaGame-mobile
//
//  Created by Lucus on 15/8/2022.
//
#import "GoogleAdModSDK.h"
#import <GoogleMobileAds/GoogleMobileAds.h>
#import "cocos2d.h"
#include "scripting/lua-bindings/manual/CCLuaEngine.h"
#if (CC_TARGET_PLATFORM == CC_PLATFORM_IOS || CC_TARGET_PLATFORM == CC_PLATFORM_MAC)
#include "scripting/lua-bindings/manual/platform/ios/CCLuaObjcBridge.h"
#endif
USING_NS_CC;

@interface GoogleAdModSDK()<NSCopying,NSMutableCopying>

@end

static GoogleAdModSDK * googleAdSdk = nil;

@implementation GoogleAdModSDK

+ (instancetype)GoogleAdModSDK{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        googleAdSdk = [[self alloc]init];
    });
    return googleAdSdk;
}

+ (id)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        googleAdSdk = [super allocWithZone:zone];
    });
    return googleAdSdk;
}
- (nonnull id)copyWithZone:(nullable NSZone *)zone {
    return googleAdSdk;
}

- (nonnull id)mutableCopyWithZone:(nullable NSZone *)zone {
    return googleAdSdk;
}

+(void)initGoogleAdBannerView:(GADBannerView *)bannerView{
    //    [GoogleAdModSDK GoogleAdModSDK]
    //    gas.showBannerView
    //    GoogleAdModSDK* sdk = [GoogleAdModSDK new];
//    gadView = bannerView;
    [GoogleAdModSDK GoogleAdModSDK].bannerView = bannerView;
}

+(void)showBannerView{
    //    [GoogleAdModSDK GoogleAdModSDK].self.bannerView.hidden = YES;
//    [GoogleAdModSDK GoogleAdModSDK].bannerView.hidden = NO;
    NSLog(@"这里才开始请求加载 GoogleAD广告");
    [[GoogleAdModSDK GoogleAdModSDK].bannerView loadRequest:[GADRequest request]];
}

+(void)hideBannerView{
    [GoogleAdModSDK GoogleAdModSDK].bannerView.hidden = YES;
}


//+(void)Cocos2dxiOSLuaSDKBridgeSelector:(NSDictionary *)dic{
//
//    NSString *productId = dic[@"productId"];
//
//    [Cocos2dxiOSLuaSDK showDetailPageWithProductId:productId];
//
//    //以下为OC根据传入的函数ID回调lua函数的逻辑
//    int functionId = [[dic objectForKey:@"functionId"] intValue];
//
//    LuaObjcBridge::pushLuaFunctionById(functionId);
//    //将需要传递给 Lua function 的参数放入 Lua stack
//
//    //返回参数，注意必须进行utf-8转换否则编译报错，如要传递多个参数请将此处字符串转为json字符串传递
//    LuaObjcBridge::getStack()->pushString([[NSString stringWithFormat:@"productId=%@", productId] UTF8String]);
//    LuaObjcBridge::getStack()->executeFunction(1);//1个参数
//    LuaObjcBridge::releaseLuaFunctionById(functionId);//释放
//}
//
//+(void)Cocos2dxiOSLuaSDKBridgeNoParameterSelector{
//
//  [Cocos2dxiOSLuaSDK showDetailPageWithProductId:nil];
//
//}

@end

