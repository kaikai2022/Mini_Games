//
//  GoogleAdModSDK.h
//  MyLuaGame-mobile
//
//  Created by Lucus on 15/8/2022.
//
#import "RootViewController.h"
@class GADBannerView;


@interface GoogleAdModSDK:NSObject{
    
}
+(void)initGoogleAdModeSDK:(RootViewController *) rootViewController;
+(void)showBannerView;
+(void)hideBannerView;
@property(nonatomic, strong) GADBannerView *bannerView;
+(void)loadRewardedAd;
+(void)showVideo:(NSDictionary *)dic;
@end
