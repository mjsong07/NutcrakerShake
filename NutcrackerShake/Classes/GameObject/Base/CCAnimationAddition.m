//
//  CCAnimationAddition.m
//  MonplaPuzzle
//
//  Confidential
//

#import "CCAnimationAddition.h"


@implementation CCAnimation (CCAnimationAddition)

+ (CCAnimation *)animationWithFrameName:(NSString *)name frameCount:(NSInteger)count delay:(CGFloat)delay
{
    return [self animationWithFrameName:name frameCount:count delay:delay beginIndex:1 desc:NO];
}

+ (CCAnimation *)animationWithFrameName:(NSString *)name frameCount:(NSInteger)count delay:(CGFloat)delay desc:(BOOL)isDesc
{
    return [self animationWithFrameName:name frameCount:count delay:delay beginIndex:1 desc:isDesc];
}

+ (CCAnimation *)animationWithFrameName:(NSString *)name frameCount:(NSInteger)count delay:(CGFloat)delay beginIndex:(NSInteger)begin desc:(BOOL)isDesc
{
    CCSpriteFrameCache *frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
    
    NSMutableArray *frames = [NSMutableArray arrayWithCapacity:count];
    int maxIndex = begin + count;
    for (int i = begin; i < maxIndex; i++) {
        int index = i;
        if (isDesc == YES) {
            index = maxIndex - i;
        }
        NSString *file = [NSString stringWithFormat:@"%@%.2d.png", name, index];
        CCSpriteFrame *frame = [frameCache spriteFrameByName:file];
        [frames addObject:frame];
    }
    return [CCAnimation animationWithSpriteFrames:frames delay:delay];
}

+ (CCAnimation *)animationWithFrameName:(NSString *)name frameOrder:(NSString *)orderString delay:(CGFloat)delay
{
    // frame order String   // @"1,2,1,3,4" ...
    CCSpriteFrameCache *frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
    NSArray *frameArray = [orderString componentsSeparatedByString:@","];
    int count = [frameArray count];
    NSMutableArray *frames = [NSMutableArray arrayWithCapacity:count];
    for (NSString *numString in frameArray) {
        NSString *file = [NSString stringWithFormat:@"%@%.2d.png", name, [numString integerValue]];
        CCSpriteFrame *frame = [frameCache spriteFrameByName:file];
        [frames addObject:frame];
    }
    return [CCAnimation animationWithSpriteFrames:frames delay:delay];
}

@end
