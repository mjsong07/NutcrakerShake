//
//  BGLayer.m
//  SoxFrame
//
//  Created by jason yang on 13-5-16.
//
//

#import "BGLayer.h"
#import "CCAnimationHelper.h"
#import "GameLayer.h"
#import "GameHelper.h"
#import "ATAppTransferManager.h"
#import "BGParticleLayer.h"
@implementation BGLayer 
- (id)init
{
	if ((self = [super init])) {
//        CCSprite* sun = [CCSprite spriteWithFile:@"bg_sun.png"];
//        sun.anchorPoint = CGPointMake(0.5, 0.5);
//        sun.scale = 0.9;
        
        
        _dayType = 1;//默认早上
        
        CCSprite* earth = [CCSprite spriteWithFile:@"earth.png"];
        CCSprite* earth_all = [CCSprite spriteWithFile:@"earth_all.png"];
        CCSprite* sun = [CCSprite spriteWithFile:@"sun.png"];
        CCSprite* moon = [CCSprite spriteWithFile:@"moon.png"];
        CCSprite* h1 = [CCSprite spriteWithFile:@"h1.png"];
        CCSprite* h2 = [CCSprite spriteWithFile:@"h2.png"];
        CCSprite* h3 = [CCSprite spriteWithFile:@"h3.png"];
        CCSprite* h4 = [CCSprite spriteWithFile:@"h4.png"];
        CCSprite* bg_white = [CCSprite spriteWithFile:@"bg_white.png"];//bg_white.png
        CCSprite* bg_black = [CCSprite spriteWithFile:@"bg_black.png"];
         
        bg_white.visible = false;
        bg_black.visible = false;
        sun.visible = false;
        moon.visible = false;
        earth.visible = false;
       // earth.opacity = 100;
        earth_all.visible = false;
      //  earth_all.color = ccRED;
        
        
        h1.visible = false;
        h2.visible = false;
        h3.visible = false;
        h4.visible = false;
        
        h1.opacity = 102;
        h2.opacity = 102;
        h3.opacity = 102;
        h4.opacity = 102;
        
        [self addChild:h1 z:10 tag:T_BG_House1];
        [self addChild:h2 z:10 tag:T_BG_House2];
        [self addChild:h3 z:10 tag:T_BG_House3];
        [self addChild:h4 z:10 tag:T_BG_House4];
        
       
        [self addChild:earth z:20  tag:T_BG_Earth];
        [self addChild:earth_all z:21  tag:T_BG_EarthAll];
        
        [self addChild:sun z:0 tag:T_BG_Sun];
        [self addChild:moon z:0 tag:T_BG_Moon];
        
        
        
        [self addChild:bg_white z:-1 tag:T_BG_White];
        [self addChild:bg_black z:-1 tag:T_BG_Black];
        
        bg_white.anchorPoint = ccp(0, 0);
        bg_white.position = ccp(0, 0);
        
//        bg_white.color = ccSOX_BLUE2;
//        bg_black.color = ccSOX_BLUE2;//ccSOX_GRAY2;
        bg_black.anchorPoint = ccp(0, 0);
        bg_black.position = ccp(0, 0);
        
        showSunMoonX_ =G_SCREEN_SIZE.width* 5/6;
        
        showSunMoonY_ =G_SCREEN_SIZE.height * 4/5;
        
	}
	return self;
}

- (void)showBgWhite
{
    CCSprite *bg_white = (CCSprite*)[self getChildByTag:T_BG_White];
    bg_white.visible = true;
    CCSprite *bg_black = (CCSprite*)[self getChildByTag:T_BG_Black];
    bg_black.visible = false;
}

- (void)showBgBlack
{
    CCSprite *bg_white = (CCSprite*)[self getChildByTag:T_BG_White];
    bg_white.visible = false;
    CCSprite *bg_black = (CCSprite*)[self getChildByTag:T_BG_Black];
    bg_black.visible = true;
    
}
 

//开始动画
- (void)startMoive
{
    [self showBgWhite];
//    [self scheduleUpdate];
    [self showSun];
    [self playBGSoundEffect];
    [self showEarth];
    [self showHouse:10 :1 :-35 :ccp(getRS_W(100) , getRS(30)) :ccp(getRS(-50),getRS(50) )];
    [self showHouse:11 :1.3 :-10 :ccp(getRS_W(120), getRS(40)) :ccp(getRS(0),getRS(80) )];
    [self showHouse:12 :1.6 :10 :ccp(getRS_W(210), getRS(40)) :ccp(getRS(0),getRS(110))];
    [self showHouse:13 :2.0 :35 :ccp(getRS_W(240), getRS(40)) :ccp(getRS(50),getRS(50) )];
    [self showEarthAll];
    [[GameHelper getHero] birth];
}

