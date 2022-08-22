/****************************************************************************
 Copyright (c) 2010-2013 cocos2d-x.org
 Copyright (c) 2013-2016 Chukong Technologies Inc.
 
 http://www.cocos2d-x.org
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 ****************************************************************************/
#import <UIKit/UIKit.h>
#import "AppController.h"
#import "cocos2d.h"
#import "AppDelegate.h"
#import "RootViewController.h"
#import "MainManager.h"
#import "../../../../../shunwocommon/Classes/MainManager.h"
#import <GoogleMobileAds/GoogleMobileAds.h>
#if defined(_ADD_A_SDK_FOR_PAY_)
#import <AlipaySDK/AlipaySDK.h>
#endif

#define IOS10_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0)
#define IOS8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define IOS7_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)

@implementation AppController

@synthesize window;

#pragma mark -
#pragma mark Application lifecycle

// cocos2d application instance
static AppDelegate s_sharedApplication;

static bool isLuaInit = false;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[GADMobileAds sharedInstance] startWithCompletionHandler:nil];//初始化 google AD
    [[MainManager getInstance] setup];
    cocos2d::Application *app = cocos2d::Application::getInstance();

    if (!IOS7_OR_LATER) {
        //检查push参数
        NSDictionary *message = launchOptions[UIApplicationLaunchOptionsRemoteNotificationKey];
        if (message) {
            [self checkPushArgs:message];
        }
    }

    // Initialize the GLView attributes
    app->initGLContextAttrs();
    cocos2d::GLViewImpl::convertAttrs();

    //注册推送
    [self replyPushNotificationAuthorization:application];

    // Override point for customization after application launch.

    // Add the view controller's view to the window and display.
    window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    // Use RootViewController to manage CCEAGLView
    _viewController = [[RootViewController alloc] initWithNibName:nil bundle:nil];
    _viewController.wantsFullScreenLayout = YES;

    // Set RootViewController to window
    if ([[UIDevice currentDevice].systemVersion floatValue] < 6.0) {
        // warning: addSubView doesn't work on iOS6
        [window addSubview:_viewController.view];
    } else {
        // use this method on ios6
        [window setRootViewController:_viewController];
    }

//    window.windowLevel = UIWindowLevelAlert;
//    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];//屏幕常亮
    [window makeKeyAndVisible];

    // IMPORTANT: Setting the GLView should be done after creating the RootViewController
    cocos2d::GLView *glview = cocos2d::GLViewImpl::createWithEAGLView((__bridge void *) _viewController.view);
    cocos2d::Director::getInstance()->setOpenGLView(glview);

#ifdef CONFUSE_RES_PACKAGE
    //还原资源
    [self RevertResources:CONFUSE_RES_PACKAGE];
#endif
    
    //run the cocos2d-x game scene
    app->run();

    
//    NSLog(@"cur_设备方向_初始化：%ld",  [[UIApplication sharedApplication] statusBarOrientation]);
    if([[UIApplication sharedApplication] statusBarOrientation]==3)
    {
        [MainManager getInstance].viewCurDirection = @"left";
    }
    else
    {
        [MainManager getInstance].viewCurDirection = @"right";
    }
    
    isLuaInit = true;
    return YES;
}

