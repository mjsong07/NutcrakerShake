#import "GameCenterManager.h"
#import <GameKit/GameKit.h>



@implementation GameCenterManager

@synthesize earnedAchievementCache;
@synthesize requestAchievements ;
@synthesize delegate;


- (id) init
{
	self = [super init];
	if(self!= NULL)
	{
		earnedAchievementCache= NULL;
	}
	return self;
}

- (void) dealloc
{
	self.earnedAchievementCache= NULL;
	[super dealloc];
} 
- (void) callDelegate: (SEL) selector withArg: (id) arg error: (NSError*) err
{
	assert([NSThread isMainThread]);
	if([delegate respondsToSelector: selector])
	{
		if(arg != NULL)
		{
			[delegate performSelector: selector withObject: arg withObject: err];
		}
		else
		{
			[delegate performSelector: selector withObject: err];
		}
	}
	else
	{
		NSLog(@"Missed Method");
	}
}


- (void) callDelegateOnMainThread: (SEL) selector withArg: (id) arg error: (NSError*) err
{
	dispatch_async(dispatch_get_main_queue(), ^(void)
	{
	   [self callDelegate: selector withArg: arg error: err];
	});
}

+ (BOOL) isGameCenterAvailable
{
	// check for presence of GKLocalPlayer API
	Class gcClass = (NSClassFromString(@"GKLocalPlayer"));
	
	// check if the device is running iOS 4.1 or later
	NSString *reqSysVer = @"4.1";
	NSString *currSysVer = [[UIDevice currentDevice] systemVersion];
	BOOL osVersionSupported = ([currSysVer compare:reqSysVer options:NSNumericSearch] != NSOrderedAscending);
	
	return (gcClass && osVersionSupported);
}

//校验 当前用户
- (void) authenticateLocalUser
{ 
	if([GKLocalPlayer localPlayer].authenticated == NO)
	{
		[[GKLocalPlayer localPlayer] authenticateWithCompletionHandler:^(NSError *error) 
		{
			[self callDelegateOnMainThread: @selector(processGameCenterAuth:) withArg: NULL error: error];
		}];
	}
}
//查询 分数 
- (void) reloadHighScoresForCategory: (NSString*) category
{
	GKLeaderboard* leaderBoard= [[[GKLeaderboard alloc] init] autorelease];
	leaderBoard.category= category;
	leaderBoard.timeScope= GKLeaderboardTimeScopeAllTime;
	leaderBoard.range= NSMakeRange(1, 1);
	
	[leaderBoard loadScoresWithCompletionHandler:  ^(NSArray *scores, NSError *error)
	{ 
        if (error != nil){
            // handle the error.
            NSLog(@"下载失败");
        }
        if (scores != nil){
            // process the score information.
            NSLog(@"下载成功....");
//            NSArray *tempScore = [NSArray arrayWithArray:scores];
            for (GKScore *obj in scores) {
                NSLog(@"    playerID            : %@",obj.playerID);
                NSLog(@"    category            : %@",obj.category);
                NSLog(@"    date                : %@",obj.date);
                NSLog(@"    formattedValue    : %@",obj.formattedValue);
                NSLog(@"    value                : %lld",obj.value);
                NSLog(@"    rank                : %d",obj.rank);
                NSLog(@"**************************************");
            }
        } 
	}];
}
// 提交 排行榜分数
- (void) reportScore: (int64_t) score forCategory: (NSString*) category
{
	GKScore *scoreReporter = [[[GKScore alloc] initWithCategory:category] autorelease];
	scoreReporter.value = score; 
	[scoreReporter reportScoreWithCompletionHandler: ^(NSError *error) 
	 {
		// [self callDelegateOnMainThread: @selector(scoreReported:) withArg: NULL error: error];
	 }];
}
// 读取所有成就
- (void) loadAllAchievements
{
    
    if(self.earnedAchievementCache == NULL)
	{
        [GKAchievement loadAchievementsWithCompletionHandler: ^(NSArray *achievements, NSError *error)
         {
             //并且 缓存对象必须为空  防止多次调用
             if(error == NULL && self.earnedAchievementCache == NULL)
             {
                 NSMutableDictionary* tempCache= [NSMutableDictionary dictionaryWithCapacity: [achievements count]];
                 for (GKAchievement* tempAchievement in achievements)
                 {
                    [tempCache setObject: tempAchievement forKey: tempAchievement.identifier]; 
                     NSString *keyFlag = [NSString stringWithFormat:@"%@%@",tempAchievement.identifier,G_KEY_ACHIEVEMENT_WEB_FLAG];
                     NSString *keyNowVal = [NSString stringWithFormat:@"%@%@",tempAchievement.identifier,G_KEY_ACHIEVEMENT_WEB_NOWVAL];
                     NSString *saveFlag = @"";
                     NSString *saveNowVal = @"0";
                     if(tempAchievement.completed == 1){
                         saveFlag = @"1";
                         saveNowVal = @"100";
                     }else{
                         saveFlag = @"0";
                         saveNowVal =[SOXUtil doubleToString:tempAchievement.percentComplete];
                     }
                     [SOXDBUtil saveInfo:keyFlag :saveFlag ];
                     [SOXDBUtil saveInfo:keyNowVal :saveNowVal ];
                     
                 }
                 self.earnedAchievementCache= tempCache;
                 self.requestAchievements = achievements;
             }
             else
             { 
             } 
         }];
	}else{
    
    
    } 
 }
//提交 成就
- (void) submitAchievement: (NSString*) identifier percentComplete: (double) percentComplete
{
        //加载 服务端信息
        [self loadAllAchievements];
    
		GKAchievement* achievement= [self.earnedAchievementCache objectForKey: identifier];
		if(achievement != NULL)
		{
			if((achievement.percentComplete >= 100.0) || (achievement.percentComplete >= percentComplete))
			{ 
				achievement= NULL;
			}
			achievement.percentComplete= percentComplete;
		}
		else
		{
			achievement= [[[GKAchievement alloc] initWithIdentifier: identifier] autorelease];
			achievement.percentComplete= percentComplete; 
			[self.earnedAchievementCache setObject: achievement forKey: achievement.identifier];
		}
		if(achievement!= NULL)
		{
			//Submit the Achievement...
			[achievement reportAchievementWithCompletionHandler: ^(NSError *error)
			{ 
                //保存本地记录 web成就的信息
                NSString *keyWebFlag= [ NSString stringWithFormat:@"%@%@",identifier,G_KEY_ACHIEVEMENT_WEB_FLAG];
                NSString *keyWebVal= [ NSString stringWithFormat:@"%@%@",identifier,G_KEY_ACHIEVEMENT_WEB_NOWVAL]; 
                [SOXDBUtil saveInfo:keyWebVal :[SOXUtil doubleToString:percentComplete]];
                if(percentComplete>=100){
                    [SOXDBUtil saveInfo:keyWebFlag :G_STR_YES];
                } 
                //[SOXDebug logStr:@"achievement is submit"];
            }];
		}
}

- (void) resetAchievements
{
	self.earnedAchievementCache= NULL;
	[GKAchievement resetAchievementsWithCompletionHandler: ^(NSError *error) 
	{
        //[SOXDebug logStr:@"resetAchievements success"];
	}];
}
 
@end