//给震动背景 调用
- (void)setShowLayer
{
    
    
    [self showBgWhite];
    CCSprite *earth_all = (CCSprite*)[self getChildByTag:T_BG_EarthAll];
  //  CCSprite *earth = (CCSprite*)[self getChildByTag:T_BG_Earth];
    earth_all.visible = true;
    earth_all.position =   ccp(G_SCREEN_SIZE.width/2,getRS(-98));
    CCSprite *sun = (CCSprite*)[self getChildByTag:T_BG_Sun];
    sun.position = ccp(showSunMoonX_, showSunMoonY_);
    sun.visible = true;
    
}


- (void)showEarth
{
    CCDelayTime *delay1 = [CCDelayTime actionWithDuration:0];
    float time = 1.0;
    CCSprite *earth = (CCSprite*)[self getChildByTag:T_BG_Earth];
    earth.visible =true;
   // earth.anchorPoint = ccp(0, 0);
    //上移动 效果
    earth.position = ccp(G_SCREEN_SIZE.width/2, -earth.contentSize.height/2);
    id move = [CCMoveTo actionWithDuration:time position:ccp(G_SCREEN_SIZE.width/2, -earth.contentSize.height/4)];
    //摇动效果
   // earth.rotation = -180;
   // id rotate = [CCRotateTo actionWithDuration:time angle:0];
   // earth.position = ccp(G_SCREEN_SIZE.width/2, earth.contentSize.height/2);
    id ease2 = [CCEaseElasticOut actionWithAction:move];
   
    id seq1 = [CCSequence actions:delay1,ease2,nil];
    [earth runAction:seq1];
}

//开始 大背景地球旋转同时 因此开始显示的 屋子  和 地球
- (void)showEarthAll
{
    CCDelayTime *delay1 = [CCDelayTime actionWithDuration:5];//2
    CCSprite *earthAll = (CCSprite*)[self getChildByTag:T_BG_EarthAll];
    earthAll.visible =false;
    earthAll.position =   ccp(G_SCREEN_SIZE.width/2, getRS(-98 ));
    id show1 =  [CCShow action];
    id hideHouseAndEarth = [CCCallFunc actionWithTarget:self selector:(@selector(setHideHouseAndEarth))];
    id function2 = [CCCallFunc actionWithTarget:self selector:(@selector(toRunShakeBg))];
    id seq1 = [CCSequence actions:delay1,hideHouseAndEarth,show1,function2,nil];
    [earthAll runAction:seq1];
}


- (void)setHideHouseAndEarth
{
    
     CCSprite *earth = (CCSprite*)[self getChildByTag:T_BG_Earth];
     CCSprite *h1 = (CCSprite*)[self getChildByTag:T_BG_House1];
     CCSprite *h2 = (CCSprite*)[self getChildByTag:T_BG_House2];
     CCSprite *h3 = (CCSprite*)[self getChildByTag:T_BG_House3];
     CCSprite *h4 = (CCSprite*)[self getChildByTag:T_BG_House4];
     h1.visible = false;
     h2.visible = false;
     h3.visible = false;
     h4.visible = false;
     earth.visible = false;
}


- (void)showHouse :(NSInteger)tag :(ccTime)d :(float)rot  :(CGPoint)start :(CGPoint)move
{
    CCDelayTime *delay1 = [CCDelayTime actionWithDuration:d];
    float time = 1.0;
    CCSprite *h1 = (CCSprite*)[self getChildByTag:tag];
    h1.visible =false;
    h1.rotation = rot;
    h1.position =  start;
    id move1 = [CCMoveBy actionWithDuration:time position:move];
    id show1 =  [CCShow action];
    id ease1 = [CCEaseElasticOut actionWithAction:move1];
    id seq1 = [CCSequence actions:delay1,show1,ease1,nil];
    [h1 runAction:seq1];
}
- (void)showSun
{
     [self showBgWhite];
    CCDelayTime *delay1 = [CCDelayTime actionWithDuration:0.5];
    float time = 1.0;
    CCSprite *sun = (CCSprite*)[self getChildByTag:T_BG_Sun];
    sun.visible = true;
    sun.position =  ccp(showSunMoonX_, G_SCREEN_SIZE.height+sun.contentSize.height/2);
    id move1 = [CCMoveTo actionWithDuration:time position:ccp(showSunMoonX_, showSunMoonY_)];
    id ease1 = [CCEaseElasticOut actionWithAction:move1];
    id seq1 = [CCSequence actions:delay1,ease1,nil];
    [sun runAction:seq1];
}



