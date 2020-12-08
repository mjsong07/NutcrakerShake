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
#import "BGParticleLayer.h"
@implementation GameHelper {
   
}

+(GameInfo*) getGameInfo
{
    GameInfo *layer = (GameInfo*)[[GameLayer sharedGameLayer]getChildByTag:T_Layer_GameInfo];
    return layer;
}

+(GameLayer*) getGameLayer
{
    GameLayer *layer = (GameLayer*)[GameLayer sharedGameLayer];
    return layer;
}
+(ThingManager*) getThingManager
{
    ThingManager *layer = (ThingManager*)[[GameLayer sharedGameLayer]getChildByTag:T_Layer_Thing];
    return layer;
}
+(IndexLayer*) getIndexLayer
{
    IndexLayer *layer = (IndexLayer*)[[GameLayer sharedGameLayer]getChildByTag:T_Layer_Index];
    return layer;
}
+(ScoreLayer*) getScoreLayer
{
    ScoreLayer *layer = (ScoreLayer*)[[GameLayer sharedGameLayer]getChildByTag:T_Layer_Score];
    return layer;
}
+(BGParticleLayer*) getBG_ParticleLayer
{
    BGParticleLayer *layer = (BGParticleLayer*)[[GameLayer sharedGameLayer]getChildByTag:T_Layer_BG_Particle];
    return layer;
}



+(BGLayer*) getBGLayer
{
    BGLayer *layer = (BGLayer*)[[GameLayer sharedGameLayer]getChildByTag:T_Layer_BG];
    return layer;
}


+(BGLayer*) getBGShakeLayer
{
    BGLayer *layer = (BGLayer*)[[GameLayer sharedGameLayer]getChildByTag:T_Layer_BG_Shake];
    return layer;
}

+(CCLayer*) getBGShakeWhiteLayer
{
    CCLayer *layer = (CCLayer*)[[GameLayer sharedGameLayer]getChildByTag:T_Layer_BG_Shake_White];
    return layer;
}

+(Hero*) getHero
{
    Hero *layer = (Hero*)[[GameLayer sharedGameLayer]getChildByTag:T_OBJ_HERO];
    return layer;
}
+(HeroBump*) getHeroBump
{
    HeroBump *layer = (HeroBump*)[[GameLayer sharedGameLayer]getChildByTag:T_OBJ_HERO_BUMP];
    return layer;
}

+(PauseLayer*) getPauseLayer
{
    PauseLayer *layer = (PauseLayer*)[[GameLayer sharedGameLayer]getChildByTag:T_Layer_Pause];
    return layer;
}

@end
