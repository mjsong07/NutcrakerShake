//
//  AppDelegate.m
//  SoxFrame
//
//  Created by jason yang on 14-02-26.
//  Copyright jason yang 2013年. All rights reserved.
//


#import "AppDelegate.h"   
#import "SOXSoundUtil.h"
#import "GameLayer.h" 
#import "GameCenterManager.h"
#import "ATAppTransferManager.h"
#import "LoadingScreen.h"

@implementation MyRootNavigationController

//此代码 用于处理 当前屏幕只支持竖屏幕显示。。。只有加这个才能竖屏 同时调整页面的默认加载方式为 portrait 竖
-(BOOL)shouldAutorotate
{
    return NO;
}

// The available orientations should be defined in the Info.plist file.
// And in iOS 6+ only, you can override it in the Root View controller in the "supportedInterfaceOrientations" method.
// Only valid for iOS 6+. NOT VALID for iOS 4 / 5.
-(NSUInteger)supportedInterfaceOrientations {
	
	// iPhone only
	if( [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone )
		return UIInterfaceOrientationMaskPortrait;
	
	// iPad only
//	return UIInterfaceOrientationMaskLandscape;
    	return UIInterfaceOrientationMaskPortrait;
}

// Supported orientations. Customize it for your own needs
// Only valid on iOS 4 / 5. NOT VALID for iOS 6.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	// iPhone only
	if( [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone )
		return UIInterfaceOrientationIsLandscape(interfaceOrientation);
	
	// iPad only
	// iPhone only
	return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

// This is needed for iOS4 and iOS5 in order to ensure
// that the 1st scene has the correct dimensions
// This is not needed on iOS6 and could be added to the application:didFinish...
-(void) directorDidReshapeProjection:(CCDirector*)director
{
	if(director.runningScene == nil) {
		// Add the first scene to the stack. The director will draw it immediately into the framebuffer. (Animation is started automatically when the view is displayed.)
		// and add the scene to the stack. The director will run it when it automatically when the view is displayed.
		//[director runWithScene: [IntroLayer scene]];
        //修改此处  改变第一个页面跳转
        //[[CCDirector sharedDirector] runWithScene: [SceneSwitch showScene:T_SCENE_GAME_LAYER]];
        
        [[CCDirector sharedDirector] runWithScene: [LoadingScreen scene]];
	}
}

- (void)viewDidLoad
{
    [super viewDidLoad];  
	[self initGAD];//初始化 admob
    [self initAppTransferManager];//初始化 应用互推
    [self hiddenGAD];//默认隐藏
    /* if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)) {
            self.edgesForExtendedLayout = UIRectEdgeTop;
            self.extendedLayoutIncludesOpaqueBars = NO;
            self.modalPresentationCapturesStatusBarAppearance = NO;
    }*/
    
}
- (BOOL)prefersStatusBarHidden
{
    return YES;
}

//初始化 应用互推
- (void)initAppTransferManager
{
    [ATAppTransferManager setAppId:G_KEY_AT_APPKEY_NUTCRACKER];//初始化 应用互推
    UIColor *color =   [UIColor colorWithRed:((float) 231 / 255.0f)
                                       green:((float) 133 / 255.0f)
                                        blue:((float) 16 / 255.0f) alpha:1.0f];
    [ATAppTransferManager setBackColor:color];
    [ATAppTransferManager setAppBorderColor:[UIColor whiteColor]];
    [ATAppTransferManager setAppChangeInterval:5];
    if(G_IS_IPAD){
        CGRect  rect = CGRectMake(0,0, 640, 100);
        [ATAppTransferManager setTransferViewFrame:rect];
    }
}


- (void)initGAD
{
    CGRect rect;
    if(G_IS_IPAD){
          rect = CGRectMake(0,0,//可以设置你广告的位置
                                 GAD_SIZE_728x90.width,
                                 GAD_SIZE_728x90.height); 
//        return CGSizeMake(640, 960);
        
    }else{
          rect = CGRectMake(0,0,//可以设置你广告的位置
                                 GAD_SIZE_320x50.width,
                                 GAD_SIZE_320x50.height);
    }
    //[SOXDebug logPonit:rect.origin];
    //创建一个标准大小的屏幕
    bannerView_ = [[GADBannerView alloc] initWithFrame:rect];
    bannerView_.delegate = self;
    //指定广告的“单位标识符”。这是您的AdMob的发布者
    bannerView_.adUnitID = G_KEY_AD_ADMOB;
    //用户的广告，将它添加到视图
    [bannerView_ setRootViewController:self];
    [self.view addSubview:bannerView_];
    
    //启动一个通用请求加载广告。
    [bannerView_ loadRequest:[GADRequest request]];
}

//客户端接收到广告后调用
- (void)removeGAD
{
    if(bannerView_!=nil){
     [bannerView_ removeFromSuperview];
    } 
}


//隐藏广告
- (void)hiddenGAD
{
    if(bannerView_!=nil){
        [bannerView_ setHidden:true];
    }
    [ATAppTransferManager hideTransferView];
}



//显示广告
- (void)showBannerView
{
    if(bannerView_!=nil){
        bannerView_.hidden = NO;
    }
}


//显示广告
- (void)showGAD
{
    if ([ATAppTransferManager isTransferViewShow]) {
      [ATAppTransferManager showTransferViewWithPosition:CGPointMake(0, 0) failure:^(void) {
                    // show app transfer failure or isShow is NO
                    // show admob here
          [self showBannerView];
      }];
    }else{//广告未下载完  调用admob
         [self showBannerView];
    }
}



//客户端接收到广告后调用
- (void)adViewDidReceiveAd:(GADBannerView *)view
{
}
//用户点击广告后调用
- (void)adViewWillPresentScreen:(GADBannerView *)adView
{
    /*
    CCScene *nowScene = [[CCDirector sharedDirector] runningScene];
    [SOXSoundUtil close_sound];
    //如果当前已经是  暂停 画面
    if ([[CCDirector sharedDirector]isPaused]) {
        
    }else{
        if( [[GameHelper getGameLayer] nowGameState] == GameStateStart){
            PauseLayer *layer =  [GameHelper getPauseLayer] ;
            [[CCDirector sharedDirector] pause];
             [layer showLayer];
        }
    }
    */
    
}
//用户点击广告后切换回游戏时
- (void)adViewDidDismissScreen:(GADBannerView *)adView{
    /*
    [[CCDirector sharedDirector] setNextDeltaTimeZero:YES];
    [SOXSoundUtil open_sound];
    //如果当前 是游戏中 不自动继续播放动画  让用户自己点击继续
    if( [[GameHelper getGameLayer] nowGameState] == GameStateStart){
        [[CCDirector sharedDirector] resume];
    }
     */
}


@end