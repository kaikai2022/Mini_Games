//
//  GoogleAdModSDK.m
//  MyLuaGame-mobile
//
//  Created by Lucus on 15/8/2022.
//
//#import <GoogleMobileAds/GADFullScreenContentDelegate.h>
#import "RootViewController.h"
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

@interface GoogleAdModSDK()<GADFullScreenContentDelegate>
@property(nonatomic, strong) GADRewardedAd *rewardedAd;

@property(nonatomic, strong) RootViewController *rootViewController;

@property(nonatomic) int luaRewardedCallbackId;
@end

static GoogleAdModSDK * googleAdSdk = nil;

//static RootViewController * rootViewController = nil;

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

//+(void)initGoogleAdBannerView:(GADBannerView *)bannerView{
//    //    [GoogleAdModSDK GoogleAdModSDK]
//    //    gas.showBannerView
//    //    GoogleAdModSDK* sdk = [GoogleAdModSDK new];
//    //    gadView = bannerView;
//    [GoogleAdModSDK GoogleAdModSDK].bannerView = bannerView;
//}

+(void)initGoogleAdModeSDK:(RootViewController *) rootViewController{
    [GoogleAdModSDK GoogleAdModSDK].bannerView =rootViewController.bannerView;
    [GoogleAdModSDK GoogleAdModSDK].rootViewController = rootViewController;
    [GoogleAdModSDK loadRewardedAd];
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

//加载奖励动画广告
+(void)loadRewardedAd{
    GADRequest *request = [GADRequest request];
    [GADRewardedAd
//     loadWithAdUnitID:@"ca-app-pub-3940256099942544/1712485313" // 这个是测试id
     loadWithAdUnitID:@"ca-app-pub-3659129808846209/9870226679"
     request:request
     completionHandler:^(GADRewardedAd *ad, NSError *error) {
        if (error) {
            NSLog(@"Rewarded ad failed to load with error: %@", [error localizedDescription]);
            return;
        }
        [GoogleAdModSDK GoogleAdModSDK].rewardedAd = ad;
        NSLog(@"Rewarded ad loaded.");
        [GoogleAdModSDK GoogleAdModSDK].rewardedAd.fullScreenContentDelegate = [GoogleAdModSDK GoogleAdModSDK];
    }];
}

+(void)showVideo:(NSDictionary *)dic{
    NSLog(@"奖励广告 显示？？？");
    int functionId = [[dic objectForKey:@"functionId"] intValue];
    
    NSLog(@"%d",functionId);
    GADRewardedAd *rewardedAd = [GoogleAdModSDK GoogleAdModSDK].rewardedAd;
    if ( [GoogleAdModSDK GoogleAdModSDK].rootViewController && rewardedAd && [rewardedAd canPresentFromRootViewController: [GoogleAdModSDK GoogleAdModSDK].rootViewController error:nil]) {
        [rewardedAd presentFromRootViewController: [GoogleAdModSDK GoogleAdModSDK].rootViewController
                         userDidEarnRewardHandler:^{
            GADAdReward *reward = rewardedAd.adReward;
            
            NSString *rewardMessage = [NSString
                                       stringWithFormat:@"Reward received with currency %@ , amount %lf",
                                       reward.type, [reward.amount doubleValue]];
            NSLog(@"%@", rewardMessage);
            // Reward the user for watching the video.
            //                              [self earnCoins:[reward.amount integerValue]];
            //                              self.showVideoButton.hidden = YES;
            [GoogleAdModSDK GoogleAdModSDK].luaRewardedCallbackId =functionId;
        }];
    }else{
        NSLog(@"奖励广告没有准备好");
        LuaObjcBridge::pushLuaFunctionById(functionId);
        //将需要传递给 Lua function 的参数放入 Lua stack
        
        //返回参数，注意必须进行utf-8转换否则编译报错，如要传递多个参数请将此处字符串转为json字符串传递
        LuaObjcBridge::getStack()->pushString([[NSString stringWithFormat:@"%@", @"false"] UTF8String]);
        LuaObjcBridge::getStack()->executeFunction(1);//1个参数
        LuaObjcBridge::releaseLuaFunctionById(functionId);//释放
        
    }
}

/// Tells the delegate that the rewarded ad was dismissed.
- (void)adDidDismissFullScreenContent:(id)ad {
    [GoogleAdModSDK loadRewardedAd];
    NSLog(@"Rewarded ad dismissed.");
    LuaObjcBridge::pushLuaFunctionById([GoogleAdModSDK GoogleAdModSDK].luaRewardedCallbackId);
    //将需要传递给 Lua function 的参数放入 Lua stack
    
    //返回参数，注意必须进行utf-8转换否则编译报错，如要传递多个参数请将此处字符串转为json字符串传递
    LuaObjcBridge::getStack()->pushString([[NSString stringWithFormat:@"%@", @"true"] UTF8String]);
    LuaObjcBridge::getStack()->executeFunction(1);//1个参数
    LuaObjcBridge::releaseLuaFunctionById([GoogleAdModSDK GoogleAdModSDK].luaRewardedCallbackId);//释放
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

