//
//  ThingCache.h
//  SoxFrame
//
//  Created by jason yang on 13-6-3.
//
//

#import "BaseSprite.h" 
#import "Hero.h"
#import "HeroBump.h"
@interface ThingCache : CCSprite{ 
    CCSpriteBatchNode *ccBatchNode_;
} 
+ (id)objInit;
@property(nonatomic,retain)CCArray* things;//二维数组 存放不同得 物品 障碍
- (BaseSprite*) showObjDrop:(ThingObjType)objType :(ccColor3B)color  :(float)speed :(CGPoint)startPosition;//根据x坐标生成


- (BaseSprite*) showObjRise:(ThingObjType)objType :(ccColor3B)color  :(float)speed :(CGPoint)startPosition;//根据x坐标生成

+ (id)objInit;//初始化

- (int)getNowShowIngThing;

- (CCSprite*)chkNowIsBump:(HeroBump *)heroBump; 
- (void)resetAll;
@end
