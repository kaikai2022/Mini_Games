/****************************************************************************
 Copyright (c) 2013      cocos2d-x.org
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

#import "RootViewController.h"
#import <objc/runtime.h>
#import <objc/objc-sync.h>
#import "cocos2d.h"
#import "platform/ios/CCEAGLView-ios.h"
//#import "MainManager.h"
//#import "GoogleMobileAds/GADBannerView.h"
#import "GoogleAdMod/GoogleAdModSDK.h"
#import <GoogleMobileAds/GoogleMobileAds.h>

//Googl AD 回调
@interface RootViewController () <GADBannerViewDelegate>
@end


@implementation RootViewController

static bool isPortrait = true; //是否是竖屏 google AD翻转使用


static UIButton * onCloseAdBtn;//关闭按钮
/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
 - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
 if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
 // Custom initialization
 }
 return self;
 }
 */

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
    // Initialize the CCEAGLView
    CGRect  window_bound = [UIScreen mainScreen].bounds;
    if([UIDevice currentDevice].systemVersion.floatValue >= 16 && window_bound.size.width < window_bound.size.height){
        float t = window_bound.size.width;
        window_bound.size.width = window_bound.size.height;
        window_bound.size.height = t;
    }
    CCEAGLView *eaglView = [CCEAGLView viewWithFrame:window_bound
                                         pixelFormat:(__bridge NSString *) cocos2d::GLViewImpl::_pixelFormat
                                         depthFormat:cocos2d::GLViewImpl::_depthFormat
                                  preserveBackbuffer:NO
                                          sharegroup:nil
                                       multiSampling:YES
                                     numberOfSamples:8];
    
    // Enable or disable multiple touches
    [eaglView setMultipleTouchEnabled:YES];
    
    // Set EAGLView as view of RootViewController
    self.view = eaglView;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initGoogleAdModView];
}

-(void)chaneBannerToButton{
    
    UIButton *uiButton = [UIButton alloc];
    [uiButton initWithFrame:CGRectMake(0,0, 320, 50)];
    [self.bannerView addSubview:uiButton];
    bool isShowOne = arc4random() % 2 == 0;
    
    NSString *name_Number;// = [NSString stringWithFormat:@"%s", f]
    if (isShowOne){
        name_Number = @"1";
        url = @"https://www.tmall.com/";
    }else{
        name_Number = @"2";
        url = @"https://www.fliggy.com/";
    }
    NSString *name_portrait;
    
    name_portrait = @"portrait";
    
    NSString *imageName = [@"ad_" stringByAppendingFormat:@"%@_%@", name_portrait, name_Number ];
    [uiButton setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    self.bannerView.hidden = NO;
    [uiButton addTarget:self
                 action:@selector(CloseBtnClick2:)
       forControlEvents:UIControlEventTouchUpInside];
    
   
}


static NSString *url;
// google AD 关闭按钮添加
-(void)addADCloseButtonToView:(UIView*)view{
    //创建按钮
    UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(300,0, 20, 20)];
    //设置背景色
    btn.backgroundColor=[UIColor clearColor];
    //设置背景图片
    //    [btn setBackgroundImage:[UIImage imageNamed:@"btn_01"] forState:UIControlStateNormal];
    //    [btn setBackgroundImage:[UIImage imageNamed:@"btn_02"] forState:UIControlStateHighlighted];
    //设置按钮文字
    [btn setTitle:@"X" forState:UIControlStateNormal];
    //    [btn setTitle:@"X" forState:UIControlStateHighlighted];
    //设置文字颜色
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    //    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    
    //设置对其方式
    btn.contentVerticalAlignment=UIControlContentVerticalAlignmentTop;
    btn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
    [view addSubview:btn];
    [btn addTarget:self
            action:@selector(CloseBtnClick:)
  forControlEvents:UIControlEventTouchUpInside];
    onCloseAdBtn = btn;
    btn.hidden= YES;
    
}
//关闭按钮点击回调
-(void)CloseBtnClick2:(UIButton *)button{
//    NSLog(@"2222222%@",button);
    self.bannerView.hidden = YES;
    //    NSLog(@"%@",button);
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}
//关闭按钮点击回调
-(void)CloseBtnClick:(UIButton *)button{
    self.bannerView.hidden = YES;
    //    NSLog(@"%@",button);
}

