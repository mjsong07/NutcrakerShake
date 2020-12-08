//
//  SOXMapUtil.m
//  SoxFrame
//
//  Created by jason yang on 13-5-27.
//
//

#import "SOXGameCenterUtil.h"  
#import "AppDelegate.h"
@implementation SOXGameCenterUtil

@synthesize gameCenterManager;  
static SOXGameCenterUtil* instanceOfSOXGameCenterUtil;
+(SOXGameCenterUtil*) sharedSOXGameCenterUtil
{
    if(instanceOfSOXGameCenterUtil == nil){
        instanceOfSOXGameCenterUtil = [[SOXGameCenterUtil alloc] init];
        
        [instanceOfSOXGameCenterUtil initGameCenterManager]; 
    }
	NSAssert(instanceOfSOXGameCenterUtil != nil, @"SOXGameCenterUtil instance not yet initialized!");
	return instanceOfSOXGameCenterUtil;
} 

- (void)initGameCenterManager
{  
	if([GameCenterManager isGameCenterAvailable])
	{
		self.gameCenterManager= [[[GameCenterManager alloc] init] autorelease];
		[self.gameCenterManager setDelegate: self];
	}
	else
	{ 
      //  [SOXDebug logStr:@"The current device does not support Game Center"];
	}
}

- (void)chkUpdateAchieve:(NSString*)achieveKey :(double)nowScore :(double)needScore{ 
    NSString *keyFlag= [ NSString stringWithFormat:@"%@%@",achieveKey,G_KEY_ACHIEVEMENT_FLAG];
    NSString *keyVal= [ NSString stringWithFormat:@"%@%@",achieveKey,G_KEY_ACHIEVEMENT_NOWVAL];
    NSString *keyWebFlag= [ NSString stringWithFormat:@"%@%@",achieveKey,G_KEY_ACHIEVEMENT_WEB_FLAG];
    NSString *keyWebVal= [ NSString stringWithFormat:@"%@%@",achieveKey,G_KEY_ACHIEVEMENT_WEB_NOWVAL];
    
    
    BOOL localFlag = [SOXDBUtil loadInfoReturnBool:keyFlag];
    double localDBPercentVal = [SOXDBUtil loadInfoReturnDouble:keyVal];
    
    BOOL webFlag = [SOXDBUtil loadInfoReturnBool:keyWebFlag];
    double webDBPercentVal = [SOXDBUtil loadInfoReturnDouble:keyWebVal];
    
    
    BOOL updateFlag =false;
    BOOL updateWebFlag =false;
    double nowPercent = 0;//百分比
    double doubleNowScore =nowScore;
    double doubleNeedScore = needScore;
    //如果当前 本地 新数据 大于之前保存的 更新 提交 
    
    if(doubleNowScore>0 && doubleNeedScore>0){
        nowPercent = doubleNowScore/doubleNeedScore*100;
    }
    if(nowScore> needScore){//如果当前的成就大于 需要的 直接 成功 设置完成 
        nowPercent = 100.0;
    }
    
    //必须是本地未更新的 1的
    if(localFlag == false){
        if(nowPercent > localDBPercentVal ){
            updateFlag = true;
        } 
    } 
    
    //必须是 服务器未达成并且 百分比 大于 当前 服务器的
    if(webFlag == false){
        if(nowPercent > webDBPercentVal ){
            updateWebFlag = true;
        }
    }
    
    
    if(updateFlag){ 
            [SOXDBUtil saveInfo:keyVal :[SOXUtil doubleToString:nowPercent]];
            if(nowPercent>=100){ 
                [SOXDBUtil saveInfo:keyFlag :G_STR_YES];
            }  
    }
    if(updateWebFlag==true){
        //调用gameCenter 提交分数
        [self submitAchievement:achieveKey :nowPercent];
    }
}
//同步所有 GameCenter ，已本地的 为最新更新 web服务器
- (void)synWebAchieve:(NSString*)key :(int)i{
    
    
    NSString *achievekey= [ NSString stringWithFormat:@"%@%d",key,i];
    
    NSString *keyFlag= [ NSString stringWithFormat:@"%@%d%@",key,i,G_KEY_ACHIEVEMENT_FLAG];
    NSString *keyWebFlag= [ NSString stringWithFormat:@"%@%d%@",key,i,G_KEY_ACHIEVEMENT_WEB_FLAG]; 
    NSString *keyVal= [ NSString stringWithFormat:@"%@%d%@",key,i,G_KEY_ACHIEVEMENT_NOWVAL]; 
    NSString *keyWebVal= [ NSString stringWithFormat:@"%@%d%@",key,i,G_KEY_ACHIEVEMENT_WEB_NOWVAL]; 
    
    int bolFlag = [SOXDBUtil  loadInfoReturnBool:keyFlag];
    double intVal = [SOXDBUtil loadInfoReturnDouble:keyVal];
    
    int bolWebFlag = [SOXDBUtil loadInfoReturnBool:keyWebFlag];
    double intWebVal = [SOXDBUtil loadInfoReturnDouble:keyWebVal];
    
    bool updateFlag = false;
    if(bolFlag == true && bolWebFlag == false){
          updateFlag = true; 
    }
    if(intVal >intWebVal){
           updateFlag = true; 
    }
    if(updateFlag){
        double  doubleVal = intVal;// [SOXUtil intToDouble:intVal ];
        [self submitAchievement:achievekey :doubleVal];
    }
}
//根据等级 更新 当前等级下的所有的 成就
- (void)synWebAchieveAll:(int)level{ 
//    [self synWebAchieve:G_KEY_ACHIEVEMENT_SCORE_L :level];
//    [self synWebAchieve:G_KEY_ACHIEVEMENT_DISTANCE_L :level];
//    [self synWebAchieve:G_KEY_ACHIEVEMENT_STAR_L :level];
//    [self synWebAchieve:G_KEY_ACHIEVEMENT_LIFE_L :level];
}
 


