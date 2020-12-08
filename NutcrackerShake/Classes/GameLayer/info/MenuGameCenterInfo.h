//
//  MenuLayer.h
//  SoxFrame
//
//  Created by jason yang on 14-02-26
//
//
#import "MBProgressHUD.h"
#import "Reachability.h"

@interface MenuGameCenterInfo : BaseSprite <  GKLeaderboardViewControllerDelegate, GKAchievementViewControllerDelegate>{
    CCMenu  *menu_ ;
    CCSprite *gamecenter_;
}

@property (retain) MBProgressHUD *hud;
@property(nonatomic,retain)Reachability *reach;//基本动画
@property NetworkStatus netStatus;//基本动画


- (void)setAllColor:(ccColor3B)color;

- (CGFloat)getWidth;
- (CGFloat)getHeight;
@end