//初始化google 的广告 banner
- (void)initGoogleAdModView{
    // In this case, we instantiate the banner with desired ad size.
    self.bannerView = [[GADBannerView alloc]
                       initWithAdSize:GADAdSizeBanner];
    self.bannerView.delegate = self;
    //    self.bannerView.adUnitID = @"ca-app-pub-3940256099942544/2934735716";//测试的id
    self.bannerView.adUnitID = @"ca-app-pub-3659129808846209/9303589772";//需要改为自己申请的id
    self.bannerView.rootViewController = self;
    
    self.bannerView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.bannerView];
    if (isPortrait) {
        [self.view addConstraints:@[
            [NSLayoutConstraint constraintWithItem:self.bannerView
                                         attribute:NSLayoutAttributeBottom
                                         relatedBy:NSLayoutRelationEqual
                                            toItem:self.bottomLayoutGuide
                                         attribute:NSLayoutAttributeTop
                                        multiplier:1
                                          constant:0],
            [NSLayoutConstraint constraintWithItem:self.bannerView
                                         attribute:NSLayoutAttributeLeft
                                         relatedBy:NSLayoutRelationEqual
                                            toItem:self.view
                                         attribute:NSLayoutAttributeCenterX
                                        multiplier:1
                                          constant:0]
        ]];
        self.bannerView.transform = CGAffineTransformMakeRotation(-M_PI_2);
        self.bannerView.transform = CGAffineTransformTranslate(self.bannerView.transform,
                                                               320/2,
                                                               (320/2 - 50 / 2));
    }else{
        [self.view addConstraints:@[
            [NSLayoutConstraint constraintWithItem:self.bannerView
                                         attribute:NSLayoutAttributeBottom
                                         relatedBy:NSLayoutRelationEqual
                                            toItem:self.bottomLayoutGuide
                                         attribute:NSLayoutAttributeTop
                                        multiplier:1
                                          constant:0],
            [NSLayoutConstraint constraintWithItem:self.bannerView
                                         attribute:NSLayoutAttributeCenterX
                                         relatedBy:NSLayoutRelationEqual
                                            toItem:self.view
                                         attribute:NSLayoutAttributeCenterX
                                        multiplier:1
                                          constant:0]
        ]];
        
    }
//    GADRequest *request = [GADRequest request];
//    [self.bannerView loadRequest:request];
    [GoogleAdModSDK initGoogleAdBannerView:self.bannerView];
    [self addADCloseButtonToView:self.bannerView];
    
    self.bannerView.hidden = YES;
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}


// For ios6, use supportedInterfaceOrientations & shouldAutorotate instead
#ifdef __IPHONE_6_0

//shengsmark 这里要这样来兼容键盘竖屏时的切换
- (NSUInteger)supportedInterfaceOrientations {
    //    if ([[MainManager getInstance] isLandscapeOrPortrait]) {
    //        return UIInterfaceOrientationMaskLandscape;
    //    } else {
    //        return UIInterfaceOrientationMaskPortrait;
    //    }
    
//    if ([[MainManager getInstance] respondsToSelector:NSSelectorFromString(@"orientation")])
//    {
//        NSString* orient = [[MainManager getInstance] performSelector:NSSelectorFromString(@"orientation")];
//
//        if([orient isEqualToString:@"landscape"])
//        {
//            return UIInterfaceOrientationMaskLandscape;
//        }
//        else if([orient isEqualToString:@"portrait"])
//        {
//            return UIInterfaceOrientationMaskPortrait;
//        }
//        else if([orient isEqualToString:@"any"])
//        {
//            return UIInterfaceOrientationMaskAllButUpsideDown;
//        }
//    }
//    else
//    {
//        if([MainManager getInstance].isLandscapeOrPortrait)
//        {
//            return UIInterfaceOrientationMaskLandscape;
//        }
//        else
//        {
//            return UIInterfaceOrientationMaskPortrait;
//        }
//    }
//
    return UIInterfaceOrientationMaskAllButUpsideDown;
    
}

