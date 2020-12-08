//
//  PauseLayer
//  SoxFrame
//
//  Created by jason yang on 14-02-26
//
//

#import "PauseLayer.h"
#import "GameLayer.h" 
#import "SOXMenuUtil.h"
@implementation PauseLayer

- (id)init
{
	if (self = [super init]) {
         CCMenu  *menuStart_= [[SOXMenuUtil sharedMenuUtil] init:@"menu_start.png" target:self selector:@selector(toContinue:)];
        [self addChild:menuStart_];
        [self hideLayer];
	}
	return self;
}


//重新开始
- (void)toContinue:(id) sender
{
    [SOXSoundUtil play_btn];
    [[CCDirector sharedDirector]resume];
}


- (void)hideLayer
{
	self.visible = false;
    [self setTouchEnabled:false];
}

- (void)showLayer
{
	self.visible = true;
    [self setTouchEnabled:true];
}

- (void)dealloc
{ 
    [super dealloc];
    
}

@end
