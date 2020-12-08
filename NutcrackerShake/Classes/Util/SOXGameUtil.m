//
//  SOXMapUtil.m
//  SoxFrame
//
//  Created by jason yang on 13-5-27.
//
//

#import "SOXGameUtil.h"   
#import "AppDelegate.h" 
#import "GameLayer.h"
@implementation SOXGameUtil

//获取当前代理
+(AppDelegate*)getAppDelegate {
    AppDelegate *app = (AppDelegate*) [[UIApplication sharedApplication] delegate];
    return app;
}
//获取当前 根页面对象
+(MyRootNavigationController*)getBaseRootView {
    return  (MyRootNavigationController*)[[self getAppDelegate]navController];
}
//游戏页面截图
+(UIImage*) makeaShot 
{ 
    [CCDirector sharedDirector].nextDeltaTimeZero = YES;
    CGSize winSize = [CCDirector sharedDirector].winSize;
    CCLayerColor* whitePage = [CCLayerColor layerWithColor:ccc4(255, 255, 255, 0) width:winSize.width height:winSize.height];
    whitePage.position = ccp(winSize.width/2, winSize.height/2); 
    CCRenderTexture* rtx = [CCRenderTexture renderTextureWithWidth:winSize.width height:winSize.height]; 
    [rtx begin]; 
    [whitePage visit];
    //直接 截取当前场景的 图片
    [[[CCDirector sharedDirector] runningScene] visit]; 
    [rtx end]; 
    return [rtx getUIImage]; 
}

//检测当前是否游戏中
+(void) toChkNowIsPlayingToPause{
CCScene *nowScene = [[CCDirector sharedDirector] runningScene];
//如果当前已经是  暂停 画面
if ([[CCDirector sharedDirector]isPaused]) {
    
}else{
    //如果当前 是游戏中 调用 暂停画面
    if(nowScene != nil && [nowScene tag]==T_SCENE_GAME_LAYER){
       //  [[CCDirector sharedDirector] pause];
      //  [[GameLayer sharedGameLayer]toExitPause:self];
    }
}
}


@end