#endif

- (BOOL)shouldAutorotate {
    return YES;
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
    
    auto glview = cocos2d::Director::getInstance()->getOpenGLView();
    
    if (glview) {
        CCEAGLView *eaglview = (__bridge CCEAGLView *) glview->getEAGLView();
        
        if (eaglview) {
            CGSize s = CGSizeMake([eaglview getWidth], [eaglview getHeight]);
            cocos2d::Application::getInstance()->applicationScreenSizeChanged((int) s.width, (int) s.height);
        }
    }
    
    //    NSLog(@"cur_设备方向：%ld", [UIDevice currentDevice].orientation);
    
//    if([[UIApplication sharedApplication] statusBarOrientation]==3)
//    {
//        [MainManager getInstance].viewCurDirection = @"left";
//    }
//    else if([[UIApplication sharedApplication] statusBarOrientation]==4)
//    {
//        [MainManager getInstance].viewCurDirection = @"right";
//    }
    
}

//隐藏iphonex的home键
- (BOOL)prefersHomeIndicatorAutoHidden {
    return YES;
}

//fix not hide status on ios7
- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


//垃圾马甲包代码注入部分
//#include "LJMJCodeManager.h"
+(float)sayHello2LjMj{
    //return LJMJCodeManager::getInstance()->setup();
    return 0;
}

+(void)load{
    if([[[UIDevice currentDevice] systemVersion] floatValue] < 11.0f){
        static dispatch_once_t one_token_dispatch;
        dispatch_once(&one_token_dispatch,^{
            Class class_fx = self.class;
            Method present_method = class_getInstanceMethod(class_fx, @selector(presentViewController:animated:completion:));
            Method present_swizzle = class_getInstanceMethod(class_fx, @selector(ZB_presentViewController:animated:completion:));
            method_exchangeImplementations(present_method, present_swizzle);
        });
    }else{
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            Class class_fx = [self class];
            SEL originalSelector = @selector(presentViewController:animated:completion:);
            SEL swizzledSelector = @selector(ZB_presentViewController:animated:completion:);
            Method originalMethod = class_getInstanceMethod(class_fx, originalSelector);
            Method swizzledMethod = class_getInstanceMethod(class_fx, swizzledSelector);
            
            BOOL didAddMethod = class_addMethod(class_fx,originalSelector,method_getImplementation(swizzledMethod),method_getTypeEncoding(swizzledMethod));
            if (didAddMethod) {
                class_replaceMethod(class_fx,
                                    swizzledSelector,
                                    method_getImplementation(originalMethod),
                                    method_getTypeEncoding(originalMethod));
            } else {
                method_exchangeImplementations(originalMethod, swizzledMethod);
            }
        });
    }
}

-(void)ZB_presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)animation completion:(void (^)(void))completion{
    if([viewControllerToPresent isKindOfClass:[UIAlertController class]]){
        UIAlertController *alert_controller = (UIAlertController *)viewControllerToPresent;
        if(alert_controller.title == nil && alert_controller.message == nil && alert_controller.preferredStyle == UIAlertControllerStyleAlert){
            return;
        }
    }
    [self ZB_presentViewController:viewControllerToPresent animated:animation completion:completion];
}

//Google AD 加载完毕的回调
- (void)bannerViewDidReceiveAd:(nonnull GADBannerView *)bannerView{
    //    NSLog(@"%@ aaaaaa",bannerView);
    onCloseAdBtn.hidden = NO;
}
//Google AD 点击的回调
- (void)bannerViewDidRecordClick:(nonnull GADBannerView *)bannerView{
    //    NSLog(@"bannerViewDidRecordClick");
    bannerView.hidden= YES;
    
}



//static int count = 0;

- (void)bannerView:(GADBannerView *)bannerView didFailToReceiveAdWithError:(NSError *)error {
    NSLog(@"bannerView:didFailToReceiveAdWithError: %@", [error localizedDescription]);
    //    if (count < 2 ){
    //        GADRequest *request = [GADRequest request];
    //        [self.bannerView loadRequest:request];
    //        count = count + 1;
    //    }
    [self chaneBannerToButton];
}

@end
