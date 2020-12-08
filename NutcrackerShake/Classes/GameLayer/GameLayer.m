//
//  GameLayer.m
//  SoxFrame
//
//  Created by jason yang on 14-02-26
//
//

#import "GameLayer.h"
#import "ScoreLayer.h"
#import "ThingManager.h"
#import "MenuGameCenterInfo.h"
#import "MenuMusicInfo.h"
#import "IndexLayer.h"
#import "BGLayer.h"
#import "InputLayer.h"
#import "HeroBump.h"
#import "SOXBumpUtil.h"
#import "GameHelper.h"
#import "PauseLayer.h"
#import "GameInfo.h"
#import "ThingManager.h"
#import "BGParticleLayer.h"
@implementation GameLayer {
    
}

+ (id)scene
{
    [[SOXConfig sharedConfig] initAll];//初始化系统设置
    
    if([GameLayer sharedGameLayer]!= nil){
        return [GameLayer sharedGameLayer];
    }
    
	CCScene *scene = [CCScene node];
    [scene setTag:T_SCENE_GAME_LAYER];
    [[SOXConfig sharedConfig] resetAll];//重置游戏 难度
    GameLayer *gameLayer = [GameLayer node];
    BGLayer *bglayer = [BGLayer node];
    IndexLayer *indexLayer = [IndexLayer node];
    ScoreLayer *scoreLayer = [ScoreLayer node];
    InputLayer *inputLayer = [InputLayer node];
    ThingManager *thingManager = [ThingManager node];
    PauseLayer *pauseLayer = [PauseLayer node];
    
    BGParticleLayer *bgParticleLayer= [BGParticleLayer node];
    
     GameInfo *gameInfo = [GameInfo node];
    [scene addChild: gameLayer z:-9 tag:T_Layer_Game];
    [scene addChild: inputLayer z:-10 tag:T_Layer_Input];
    [gameLayer addChild:bglayer z:-100  tag: T_Layer_BG];
    [gameLayer addChild:bgParticleLayer z:-99  tag: T_Layer_BG_Particle];
    CCLayerColor *shakeLayer = [CCLayerColor layerWithColor:ccc4(255, 255, 255, 255)];
    shakeLayer.visible =false;
    shakeLayer.opacity = 100;
    [gameLayer addChild:shakeLayer z:-101 tag:T_Layer_BG_Shake_White];
    BGLayer *bglayerShake = [BGLayer node];
    [gameLayer addChild:bglayerShake z:-100  tag: T_Layer_BG_Shake];
    [gameLayer addChild:pauseLayer z:-5  tag: T_Layer_Pause];
    [gameLayer addChild:thingManager z:-8 tag:T_Layer_Thing];
    [gameLayer addChild:indexLayer z:-8  tag: T_Layer_Index];//游戏结束  显示分数层
    [gameLayer addChild:scoreLayer z:-7  tag: T_Layer_Score];//游戏结束  显示分数层
    [gameLayer addChild:gameInfo z:-6  tag: T_Layer_GameInfo];
    [gameLayer toIndex];
    [SOXSoundUtil play_GameBackgroundMusic];
    return scene;
}

- (void)update:(ccTime)delta
{
    //只有游戏中才更新 人物 和 物品的状态位置
    if(self.nowGameState == GameStateStart){
        [hero_ updateAct:delta];
        [heroBump_ setPositionByHero:hero_];
        //设置检测碰撞对象
        [[GameHelper getThingManager]updateThing:delta :heroBump_];
    }
}
//初始化  人物
- (void)initHero
{
    hero_= [Hero objInit];
    heroBump_= [HeroBump spriteWithFile:@"hero_bump_circle.png" ];
    heroBump_.visible = false;
    [self addChild:hero_ z:-10 tag:T_OBJ_HERO];
    [self addChild:heroBump_ z:-10 tag:T_OBJ_HERO_BUMP];
}


//初始化  人物
- (void)resetAll
{
    if(hero_.nowActState==kActionStateDead){
       [hero_ revival];//结束自动调用
       [[GameHelper getThingManager] revival];
    }else{
         [[GameHelper getBGLayer] startMoive];//结束后自动调用 人物 运动
    }
    heroBump_.position =  ccp( G_SCREEN_SIZE.width /2 ,getRS(150) );
}


- (id)init
{
    if(self = [super init]){
        instanceOfGameScene = self;
        self.nowGameState = GameStateStop;
        [self initHero];
    }
    return self;
}