- (void) RevertResources:(NSString*)configName
{
    NSFileManager* fileManager = [NSFileManager defaultManager];
    NSBundle * bundle = [NSBundle mainBundle];
    NSString* configPath = [bundle pathForResource:configName ofType:nil];
    NSLog(@"配置路径：%@",configPath);
    NSArray *docpaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [docpaths objectAtIndex:0];
    NSString *updateDir = [NSString stringWithFormat:@"%@/updatez/",documentsDirectory];
    BOOL isUpdateDirExist;
    
    //update目录存在的情况得判断是否包名称是否一样,由于重新安装bundleTag会改变，所以必须删除updatez，否则软链接文件实效
    NSString* bundleTag = [[[bundle bundlePath] stringByDeletingLastPathComponent] lastPathComponent];
    NSLog(@"当前包的标签%@",bundleTag);
    NSString* lastbundleTag = [[NSUserDefaults standardUserDefaults] stringForKey:@"lastbundleTag"];
    if(lastbundleTag != NULL)
    {
        NSLog(@"上个包的标签%@",lastbundleTag);
        if(![bundleTag isEqualToString:lastbundleTag])
        {
            //不相等则需要删除updatez
            [fileManager removeItemAtPath:updateDir error:nil];
        }
    }
    [[NSUserDefaults standardUserDefaults] setObject:bundleTag forKey:@"lastbundleTag"];
    
    if(![fileManager fileExistsAtPath:updateDir isDirectory:&isUpdateDirExist])
    {
        //判断update目录是否存在,不存在就创建
        if(![fileManager createDirectoryAtPath:updateDir withIntermediateDirectories:YES attributes:nil error:nil]){ return; }
    }
    
    //判断updatez是否存在配置文件，存在则不需要重新还原
    NSString* configFinishPath = [NSString stringWithFormat:@"%@%@",updateDir,configName];
    if([fileManager fileExistsAtPath:configFinishPath]){ return; }
    
    //读取配置
    if([fileManager fileExistsAtPath:configPath])
    {
        NSData * data = [NSData dataWithContentsOfFile:configPath];
        NSString * content = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSArray* arr = [content componentsSeparatedByString:@"\n"];
        
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:10];
        NSNumber* numb = [NSNumber numberWithBool:YES];
        NSError* err;
        for (NSString* line in arr) {
            NSArray* strs = [line componentsSeparatedByString:@"|"];
            if([strs count] >= 2)
            {
                //还原文件
                NSString* targetPath = [NSString stringWithFormat:@"%@%@",updateDir,strs[0]];
                NSString* sourcePath = [NSString stringWithFormat:@"%@/%@",[bundle resourcePath],strs[1]];
                
                if(![fileManager fileExistsAtPath:targetPath])
                {
                    //直接拷贝
                    NSString* headerDir = [targetPath stringByDeletingLastPathComponent];
                    if ([dic objectForKey:headerDir] == nil)
                    {
                        if(![fileManager fileExistsAtPath:headerDir])
                        {
                            [fileManager createDirectoryAtPath:headerDir withIntermediateDirectories:YES attributes:nil error:nil];
                        }
                        [dic setObject:numb forKey:headerDir];
                    }
                    //if(![fileManager copyItemAtPath:sourcePath toPath:targetPath error:nil]){ NSLog(@"拷贝失败"); }
                    if(![fileManager createSymbolicLinkAtPath:targetPath withDestinationPath:sourcePath error:&err])
                    {
                        NSLog(@"%@",[err description]);
                    }
                }
            }
        }
        
        //写入配置文件
        NSString* configheaderDir = [configFinishPath stringByDeletingLastPathComponent];
        if(![fileManager fileExistsAtPath:configheaderDir])
        {
            [fileManager createDirectoryAtPath:configheaderDir withIntermediateDirectories:YES attributes:nil error:nil];
        }
        if(![fileManager copyItemAtPath:configPath toPath:configFinishPath error:&err])
        {
            NSLog(@"写入版本文件失败：%@",[err description]);
        }else
        {
            NSLog(@"写入版本文件成功");
        }
    }
}

static NSString *_cacheRedeemCode = @"";
+ (NSString *) getRedeemCode{
    return _cacheRedeemCode;
}

// 仅支持iOS9以上系统，iOS8及以下系统不会回调
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options {
#if defined(_ADD_A_SDK_FOR_PAY_)
    if ([url.host isEqualToString:@"safepay"]) {
        // 支付跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            [MainManager rechargeCallBack:resultDic];
        }];
        
        // 授权跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
            [MainManager authAliCallBack: resultDic];
        }];
        return YES;
    }
#endif
    if ([url.host isEqualToString:@"redeemcode"]) {
        // 走兑换码流程
        if(isLuaInit)
        {
            [MainManager callRedeemCode:url.query];
        }
        else
        {
            _cacheRedeemCode = url.query;
        }
        return YES;
    }
    return [WXApi handleOpenURL:url delegate:[MainManager getInstance]];
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
#if defined(_ADD_A_SDK_FOR_PAY_)
    if ([url.host isEqualToString:@"safepay"]) {
        // 支付跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            [MainManager rechargeCallBack:resultDic];
        }];
        
        // 授权跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
            [MainManager authAliCallBack: resultDic];
        }];
        return YES;
    }
