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
#import "MenuOpreaBtn.h"
#import "BaseLayer.h"
@implementation ScoreLayer
 
- (id)init
{
	if (self = [super init]) {
        MenuScoreInfo *score = [[[MenuScoreInfo alloc]init]autorelease];
        MenuOpreaBtn *opreaBtn = [[[MenuOpreaBtn alloc]init]autorelease];
        [self addChild:score z:0 tag:1];
        [self addChild:opreaBtn z:0 tag:2];
        [score setPosition:ccp(G_SCREEN_SIZE.width/2, G_SCREEN_SIZE.height/2+ getRS(50) )];
        [opreaBtn setPosition:ccp(G_SCREEN_SIZE.width/2, G_SCREEN_SIZE.height/2- getRS(20) )];
        [self setPosition:ccp(0, G_SCREEN_SIZE.height)];
	}
	return self;
}

- (void)showLayer
{
	self.visible = true;
    MenuScoreInfo *score = (MenuScoreInfo*)[self getChildByTag:1];
    [score updateScore];//更新当前显示分数
    
    float t= 1.5;
    id moveTo = [CCMoveTo actionWithDuration:t position:ccp(self.position.x, 0)];
    id move = [CCEaseOut actionWithAction:[[moveTo copy] autorelease] rate:0.4f];//CCEaseSineIn
    id chkAndShowRankFun = [CCCallFunc actionWithTarget:self selector:(@selector(chkAndShowRank))];
     id seq  = [CCSequence actions: move,chkAndShowRankFun,nil];
    [self runAction:seq];
    [self setTouchEnabled:true];
   
}



- (void)chkAndShowRank
{
	
    int gameTimes =[SOXDBUtil loadInfoReturnInt:G_KEY_GAME_TIMES];//记录当前的游戏次数
    BOOL isClickRank =[SOXDBUtil loadInfoReturnBool:G_KEY_IS_CLICK_RANK];//记录当前的游戏次数
    
    //更新游戏次数  同时判断是否需要弹出评价框
    gameTimes = gameTimes+1;
    [SOXDBUtil updateInfoByInt:G_KEY_GAME_TIMES : gameTimes];//更新游戏次数
    bool isShow = false;
    if(isClickRank == false){//如果没有点击过 继续判断
        if(gameTimes == G_RANK_SHOW_1){//20次 提示评价
            isShow = true;
        }else if( gameTimes == G_RANK_SHOW_2){//20次 提示评价
            isShow = true;
        }else if( gameTimes == G_RANK_SHOW_3){//20次 提示评价
            isShow = true;
        }
    }
    if(isShow == true){
        NSString *RankGame =NSLocalizedString(@"RankGame", @"");
        NSString *Yes =NSLocalizedString(@"Yes", @"");
        NSString *No =NSLocalizedString(@"No", @"");
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:RankGame delegate:self cancelButtonTitle:No otherButtonTitles:Yes, nil];
        [alertView setTag:1]; //设置 唯一key
        [alertView show];
        [alertView release];
    }
}



//星星购买 生命提示框结果回调
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
   // int tag= [alertView tag];
    if(buttonIndex == 1){//点击了确认
            [SOXDBUtil updateInfoByBool:G_KEY_IS_CLICK_RANK :true ];//更新为点击过评论
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:G_KEY_SOX_NUTCRACKER_URL]];
    }
}

- (void)hideLayer
{
	
    [self setTouchEnabled:false];
    self.visible = false;
    [self setPosition:ccp(0, G_SCREEN_SIZE.height)];

}

- (void)hideToIndexLayer
{
    [self setTouchEnabled:false];
    float t = 0.5;
    id moveTo = [CCMoveTo actionWithDuration:t position:ccp(self.position.x, G_SCREEN_SIZE.height*(1))];
    id move = [CCEaseOut actionWithAction:moveTo rate:0.8f];
    id function = [CCCallFunc actionWithTarget:self selector:@selector(callBackHide:)];
    [self runAction:[CCSequence actions: move, function, nil]];
}
//返回游戏开始画面
- (void)callBackHide:(id) sender
{
    self.visible = false;
    [self setPosition:ccp(0, G_SCREEN_SIZE.height)];
    [[GameLayer sharedGameLayer]toIndex];

}
- (void)setAllColor:(ccColor3B)color
{
    //CCSprite *sp = (CCSprite*)[self getChildByTag:1];
    MenuOpreaBtn *sp2 = (MenuOpreaBtn*)[self getChildByTag:2];
    //sp.color =color;
    [sp2 setAllColor:color] ;
}
@end
