//
//  SOXMapUtil.h
//  SoxFrame
//
//  Created by jason yang on 13-5-27.
//
//

#import <Foundation/Foundation.h> 


#import <GameKit/GameKit.h>
#import "GameCenterManager.h"
@class GameCenterManager;
@interface SOXGameCenterUtil : NSObject<GKLeaderboardViewControllerDelegate, GKAchievementViewControllerDelegate,GameCenterManagerDelegate>

{
    GameCenterManager* gameCenterManager;  
    
    bool  isAlertLogined;//新增 是否已经提示过 登录页面 
    
}
@property bool isLogined;//新增 是否已经提示过 登录页面 
+(SOXGameCenterUtil*) sharedSOXGameCenterUtil;
@property (nonatomic, retain) GameCenterManager *gameCenterManager;  
 
- (void) chkUserIsLoad;
- (void) loadNowAllAchievements;
 
//提交排行榜 分数
- (void) submitLeaderboardScore:(int64_t)currentScore :(NSString*)currentLeaderBoard;
- (void) resetAchievements;

//统计更新 当前所有的成就
- (void)calAchieveAll;  

//根据等级 更新 当前等级下的所有的 成就
- (void)synWebAchieveAll:(int)level;
@end