- (void)showSunToMoon
{
    [self showBgBlack];
    
    //先隐藏 太阳
    float time = 1.0;
    CCSprite *sun = (CCSprite*)[self getChildByTag:T_BG_Sun];
    sun.visible = true;
    id moveSun = [CCMoveTo actionWithDuration:time position:ccp(showSunMoonX_, G_SCREEN_SIZE.height+sun.contentSize.height/2 +getRS(2))];
    id easeSun = [CCEaseElasticOut actionWithAction:moveSun];
    //在显示 月亮
    CCDelayTime *delayMoon = [CCDelayTime actionWithDuration:0.5];
    CCSprite *moon = (CCSprite*)[self getChildByTag:T_BG_Moon];
    moon.visible = true;
    moon.position =  ccp(G_SCREEN_SIZE.width* 5/6, -moon.contentSize.height/2);
    id moveMoon = [CCMoveTo actionWithDuration:time position:ccp(showSunMoonX_, showSunMoonY_)];
    id easeMoon = [CCEaseElasticOut actionWithAction:moveMoon];
     id fun = [CCCallFunc actionWithTarget:self selector:(@selector(showBgParticleFun))];
    id seqMoon = [CCSequence actions: delayMoon,easeMoon,fun,nil];
    [sun runAction:easeSun];
    [moon runAction:seqMoon];
    
   
    //声音播放
    id soundSun = [CCCallFunc actionWithTarget:self selector:(@selector(playSoundSun))];
    id soundMoon = [CCCallFunc actionWithTarget:self selector:(@selector(playSoundMoon))];
    [self runAction:[CCSequence actions:delayMoon,soundMoon, nil]];
}

- (void)showBgParticleFun
{
    [[GameHelper getBG_ParticleLayer]showBgParticle];
}


- (void)showMoonToSun
{
    
    
    //先隐藏 月亮
    float time = 1.0;
    CCSprite *moon = (CCSprite*)[self getChildByTag:T_BG_Moon];
    moon.visible = true;
   // moon.position =  ccp(G_SCREEN_SIZE.width* 5/6, 0);
    id moveMoon = [CCMoveTo actionWithDuration:time position:ccp(showSunMoonX_,-moon.contentSize.height/2)];
    id easeMoon = [CCEaseElasticOut actionWithAction:moveMoon];
    //在显示 太阳
    CCDelayTime *delaySun = [CCDelayTime actionWithDuration:0.5];
     CCDelayTime *delayBGWhite = [CCDelayTime actionWithDuration:0.3];
    CCSprite *sun = (CCSprite*)[self getChildByTag:T_BG_Sun];
    sun.visible = true;
    id moveSun = [CCMoveTo actionWithDuration:time position:ccp(showSunMoonX_, showSunMoonY_)];
    id easeSun = [CCEaseElasticOut actionWithAction:moveSun];
    //
    id showWhtie = [CCCallFunc actionWithTarget:self selector:(@selector(showBgWhite))];
    
    id seqSun = [CCSequence actions: delaySun,easeSun,nil];
    
    id seqShowWhite = [CCSequence actions: delayBGWhite,showWhtie,nil];
    
    [self runAction:seqShowWhite];
    [moon runAction:easeMoon];
    [sun runAction:seqSun];
    //声音播放
    id soundSun = [CCCallFunc actionWithTarget:self selector:(@selector(playSoundSun))];
    id soundMoon = [CCCallFunc actionWithTarget:self selector:(@selector(playSoundMoon))];
    [self runAction:[CCSequence actions:delaySun,soundMoon, nil]];
}









//播放 开场背景音乐
- (void)playBGSoundEffect
{
    //播放开始游戏效果的 背音  含人物
    //地球
    id deplay = [CCDelayTime actionWithDuration:0.8f];
    id deplay1 = [CCDelayTime actionWithDuration:0.35f];
    id deplay2 = [CCDelayTime actionWithDuration:0.35f];
    id deplay3 = [CCDelayTime actionWithDuration:0.35f];
    id deplay4 = [CCDelayTime actionWithDuration:0.35f];
    id funEarth = [CCCallFunc actionWithTarget:self selector:(@selector(playSoundEarth))];
    id funSun = [CCCallFunc actionWithTarget:self selector:(@selector(playSoundSun))];
    id funHouse1 = [CCCallFunc actionWithTarget:self selector:(@selector(playSoundHouse))];
    id funHouse2 = [CCCallFunc actionWithTarget:self selector:(@selector(playSoundHouse))];
    id funHouse3 = [CCCallFunc actionWithTarget:self selector:(@selector(playSoundHouse))];
    id funHouse4 = [CCCallFunc actionWithTarget:self selector:(@selector(playSoundHouse))];
    
    id dHero1 = [CCDelayTime actionWithDuration:0.2];
    id dHero2 = [CCDelayTime actionWithDuration:0.35f];
    id funhero1 = [CCCallFunc actionWithTarget:self selector:(@selector(playSoundHeroFall))];
    id funhero2 = [CCCallFunc actionWithTarget:self selector:(@selector(playSoundHeroFall))];
    
    [self runAction:[CCSequence actions:funEarth,deplay,funSun,deplay1,funHouse1,deplay2,funHouse2,deplay3,funHouse3,deplay4, funHouse4,dHero1,funhero1,dHero2,funhero2, nil]];
    
}
- (void)playSoundEarth
{
    [SOXSoundUtil play_zoom];
}
- (void)playSoundSun
{
    [SOXSoundUtil play_pullDown];
}
- (void)playSoundMoon
{
    [SOXSoundUtil play_pullDown];
}


