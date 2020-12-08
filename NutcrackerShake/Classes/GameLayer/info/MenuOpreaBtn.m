//
//  ScoreLayer
//  SoxFrame
//
//  Created by jason yang on 14-02-26
//
//

#import "ScoreLayer.h" 
#import "GameLayer.h"
#import "MenuOpreaBtn.h"
#import "MenuGameCenterInfo.h"
#import "SOXMenuUtil.h"
#import "ShareManager.h"
@implementation MenuOpreaBtn

- (id)init
{
	if (self = [super init]) {
        menuStart_= [[SOXMenuUtil sharedMenuUtil] init:@"menu_start.png" target:self selector:@selector(toStart:)];
        menuShare_= [[SOXMenuUtil sharedMenuUtil] init:@"menu_share.png" target:self selector:@selector(toShare:)];
        
        //menuStart_.color = ccSOX_BTN_BASE;
        menuShare_.color = ccSOX_BTN_BASE;
        [MenuGameCenterInfo_ setAllColor:ccSOX_BTN_BASE]; 
        
        MenuGameCenterInfo_= [[[MenuGameCenterInfo alloc ]init ]autorelease];
        
        [menuStart_ setPosition:CGPointMake(getRS(10),getRS(-20))];
        [menuShare_ setPosition:CGPointMake(getRS(-25),getRS(-95))];
        [MenuGameCenterInfo_ setPosition:ccp(getRS(25),getRS(-95))];
        
        [self addChild:menuStart_ z:1 tag:1];
        [self addChild:menuShare_ z:1 tag:2];
        [self addChild:MenuGameCenterInfo_ z:1 tag:3];
        [self reset];
	}
	return self;
}

//重新开始
- (void)reset
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0){
        menuShare_.visible = true;
    }else{
        menuShare_.visible = false;
    }
    MenuGameCenterInfo_.visible = true;
}

//重新开始
- (void)toStart:(id) sender
{
    [self reset];
     [SOXSoundUtil play_btn]; 
     ScoreLayer *scoreLayer =  (ScoreLayer*)[[GameLayer sharedGameLayer]getChildByTag:T_Layer_Score];
    [scoreLayer hideToIndexLayer];
    //[[CCDirector sharedDirector] replaceScene: [SceneSwitch showScene:T_SCENE_Black_LAYER]];
}
//分享
- (void)toShare:(id) sender
{
    [SOXSoundUtil play_btn];
    //屏蔽 广告
    [[SOXGameUtil getBaseRootView]hiddenGAD];
    //初始化 分享界面
    
    double  score = [[GameHelper getScoreLayer]nowScore ] ;
    NSString *shareContent =NSLocalizedString(@"shareContent", @"");
    if( score<=0){
        
    }else{
        NSString *shareScoreContent =NSLocalizedString(@"shareScoreContent", @"");
        NSString *shareScoreContentBy =NSLocalizedString(@"shareScoreContentBy", @"");
        NSString *strScore =[SOXUtil notRounding:score afterPoint:0];
        shareContent = [NSString  stringWithFormat:@"%@ %@ %@!",shareScoreContent,strScore,shareScoreContentBy];
    }
    UIImage *image= [SOXGameUtil makeaShot];
    [ShareManager showShareComponentWithText:shareContent image:image urlString:G_KEY_SOX_WECHATE_URL];
    
}


- (void)setAllColor:(ccColor3B)color
{
    CCSprite *sp = (CCSprite*)[self getChildByTag:2];
    MenuGameCenterInfo *sp2 = (MenuGameCenterInfo*)[self getChildByTag:3];
    sp.color =color;
    [sp2 setAllColor:color];

    
}

- (void)dealloc
{
    //动态创建的菜单需要手工处理 释放
   // [menuStart_ release];
   // [menuShare_ release];
    [super dealloc];
}

@end
