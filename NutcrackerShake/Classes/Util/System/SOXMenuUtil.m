//
//  SOXMapUtil.m
//  SoxFrame
//
//  Created by jason yang on 13-5-27.
//
//

#import "SOXMenuUtil.h"
@implementation SOXMenuUtil

static SOXMenuUtil *soxMenuUtil = nil;
+(SOXMenuUtil*) sharedMenuUtil {
    
    if (soxMenuUtil == nil) {
        soxMenuUtil = [[SOXMenuUtil alloc] init] ;
    }
    return  soxMenuUtil;
}

- (CCMenu*)init:(id)imgUrl target:(id)target selector:(SEL)selector
{
    CCSprite *imgSprite = [CCSprite spriteWithFile:imgUrl ];
    CCMenuItemSprite *item =  [ CCMenuItemSprite itemWithNormalSprite:imgSprite selectedSprite:nil
                                                               target:target selector:(SEL)selector ];
    CCMenu  *menu = [CCMenu menuWithItems: item,nil];
    [menu alignItemsHorizontally];
    [menu alignItemsHorizontallyWithPadding:10];
	return menu ;
}

@end
