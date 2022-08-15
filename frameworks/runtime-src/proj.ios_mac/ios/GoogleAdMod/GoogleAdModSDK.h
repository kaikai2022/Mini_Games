//
//  GoogleAdModSDK.h
//  MyLuaGame-mobile
//
//  Created by Lucus on 15/8/2022.
//
@class GADBannerView;


@interface GoogleAdModSDK:NSObject{
    
}
+ (void)initGoogleAdBannerView:(GADBannerView *)bannerView;
+(void)showBannerView;
+(void)hideBannerView;
@property(nonatomic, strong) GADBannerView *bannerView;

@end
