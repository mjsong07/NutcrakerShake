//
//  LogoLayer.m
//  SoxFrame
//
//  Created by jason yang on 14-02-26
//
//

#import "LogoLayer.h" 
@implementation LogoLayer
- (void)update:(ccTime)delta
{
    [self unscheduleAllSelectors]; 
    [[CCDirector sharedDirector] replaceScene: [SceneSwitch showScene:T_SCENE_GAME_LAYER]];
}
+(id)scene
{
    CCScene *scene = [CCScene node];
    [scene setTag:T_SCENE_LOGO];
    LogoLayer *logoLayer = [LogoLayer node];
    [scene addChild:logoLayer]; 
    return scene;
}
- (id)init
{
    if (self = [super init]) { 
        CCSprite *logoSprite = [CCSprite spriteWithFile:@"Default-568h@2x.png"];//sox-logo.png
        CGPoint center = G_SCREEN_CENTER;
        logoSprite.position = center;
        CCLayerColor *bgcolor = [CCLayerColor layerWithColor:ccc4(255, 255, 255, 255)];
        [self addChild:bgcolor z:0];
        [self addChild:logoSprite z:1]; 
        [self schedule:@selector(update:) interval:2.0f];
    }
    return self;
}

- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    CCScene* newScene = [SceneSwitch showScene:T_SCENE_GAME_LAYER];
	[[CCDirector sharedDirector] replaceScene:newScene];
}
@end