//统计更新 当前所有的成就
- (void)calAchieveAll
{
    /*
    double bestScore = [SOXDBUtil loadInfoReturnDouble:G_KEY_LEADERBOARD_SCORE];
    double nowStar = [SOXDBUtil loadInfoReturnDouble:G_KEY_NOW_STAR_CNT];
    int nowLife = [SOXDBGameUtil loadNowLife];
//     [self chkUpdateAchieve:G_KEY_ACHIEVEMENT_DISTANCE_L4 :distance];
    [self calAchieveLife:nowLife];
    [self calAchieveStar:nowStar]; 
     */
}
  
//加载所有成就
- (void) loadNowAllAchievements
{
	if(self.isLogined == true)
	{
		[self.gameCenterManager loadAllAchievements];
	}
}


//提交成就
- (void) submitAchievement:(NSString*)identifier :(double)percentComplete
{ 
	if(identifier!= NULL)
	{
		[self.gameCenterManager submitAchievement: identifier percentComplete: percentComplete];
	}
}
//提交分数
- (void) submitLeaderboardScore:(int64_t)currentScore :(NSString*)currentLeaderBoard
{
	if(currentScore > 0)
	{
		[self.gameCenterManager reportScore: currentScore forCategory:  currentLeaderBoard];
	}
}
//重置成就
- (void) resetAchievements
{
	[gameCenterManager resetAchievements];
}
//
- (void) chkUserIsLoad
{
    if(self.isLogined == true){
    
    }else{
        [self.gameCenterManager authenticateLocalUser];//调用校验用户
    }
} 

//GameCenter 登录页面 录入完后回掉 方法
- (void) processGameCenterAuth: (NSError*) error
{
	if(error == NULL)
	{
        [self setIsLogined:true] ; //记录当前已登录
        //同时加载 所有成就
    //    [self.gameCenterManager loadAllAchievements];
	}else{
        [self setIsLogined:false] ; 
    }
}
 
   
-(void) achievementViewControllerDidFinish:(GKAchievementViewController *)viewController
{
	[[SOXGameUtil getBaseRootView] dismissModalViewControllerAnimated:YES];
}

-(void) leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController
{
	[[SOXGameUtil getBaseRootView]dismissModalViewControllerAnimated:YES];
}


@end
