//
//  ScoreLayer
//  SoxFrame
//
//  Created by jason yang on 14-02-26
//
//

#import "ScoreLayer.h" 
#import "GameLayer.h"
#import "MenuScoreInfo.h"
#import "GameInfo.h"
@implementation MenuScoreInfo

- (id)init
{
	self = [super init];
	if (self) {
        
        [CCMenuItemFont setFontSize:getRS(25)];
        
		NSString *strScore =   NSLocalizedString(@"Score", @"");
		NSString *strBest =   NSLocalizedString(@"Best", @"");
        
		CCMenuItemFont *scoreTitle = [CCMenuItemFont itemWithString: strScore];
        CCMenuItemFont *bestTitle = [CCMenuItemFont itemWithString: strBest ];
        
        labelNowScore_ = [CCLabelTTF labelWithString:@"0" fontName:@"ArialRoundedMTBold" fontSize:getRS(35)];
        labelBestScore_ = [CCLabelTTF labelWithString:@"0" fontName:@"ArialRoundedMTBold" fontSize:getRS(35)];
        [scoreTitle setFontSize:getRS(30)];
        [bestTitle setFontSize:getRS(30)];
        
        [scoreTitle setFontName:@"ArialRoundedMTBold"];
        [bestTitle setFontName:@"ArialRoundedMTBold"];
        [scoreTitle setColor:ccSOX_GRAY3];
        [bestTitle setColor:ccSOX_GRAY3];
        [labelNowScore_ setColor:ccSOX_GRAY3];
        [labelBestScore_ setColor:ccSOX_GRAY3];
        
        
        [scoreTitle     setPosition:CGPointMake(getRS(-50)  ,getRS(22) )];
        [bestTitle      setPosition:CGPointMake(getRS(-50), getRS(-25))];
        [labelNowScore_ setPosition:CGPointMake(getRS(70), getRS(22)) ];
        [labelBestScore_ setPosition:CGPointMake(getRS(70), getRS(-25))];
        
        
        CCSprite *bg = [CCSprite spriteWithFile:@"menu_dialog.png" ];
       // bg.color = ccSOX_BTN_BASE;
        [self addChild:bg z:10 tag:2];
        
        [self addChild:scoreTitle z:10 tag:2];
        [self addChild:labelNowScore_ z:10 tag:2];
        [self addChild:bestTitle z:10 tag:2];
        [self addChild:labelBestScore_ z:10 tag:2];
        
	}
	return self;
}



- (NSMutableDictionary*)updateDBScoreInfo
{
    
    GameInfo *gameInfo = [GameHelper getGameInfo];
    if (gameInfo != nil){
        SOXGameCenterUtil *gameCenterUtil = [SOXGameCenterUtil sharedSOXGameCenterUtil];
        double nowScore = [gameInfo.nowScore.string doubleValue];
        double historyBestScore =[SOXDBUtil loadInfoReturnDouble:G_KEY_LEADERBOARD_SCORE];
        //更新最高分数
        bool isNeedUpdate2 = [SOXDBUtil chkIsNeedUpdateByDouble:G_KEY_LEADERBOARD_SCORE : nowScore];
        if(isNeedUpdate2){
            [SOXDBUtil updateInfoByDouble:G_KEY_LEADERBOARD_SCORE : nowScore];//更新最新本地 分数
            [gameCenterUtil submitLeaderboardScore:nowScore :G_KEY_LEADERBOARD_SCORE];//更新最新gamecenter 分数
            historyBestScore = nowScore;
        }
        NSMutableDictionary *scoreMapDict = [[[NSMutableDictionary alloc] initWithCapacity:1]autorelease];
        [scoreMapDict setObject:[SOXUtil doubleToString:nowScore] forKey:@"nowScore"];
        [scoreMapDict setObject:[SOXUtil doubleToString:historyBestScore] forKey:@"bestScore"];
        return scoreMapDict;
    }
    return nil;
}


- (void)updateScore
{
    double nowScore = 0;
    double bestScore = 0;
    NSMutableDictionary *map =  [self updateDBScoreInfo];
    if(map!=nil){
        NSString *strNowScoreDB = (NSString*) [map objectForKey:@"nowScore"];
        if([SOXUtil isNull:strNowScoreDB]) {
            strNowScoreDB = @"0";
        }
        NSString *strBestScoreDB = (NSString*) [map objectForKey:@"bestScore"];
        if([SOXUtil isNull:strBestScoreDB]) {
            strBestScoreDB = @"0";
        }
        nowScore=[strNowScoreDB doubleValue] ;
        bestScore=[strBestScoreDB doubleValue] ;
    } 
    NSString *strNowScore = [SOXUtil notRounding:nowScore afterPoint:0];
    NSString *strBestScore = [SOXUtil notRounding:bestScore afterPoint:0];
    [labelNowScore_ setString:strNowScore];
    [labelBestScore_ setString:strBestScore];
    //更新分数画面的 全局分数
    [[GameHelper getScoreLayer]setNowScore:nowScore];
    
    [SOXSoundUtil play_score];
    [self setVisible:true]; 
}
- (void)hiddenLayer
{
    [self setVisible:false];
}

//gamecenter
- (void)toGameCenter:(id) sender
{
    [SOXSoundUtil play_btn];
    CCScene* newScene = [SceneSwitch showScene:T_SCENE_GAME_LAYER];
	[[CCDirector sharedDirector] replaceScene:newScene];
}
//重新开始
- (void)toStart:(id) sender
{
    [SOXSoundUtil play_btn]; 
    CCScene* newScene = [SceneSwitch showScene:T_SCENE_GAME_LAYER];
	[[CCDirector sharedDirector] replaceScene:newScene];
}
//分享
- (void)toShare:(id) sender
{
    [SOXSoundUtil play_btn];
    //屏蔽 广告
    [[SOXGameUtil getBaseRootView]hiddenGAD];
    //初始化 分享界面
}

@end
