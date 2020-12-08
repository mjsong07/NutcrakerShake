//
//  GameLayer.h
//  SoxFrame
//
//  Created by jason yang on 14-02-26
//
//

#import "CCLayer.h"
#import "Hero.h"
#import "ThingCache.h" 
@class ThingManager;
@class IndexLayer;
@class ScoreLayer;
@class BGLayer;
@class Hero;
@class HeroBump;
@class PauseLayer;
@class GameLayer;
@class GameInfo;
@class BGParticleLayer;
@interface GameHelper : CCLayer {
    
}


+(GameInfo*) getGameInfo;
+(GameLayer*) getGameLayer;
+(ThingManager*) getThingManager;
+(IndexLayer*) getIndexLayer;
+(ScoreLayer*) getScoreLayer;
+(BGLayer*) getBGLayer;
+(Hero*) getHero;
+(HeroBump*) getHeroBump;

+(PauseLayer*) getPauseLayer;

+(BGLayer*) getBGShakeLayer;
+(CCLayer*) getBGShakeWhiteLayer;

+(BGParticleLayer*) getBG_ParticleLayer;
 
@end
