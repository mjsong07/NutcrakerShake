//
//  LoadingScene.m
//  SoxFrame
//
//  Created by jason yang on 14-02-26
//
//

#import "SceneSwitch.h"
#import "LogoLayer.h"
#import "GameLayer.h"
@implementation SceneSwitch
+ (id)showScene:(TargetScene)targetScene
{  
    return [[[self alloc] initWithTargetScene:targetScene] autorelease];
}
- (id)initWithTargetScene:(TargetScene)targetScene
{
    if(self = [super init]){
        _targetScene = targetScene;
        CCLayerColor *bgcolor = [CCLayerColor layerWithColor:ccc4(255, 255, 255, 255)];
        [self addChild: bgcolor z:-1];
        [self scheduleUpdate]; 
    }
    return self;
}
- (void)update:(ccTime)delta
{
    [self unscheduleAllSelectors];
    switch (_targetScene) {
        case T_SCENE_NULL: 
            break;
        case T_SCENE_LOGO:
            [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[LogoLayer scene] withColor:ccWHITE]]; 
            break;
        case T_SCENE_GAME_LAYER:
            [[CCDirector sharedDirector] replaceScene:[GameLayer scene]];
            break;
        case T_SCENE_MAX:
            break;
    }
}
- (void)dealloc{
    [super dealloc];
}
@end