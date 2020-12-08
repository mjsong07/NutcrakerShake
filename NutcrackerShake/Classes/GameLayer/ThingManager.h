//
//  ThingManager.h
//  SoxFrame
//
//  Created by jason yang on 14-02-26
//
//

#import "CCLayer.h"
#import "Hero.h"
@class ThingCache;
@class HeroBump;
@interface ThingManager : CCLayer{
       NSMutableArray* dropArrayList_;
        NSArray *revivalArray_;
}

@property(nonatomic,assign)ThingCache *thingCache;//当前移动方向
//初始化方法
- (void)updateThing:(ccTime)delta :(HeroBump *)heroBump;
- (void)resetThing;
- (void)createThing:(GameLevel)gameLevel;
- (void)revival;
@end
