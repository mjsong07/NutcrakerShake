//
//  LoadingScreen.m
//
//  Created by Six Foot Three Foot on 28/05/12.
//  Copyright 2012 Six Foot Three Foot. All rights reserved.
//

#import "LoadingScreen.h"
#import "SimpleAudioEngine.h"

//The next scene you wish to transition to.

@implementation LoadingScreen

+(CCScene *) scene
{
    
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	
    NSString *className = NSStringFromClass([self class]);
    // 'layer' is an autorelease object.
    id layer = [NSClassFromString(className) node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}



#pragma mark初始化

-(id) init
{
    
    if ( ( self = [ super init] ) )
    {
        progress = [CCProgressTimer progressWithSprite:[CCSprite spriteWithFile:@"progressbar.png"]];
        [progress setPercentage:0.0f];
        progress.scale = 0.5f;
        progress.midpoint = ccp(0,0.5);
        progress.barChangeRate = ccp(1,0);
        progress.type = kCCProgressTimerTypeBar;
        
        
        NSString *strLoading =   NSLocalizedString(@"LoadingTip", @"");
        
        double historyBestScore =[SOXDBUtil loadInfoReturnDouble:G_KEY_LEADERBOARD_SCORE];
        if(historyBestScore >= 80){//如果分数大于  最高级  不显示提示了
              strLoading =   NSLocalizedString(@"Loading", @"");
        }
		
        
        CCLabelTTF *loadingText = [CCLabelTTF labelWithString:strLoading  fontName:@"Arial" fontSize:getRS(15)];
        loadingText.color = ccBLACK;
        
      //  CCSprite  *bg =  [CCSprite spriteWithFile:@"bg_sun.png"];
        CCSprite  *loadingImg =  [CCSprite spriteWithFile:@"loading_img.png"];
        float time = 1.5f;
        id jump = [CCJumpBy actionWithDuration:time position:ccp(getRS(50),0) height:getRS(20) jumps:3];
        id jump2 = [jump reverse];
        id  seq2 = [CCSequence actions:jump,jump2, nil];
        [loadingImg runAction: [CCRepeatForever actionWithAction:seq2]];
        loadingText.position = ccp(G_SCREEN_CENTER.x,G_SCREEN_CENTER.y-getRS(50));
      //  bg.position = G_SCREEN_CENTER;
        progress.position = G_SCREEN_CENTER;
        loadingImg.position = ccp(G_SCREEN_CENTER.x-getRS(28), G_SCREEN_CENTER.y+getRS(25));
       // CCLayerColor *bgcolor = [CCLayerColor layerWithColor:ccc4(255, 255, 0, 255)];
        CCLayerColor *bgcolor = [CCLayerColor layerWithColor:ccc4(255, 255, 255, 255)];
        
        
       // bgcolor.position = G_SCREEN_CENTER;
        
        [self addChild: bgcolor z:-1];
        //[self addChild:bg z:0];
        [self addChild:loadingImg z:1];
        [self addChild:progress z:1];
        [self addChild:loadingText z:1];
    }
    
    return self;
}

-(void) onEnterTransitionDidFinish
{
    [super onEnterTransitionDidFinish];
    
    NSString *path = [[CCFileUtils sharedFileUtils] fullPathFromRelativePath:@"loading.plist"];
    NSDictionary *manifest = [NSDictionary dictionaryWithContentsOfFile:path];
    NSArray *image         = [manifest objectForKey:@"Image"];
    NSArray *plist          = [manifest objectForKey:@"Plist"];
    NSArray *sound   = [manifest objectForKey:@"Sound"];
    
    assetCount = ([image count] + [plist count] + [sound count]);
    progressInterval = 100.0 / (float) assetCount;
    
    if (sound)
        [self performSelectorOnMainThread:@selector(loadSounds:) withObject:sound waitUntilDone:YES];
    
    
    if (image)
        [self performSelectorOnMainThread:@selector(loadImages:) withObject:image waitUntilDone:YES];
    
    if (plist)
        [self performSelectorOnMainThread:@selector(loadSpriteFrameCache:) withObject:plist waitUntilDone:YES];
    
    
    
}


-(void) loadSounds:(NSArray *) soundClips
{
    for (NSString *soundClip in soundClips)
    {
        [[SimpleAudioEngine sharedEngine] preloadEffect:soundClip];
        [self progressUpdate];
    }
}


-(void) loadSpriteFrameCache:(NSArray *) spriteFrameCache
{
    for (NSString *spriteSheet in spriteFrameCache)
    {
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:spriteSheet];
        [self progressUpdate];
    }
}

-(void) loadImages:(NSArray *) images
{
    for (NSString *image in images)
    {
        [[CCTextureCache sharedTextureCache] addImage:image];
        [self progressUpdate];
    }
}

-(void) progressUpdate
{
    if (--assetCount)
    {
        [progress setPercentage:(100.0f - (progressInterval * assetCount))];
    }
    else {
        CCProgressFromTo *ac = [CCProgressFromTo actionWithDuration:0.5 from:progress.percentage to:100];
        CCCallBlock *callbak = [CCCallBlock actionWithBlock:^(){
            [self loadingComplete];
            
        }];
        id action = [CCSequence actions:ac,callbak, nil];
        [progress runAction:action];
        
    }
    
}

-(void) loadingComplete
{
    CCDelayTime *delay = [CCDelayTime actionWithDuration:2.0f];
    CCCallBlock *swapScene = [CCCallBlock actionWithBlock:^(void) {
        CCScene* newScene = [SceneSwitch showScene:T_SCENE_GAME_LAYER];
        [[CCDirector sharedDirector] replaceScene:newScene];
    }];
    
    CCSequence *seq = [CCSequence actions:delay, swapScene, nil];
    [self runAction:seq];
}

@end
