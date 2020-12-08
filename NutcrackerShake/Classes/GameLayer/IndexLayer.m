//
//  GameLayer.m
//  SoxFrame
//
//  Created by jason yang on 14-02-26
//
//

#import "IndexLayer.h"
#import "MenuMusicInfo.h"
#import "MenuGameCenterInfo.h" 
#import "GameLayer.h"
#import "BGLayer.h"
@implementation IndexLayer {
   
}

- (id)init
{
    if(self = [super init]){
        MenuMusicInfo *musicInfo= [[[MenuMusicInfo alloc ]init:T_SOUND_GAME]autorelease];
         MenuGameCenterInfo *gamecenter= [[[MenuGameCenterInfo alloc ]init]autorelease];
        float margin_top =  getRS(75);//[SU s:[gamecenter getHeight]/2];//78
        
        [musicInfo setPosition:ccp([musicInfo getWidth]/2, G_SCREEN_SIZE.height-margin_top)];
        [gamecenter setPosition:ccp(G_SCREEN_SIZE.width-[gamecenter getWidth]/2,G_SCREEN_SIZE.height-margin_top)];
        
        float help_top = getRS(28) ;
        float tap_top = getRS(40) ;
        if(G_IS_IPAD){//ipad 特殊处理
            help_top = getRS(58);
            tap_top = getRS(10) ;
        }
        if(G_IS_IPHONE){
            if(G_IS_IPHONE_4){//iphone4 特殊处理
                help_top = getRS(58);
                tap_top = getRS(10) ;
            }
        }
        
       

        
        CCSprite *help = [CCSprite spriteWithFile:@"game_help.png" ];
        help.position = ccp(G_SCREEN_CENTER.x+ getRS(-7), G_SCREEN_CENTER.y+ help_top );
        help.scale = 0.7;
        
        CCSprite *promptTap = [CCSprite spriteWithFile:@"menu_prompt_tap.png" ];
        promptTap.position = ccp(G_SCREEN_CENTER.x+ getRS(35) , G_SCREEN_CENTER.y- tap_top);
        //promptTap.color = ccSOX_BTN_BASE;
      
        
        [self addChild:musicInfo z:0 tag:0];
        [self addChild:gamecenter z:0 tag:1];
        [self addChild:promptTap z:0 tag:2];
        [self addChild:help z:0 tag:3];
        
       // imgSprite.visible = false;
       // help.visible = false;
        self.visible = false;
        
    }
    return self;
}


- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self stopAllActions];
    [self hideLayer];
    [SOXSoundUtil play_btn];
    [[GameLayer sharedGameLayer] startGame];
}
- (void)hideLayer
{
    CCNode *sp =   [self getChildByTag:2];
    CCNode *sp2 =   [self getChildByTag:3];
    [self stopAllActions];
    [sp stopAllActions];
    [sp2 stopAllActions];
	self.visible = false;
    [self setTouchEnabled:false];
}

- (void)showLayer
{
	self.visible = true;
    [self setTouchEnabled:true];
}
//自动 效果隐藏
- (void)autoShowLayer
{
    self.visible = true;
    [self setTouchEnabled:true];
    CCFadeIn *fadeIn = [CCFadeIn actionWithDuration:1.0f];
	id fadeOut = [fadeIn reverse];
   // CCNode *promptTap =   [self getChildByTag:2];
    CCNode *help =   [self getChildByTag:3];
    id flipX = [CCFlipX actionWithFlipX:true];
    id flipX2 = [flipX reverse];
    CCRepeatForever *repeat2 = [CCRepeatForever actionWithAction: [CCSequence actions: fadeIn,fadeOut,flipX ,fadeIn,fadeOut,flipX2, nil]];
    [help runAction:repeat2];
    
}
- (void)autoHideLayer
{
    
    CCFadeOut *fadeOut = [CCFadeOut actionWithDuration:1.0f];
    CCNode *sp =   [self getChildByTag:2];
    CCNode *sp2 =   [self getChildByTag:3];
    [self stopAllActions];
    [sp stopAllActions];
    [sp2 stopAllActions];
    
    id function = [CCCallFunc actionWithTarget:self selector:@selector(hideLayer)];
    [sp runAction:[CCSequence actions: fadeOut, function, nil]];
    [sp2 runAction:[[fadeOut copy]autorelease]];
}

- (void)setAllColor:(ccColor3B)color
{
    
    MenuMusicInfo *sp = (MenuMusicInfo*)[self getChildByTag:0];
    MenuGameCenterInfo *sp2 = (MenuGameCenterInfo*)[self getChildByTag:1]; 
    [sp setAllColor:color];
    [sp2 setAllColor:color];
}



@end