- (void)playSoundHouse
{
    [SOXSoundUtil play_popUp];
}

- (void)playSoundHeroFall
{
    [SOXSoundUtil play_beginFall];
}


//同时运行 震动的 背景效果
- (void)toRunShakeBg
{
    [self scheduleUpdate];
    [[GameHelper getBGShakeLayer] setShowLayer];
    [[GameHelper getBGShakeLayer] scheduleUpdate];
}
- (void)update:(ccTime)delta
{ 
    
    CCSprite *earthAll = (CCSprite*)[self getChildByTag:T_BG_EarthAll];
    earthAll.rotation =earthAll.rotation  +0.05 ;//按这个速度 一分钟 转一圈
    //日夜切换 按 半分钟 切换一次
    nowTotalTime_ = nowTotalTime_+1;//0.5
      if(nowTotalTime_>=1350){//1350切换  早日晚  3600/4 = 900    1800+900 = 2700
        nowTotalTime_ = 0;
        if(_dayType == 1){
            _dayType=2;
            [self showSunToMoon];
           
            
            [[GameHelper getScoreLayer] setAllColor:ccWHITE];
            [[GameHelper getIndexLayer] setAllColor:ccWHITE];
            [[GameHelper getGameInfo] setAllColor:ccWHITE];
            UIColor *color =   [UIColor colorWithRed:((float) 255 / 255.0f)
                                               green:((float) 255 / 255.0f)
                                                blue:((float) 255 / 255.0f) alpha:1.0f];
            
            
            [ATAppTransferManager setBackColor:color];
            
        }else if(_dayType == 2){
            _dayType = 1;
            [self showMoonToSun];
            [[GameHelper getBG_ParticleLayer] hideBgParticle];
            [[GameHelper getScoreLayer] setAllColor:ccSOX_BTN_BASE];
            [[GameHelper getIndexLayer] setAllColor:ccSOX_BTN_BASE];
            [[GameHelper getGameInfo] setAllColor:ccSOX_BTN_BASE];
            
            UIColor *color =   [UIColor colorWithRed:((float) 231 / 255.0f)
                                               green:((float) 133 / 255.0f)
                                                blue:((float) 16 / 255.0f) alpha:1.0f];
            [ATAppTransferManager setBackColor:color];
            
        }
    }
 //   [SOXDebug logInt:nowTotalTime_];
    if(_dayType == 1){
        CCSprite *sun = (CCSprite*)[self getChildByTag:T_BG_Sun];
        sun.rotation =sun.rotation  -0.09 ;
        
    }else{
        CCSprite *moon = (CCSprite*)[self getChildByTag:T_BG_Moon];
        if(moon.scale>=1){
            increase_ = -1;
        }
        if(moon.scale<=0.8){
            increase_ =  1;
        }
        moon.scale  = moon.scale   +  0.001* increase_;
        
        
    }
    
}
- (void)dealloc
{
	[super dealloc];
}



/*
 - (void)showSun
 {
 CCSprite *sun = (CCSprite*)[self getChildByTag:3];
 sun.visible =true;
 float time = 1;
 //id camera = [CCOrbitCamera actionWithDuration:time radius: 10 deltaRadius:0 angleZ:0 deltaAngleZ:180 angleX:0 deltaAngleX:0];
 sun.position = G_SCREEN_CENTER;
 sun.scale = 0.5;
 // sun.scale = 1;
 id scaleTo = [CCScaleTo actionWithDuration:time scale:0.9];
 //id ease = [CCEaseElasticOut actionWithAction:camera  ];
 id ease = [CCEaseElasticOut actionWithAction:scaleTo  ];
 id sun1 =  [CCTargetedAction actionWithTarget:sun action:ease];
 
 
 
 id scaleTo = [CCScaleTo actionWithDuration:time scale:0.5];
 id scaleTo2 = [CCScaleTo actionWithDuration:time scale:1];
 //id ease = [CCEaseElasticOut actionWithAction:camera  ];
 id easeScale = [CCEaseElasticOut actionWithAction:scaleTo  ];
 id easeScale2 = [CCEaseElasticOut actionWithAction:scaleTo2  ];
 
 id seq2 = [CCSequence actions:easeScale,easeScale2,nil];
 id forver = [CCRepeatForever actionWithAction:seq2];
 [sun runAction:forver];
 }*/


@end
