//
//  CCNodeAdditions.m
//  DropCube
//
//  Created by Be on 14-4-20.
//  Copyright (c) 2014年 Be. All rights reserved.
//

#import "CCNodeAdditions.h"

@implementation CCNode (CCNodeAdditions)

/*
float kAdjustWidthForIPad(float f)
{
    if (G_IS_IPAD == YES) {
//        return ((f / 320.0) * 768.0);
        return 64 + f * 2;
    } else {
        return f;
    }
}

float kAdjustHeightForIPad(float f)
{
    if (G_IS_IPAD == YES) {
        return f * 2;
    } else {
        return f;
    }
}
*/

float getRS(float f)
{
    if (G_IS_IPAD == YES) {
        return f * 2;
    } else {
        return f;
    }
}
float getRS_W(float f)
{
    if (G_IS_IPAD == YES) {
        return (f+32)*2;
    } else {
        return f;
    }
}
float getRS_H(float f)
{
    if (G_IS_IPAD == YES) {
        return (f+16)*2;
    } else {
        return f;
    }
}

@end
