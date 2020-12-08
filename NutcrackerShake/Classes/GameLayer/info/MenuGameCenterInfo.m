//
//  MenuLayer.m
//  SoxFrame
//
//  Created by jason yang on 14-02-26
//
//

#import "MenuGameCenterInfo.h"
@implementation MenuGameCenterInfo
 
- (id)init
{
	self = [super init];
	if (self) {
        gamecenter_ = [CCSprite spriteWithFile:@"menu_gamecenter.png" ];
        CCMenuItemSprite *itemSprite =  [ CCMenuItemSprite itemWithNormalSprite:gamecenter_ selectedSprite:nil
                                                                        target:self selector:@selector(toGameCenterLeaderboard:) ];
         gamecenter_.color = ccSOX_BTN_BASE;
         menu_ = [CCMenu menuWithItems: itemSprite,nil];
         menu_.position = CGPointMake(0, 0);
        [self addChild: menu_ z:1 tag:1 ];
        self.reach = [Reachability reachabilityForInternetConnection];
        self.netStatus = [self.reach currentReachabilityStatus];
	}
	return self;
}

- (void)dismissHUD:(id)arg {
    _hud.removeFromSuperViewOnHide = YES;
    [_hud hide:YES];
    self.hud = nil;
}
//用于提示框
- (void)showHuDByStr:(NSString*)title :(NSString*)message :(double)delay {
    self.hud= [MBProgressHUD showHUDAddedTo:[SOXGameUtil getBaseRootView].view animated:YES];
    _hud.labelText = title;
    _hud.detailsLabelText = message;
    [self performSelector:@selector(dismissHUD:) withObject:nil afterDelay:delay];
}


//gamecenter排行榜
- (void)toGameCenterLeaderboard:(id) sender
{
    [SOXSoundUtil play_btn]; 
//    if (self.netStatus == NotReachable) {
//        //再次检查网络
//       
//    }
     //再次检查网络
    self.reach = [Reachability reachabilityForInternetConnection];
    self.netStatus = [self.reach currentReachabilityStatus];
    
    
    if (self.netStatus == NotReachable) {
        
        NSString *Warning =NSLocalizedString(@"Warning", @"");
        NSString *NoInternet =NSLocalizedString(@"NoInternet", @"");
        
        [self showHuDByStr:Warning :NoInternet:G_ALERT_DELAY_TIMES];
    } else {
        //每次 点击 排行榜 直接提交 当前分数
        
        SOXGameCenterUtil *gameCenterUtil= [SOXGameCenterUtil sharedSOXGameCenterUtil];
        if( gameCenterUtil.isLogined == true){
            double intScore =[SOXDBUtil loadInfoReturnDouble:G_KEY_LEADERBOARD_SCORE];
            [gameCenterUtil submitLeaderboardScore:intScore :G_KEY_LEADERBOARD_SCORE];//更新最新gamecenter 分数
            GKLeaderboardViewController *leaderboardController = [[GKLeaderboardViewController alloc] init];
            if (leaderboardController != NULL)
            {
                leaderboardController.category = G_KEY_LEADERBOARD_SCORE;
                leaderboardController.timeScope = GKLeaderboardTimeScopeAllTime;
                leaderboardController.leaderboardDelegate = self;
                [[SOXGameUtil getBaseRootView] presentModalViewController: leaderboardController animated: YES];
            }
        }else{ 
            [[SOXGameUtil getAppDelegate]showGameCenter];
        }
    }
}


#pragma mark GameKit delegate

-(void) achievementViewControllerDidFinish:(GKAchievementViewController *)viewController
{
	[[SOXGameUtil getBaseRootView] dismissModalViewControllerAnimated:YES];
}

-(void) leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController
{
	[[SOXGameUtil getBaseRootView] dismissModalViewControllerAnimated:YES];
}
- (void)toGameCenterAchieve:(id) sender
{
    GKAchievementViewController *achievements = [[GKAchievementViewController alloc] init];
	if (achievements != NULL)
	{
		achievements.achievementDelegate = self;
		[[SOXGameUtil getBaseRootView] presentModalViewController: achievements animated: YES];
	}
}


- (void)setAllColor:(ccColor3B)color
{
//    CCSprite *sp = (CCSprite*)[self getChildByTag:1];
    gamecenter_.color =color;
}

- (CGFloat)getWidth{
    return gamecenter_.contentSize.width;
}

- (CGFloat)getHeight{
    return gamecenter_.contentSize.height;
}

- (void)dealloc
{
    [_hud release];
    [_reach release];
    [super dealloc];
}
 @end