-(Hero*)getHero
{
    CCNode* node = [self getChildByTag:T_OBJ_HERO];
	return (Hero*)node;
}

//跳到首页
-(void)toIndex
{
    [[GameHelper getThingManager] resetThing];
    [[GameHelper getScoreLayer] hideLayer ];
    [self resetAll];
}

//开始游戏
-(void)startGame
{
    self.nowGameState = GameStateStart;
    [[GameHelper getGameInfo]showLayer];
    [[GameHelper getIndexLayer]hideLayer];
    [[GameHelper getScoreLayer]hideLayer];
    [self scheduleUpdate];
    //[self resumeSchedulerAndActions];
    [[SOXGameUtil getBaseRootView]hiddenGAD];
    
    //每次开始记录历史最高分数
    double historyBestScore =[SOXDBUtil loadInfoReturnDouble:G_KEY_LEADERBOARD_SCORE];
    self.historyTopScore = historyBestScore;
    
    
}
//游戏结束
-(void)gameOver
{
    self.nowGameState = GameStateOver;
    [self showShakeEffect];
    [[GameHelper getScoreLayer] showLayer];
    [[GameHelper getGameInfo]hiddenLayer];
    [hero_ dead];
    [self unscheduleAllSelectors];
    [[SOXGameUtil getBaseRootView]showGAD];
}

static GameLayer* instanceOfGameScene;
+(GameLayer*) sharedGameLayer
{
	return instanceOfGameScene;
}

//运行完 显示广告
- (void)onEnter
{
	[super onEnter];
  //  [[SOXGameUtil getBaseRootView]showGAD];
}
//结束时 隐藏广告
-(void)dealloc{
    
    [[SOXGameUtil getBaseRootView]hiddenGAD];
    [super dealloc];
}
//显示震动效果
-(void)showShakeEffect
{
    CCLayer *whitelayer=  [GameHelper getBGShakeWhiteLayer];
    whitelayer.visible = true;
    float time = 0.5;
    id te1 =      [CCFadeOut actionWithDuration:time];
     [whitelayer runAction:te1]; 
    CCLayer *bgLayer= [GameHelper getBGLayer];
    CCLayer *shakelayer=  [GameHelper getBGShakeLayer];
    bgLayer.visible = false;
    shakelayer.visible = true;
    id shaky = [CCShakyTiles3D actionWithDuration:time size:ccg(1,1) range:3 shakeZ:NO];//CCShaky3D
    id fuc = [CCCallFunc actionWithTarget:self selector:@selector(toShowBgLayer)];
    [shakelayer runAction:[CCSequence actions:shaky,fuc ,nil]];
}

-(void)toShowBgLayer
{
    CCLayer *bgLayer=   [GameHelper getBGLayer];
    CCLayer *shakelayer=   [GameHelper getBGShakeLayer];
    bgLayer.visible = true;
    shakelayer.visible = false;
}
/*
 #ifdef DEBUG
 
 - (void)draw
 {
 [super draw];
 // CCSprite *sp = (CCSprite*)[self getChildByTag:T_OBJ_HERO];
 
 CCSprite *sp = (CCSprite*)[self getChildByTag:T_OBJ_HERO_BUMP];
 
 if(sp!=nil){
 // CGRect rect1=sp.boundingBox;// CGRectMake(sp.position.x - sp.boundingBox.size.width/2,
 //                                sp.position.y - sp.textureRect.size.height/2,
 //                                sp.textureRect.size.width,
 //                                sp.textureRect.size.height);
 //        CGRect rect1=sp.textureRect;
 //     CGRect rect1=  CGRectMake(sp.position.x-sp.contentSize.width/2, sp.position.y-sp.contentSize.height/2, sp.contentSize.width, sp.contentSize.height);
 CGRect rect1=  [SOXBumpUtil spriteToRect:sp];
 [SOXDebug drawRectFaster:rect1];
 ThingCache *thingCache = (ThingCache*)[SOXObjCacheUtil sharedThingCache];
 Thing *thing = nil;
 CCARRAY_FOREACH(thingCache.things, thing)
 {
 if (thing.visible == YES && thing.objType == ThingObjChess2)
 {
 CGRect rect1=  [SOXBumpUtil spriteToRect:thing];
 [SOXDebug drawRectFaster:rect1];
 }
 }
 }
 }
 #endif
 */

@end