#endif
    if ([url.host isEqualToString:@"redeemcode"]) {
        // 走兑换码流程
        if(isLuaInit)
        {
            [MainManager callRedeemCode:url.query];
        }
        else
        {
            _cacheRedeemCode = url.query;
        }
        return YES;
    }
    
    return [WXApi handleOpenURL:url delegate:[MainManager getInstance]];
}

// 支持目前所有iOS系统
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
#if defined(_ADD_A_SDK_FOR_PAY_)
    if ([url.host isEqualToString:@"safepay"]) {
        // 支付跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            [MainManager rechargeCallBack:resultDic];
        }];
        
        // 授权跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
            [MainManager authAliCallBack: resultDic];
        }];
        return YES;
    }
#endif
    if ([url.host isEqualToString:@"redeemcode"]) {
        // 走兑换码流程
        if(isLuaInit)
        {
            [MainManager callRedeemCode:url.query];
        }
        else
        {
            _cacheRedeemCode = url.query;
        }
        return YES;
    }
    return [WXApi handleOpenURL:url delegate:[MainManager getInstance]];
}

- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void(^)(NSArray<id<UIUserActivityRestoring>> * __nullable restorableObjects))restorationHandler {
    
    return [WXApi handleOpenUniversalLink:userActivity delegate:[MainManager getInstance]];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
    // We don't need to call this method any more. It will interrupt user defined game pause&resume logic
    /* cocos2d::Director::getInstance()->pause(); */
    cocos2d::Application::getInstance()->applicationWillResignActive();
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
    // We don't need to call this method any more. It will interrupt user defined game pause&resume logic
    /* cocos2d::Director::getInstance()->resume(); */
    cocos2d::Application::getInstance()->applicationDidBecomeActive();
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
    [[UIApplication sharedApplication] setIdleTimerDisabled:NO];
    cocos2d::Application::getInstance()->applicationDidEnterBackground();
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
    cocos2d::Application::getInstance()->applicationWillEnterForeground();
}

- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}

//shengsmark 下面这里要兼容屏幕旋转时键盘的旋转
//- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {
//    return [self.viewController supportedInterfaceOrientations];
//}


#pragma mark 推送

-(bool) canRegisterNotification{
    return platform_could_register_notification("DTSDKVersion");
}

//推送
- (void)replyPushNotificationAuthorization:(UIApplication *)application {
    
    if(![self canRegisterNotification]){
        return;
    }
    
    if (IOS10_OR_LATER) {
        //iOS 10 later
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        //必须写代理，不然无法监听通知的接收与点击事件
        center.delegate = self;
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert) completionHandler:^(BOOL granted, NSError *_Nullable error) {
            if (!error && granted) {
                //用户点击允许
                NSLog(@"注册成功");
            } else {
                //用户点击不允许
                NSLog(@"注册失败");
            }
        }];

        // 可以通过 getNotificationSettingsWithCompletionHandler 获取权限设置
        //之前注册推送服务，用户点击了同意还是不同意，以及用户之后又做了怎样的更改我们都无从得知，现在 apple 开放了这个 API，我们可以直接获取到用户的设定信息了。注意UNNotificationSettings是只读对象哦，不能直接修改！
        [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings *_Nonnull settings) {
            NSLog(@"========%@", settings);
        }];
    } else if (IOS8_OR_LATER) {
        //iOS 8 - iOS 10系统
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound categories:nil];
        [application registerUserNotificationSettings:settings];
    } else {
        //iOS 8.0系统以下
        [application registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound];
    }
    
    //注册远端消息通知获取device token
    [application registerForRemoteNotifications];
}


- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)pToken {
//    NSString *deviceString = [[pToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
//    deviceString = [deviceString stringByReplacingOccurrencesOfString:@" " withString:@""];
//    std::string str = [deviceString UTF8String];
//    MainManagerCpp::getInstance()->onRegisterForRemoteNotificationsWithDeviceToken(str);
    
    if(pToken != nil)
    {
        NSUInteger length = pToken.length;
        if (length != 0) {
            const unsigned char *buffer = (const unsigned char *)pToken.bytes;
            NSMutableString *hexString  = [NSMutableString stringWithCapacity:(length * 2)];
            for (int i = 0; i < length; ++i) {
                [hexString appendFormat:@"%02x", buffer[i]];
            }
            NSString* token = [hexString copy];
            MainManagerCpp::getInstance()->onRegisterForRemoteNotificationsWithDeviceToken([token UTF8String]);
            NSLog(@"【PUSH - APNs】didRegisterForRemoteNotificationsWithDeviceToken 回调时的原始DeviceToken=%@, 截取后=%@", [pToken description], token);
        }
    }
}


- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"Regist fail%@", error);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [self checkPushArgs:userInfo];
}

- (void)checkPushArgs:(NSDictionary *) userInfo {
    //添加前台显示
//    NSDictionary *apsData = userInfo[@"aps"];
//    if( apsData)
//    {
//        NSString *alertStr = apsData[@"alert"];
//        if(alertStr)
//        {
//            NSLog(@"收到推送消息：%@",alertStr);
//            if ( [UIApplication sharedApplication].applicationState == UIApplicationStateActive)
//            {
//                //如果当前是在前台，那么得手动创建一个推送，否则会看不到有推送信息
//                [self showLocalNotification:alertStr remoteNotificationUserInfo:userInfo];
//            }
//        }
//    }
    //添加推送参数
    NSString *pushArg = userInfo[@"pushArg"];
    if(pushArg)
    {
        NSLog(@"收到推送参数pushArg：%@",pushArg);
        MainManagerCpp::getInstance()->markPushArgStr([pushArg UTF8String]);
    }
}

-(void)showLocalNotification:(NSString *) pushMsg remoteNotificationUserInfo:(NSDictionary *) userInfo
{
    if (IOS10_OR_LATER)
    {
        UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
        content.body = pushMsg;
        content.userInfo = userInfo;
        content.sound = [UNNotificationSound defaultSound];
        [content setValue:@(YES) forKeyPath:@"shouldAlwaysAlertWhileAppIsForeground"];//很重要的设置
        
        UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:@"Notif" content:content trigger:nil];
        [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        }];
        
    } else {
        UILocalNotification *notification = [[UILocalNotification alloc] init];
        notification.fireDate = [NSDate dateWithTimeIntervalSinceNow:0.1];
        notification.repeatInterval = NSCalendarUnitDay;
        notification.alertBody = pushMsg;
        notification.timeZone = [NSTimeZone defaultTimeZone];
        notification.soundName = UILocalNotificationDefaultSoundName;
        [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    }
}

#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
    MainManagerCpp::getInstance()->gc();
}

- (void)showToastInfo:(NSString *)content
{
    [self.window.rootViewController showToastView:1 withContent:content];
}
- (void)showToastWarn:(NSString *)content
{
    [self.window.rootViewController showToastView:2 withContent:content];
}
- (void)showToastError:(NSString *)content
{
    [self.window.rootViewController showToastView:2 withContent:content];
}

- (void)showToast:(NSString *)title withContent:(NSString *)content
{
    [self.window.rootViewController E_showToastInfo:title withContent:content onParent:self.window];
}

- (void)showRotationIndicator
{
    [self.window.rootViewController showRotationIndicator];
}

- (void) showUserDefineToast_OK:(NSString *)hintText
{
    [self showUserDefineToast_OK:hintText atHide:nil];
}
- (void) showUserDefineToast_OK:(NSString *)hintText atHide:(void (^)(void))complete
{
    //    [BasicTool showUserDefintToast:hintText
    //                              view:self.window
    //     // Toast消失时的回调
    //                            atHide:^(void){
    //                                // 并在Toast消失时退出添加好友界面
    //                                if(complete)
    //                                    complete();
    //                            }];
}

- (void) showGlobalHUD:(BOOL)show
{
    //    if(show)
    //        [MBProgressHUD showHUDAddedTo:self.window animated:NO];
    //    else
    //        [MBProgressHUD hideHUDForView:self.window animated:NO];
}

- (void)showLocalPush:(NSString *)title body:(NSString *)body withIdentifier:(NSString *)ident playSoud:(BOOL)sound
{}

#if __has_feature(objc_arc)
#else

- (void)dealloc {
    [window release];
    [_viewController release];
    [super dealloc];
}

#endif


@end
