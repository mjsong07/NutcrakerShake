//
//  Thing.m
//  SoxFrame
//
//  Created by jason yang on 14-02-26
//
//

#import "Thing.h" 
#import "GameLayer.h"
#import "GameInfo.h"
@implementation Thing

+ (id)objInit:(ThingObjType)objType
{
    
    BaseSprite *base = [(Thing *)[self alloc] initWithImage :objType];
	return [base autorelease];
}

- (id)initWithImage  :(ThingObjType)objType
{
    
  //  NSString *imgName = @"star";
    NSString *imgName = [NSString stringWithFormat:@"chess_%d.png",objType];
 //   NSString *imgName = @"chess_3.png";
    if ((self = [super initWithSpriteFrameName:imgName])) {
        self.objType = objType;
    }
	return self;
}


//反弹
- (void)rebound:(HeroBump*)heroBump
{
    [self stopAllActions];
    int moveType = MoveTypeRight;
    if(heroBump.position.x>G_SCREEN_SIZE.width/2){//往右边移动
        moveType = MoveTypeLeft;
    }else{//往左边移动
        moveType = MoveTypeRight;
    }
    
    CCActionInterval *jump1 = nil;
    float t= 1;
    if(moveType == MoveTypeLeft){
        jump1 = [CCJumpTo actionWithDuration:t position:ccp(0,0) height:getRS(30) jumps:1];
    }else{
        jump1 = [CCJumpTo actionWithDuration:t position:ccp(G_SCREEN_SIZE.width,0) height:getRS(30) jumps:1];
    }
	CCActionInterval *rotate = [CCRotateBy actionWithDuration:t angle:360];
	id spawn = [CCSpawn actions:jump1, rotate, nil];
    id function = [CCCallFunc actionWithTarget:self selector:@selector(hideMe)];
    [self runAction:[CCSequence actions: spawn, function, nil]];
}
//下落
- (void)drop
{
    float s= G_SCREEN_SIZE.height;
    float s1= G_SCREEN_SIZE.width;
    float t = 586 / self.nowSpeed ;
    
//    float t = s / getRS(self.nowSpeed)  ;
     //特殊处理 如果是ipad  实际速度要＊2
    if(G_IS_IPAD){
        //t = t*2;
    }
    
    id moveTo = [CCMoveTo actionWithDuration:t position:ccp(self.position.x,getRS(100) )];
    id moveTo2 = [CCMoveTo actionWithDuration:t position:ccp(self.position.x, 0)];
    id function = [CCCallFunc actionWithTarget:self selector:@selector(hideMeAndChkSCore)];
    id move = [CCEaseOut actionWithAction:moveTo rate:0.4f]; 
    [self runAction:[CCSequence actions: move, function, moveTo2, nil]];
}

//上升
- (void)rise
{
    float s= G_SCREEN_SIZE.height;
     //特殊处理 如果是ipad  实际速度要＊2
//    float t = s/self.nowSpeed;
     float t = s / getRS(self.nowSpeed)  ;
    //特殊处理 如果是ipad  实际速度要＊2
    if(G_IS_IPAD){
      //  t = t*2;
    }

    id moveTo = [CCMoveTo actionWithDuration:t position:ccp(self.position.x, G_SCREEN_SIZE.height+ getRS(G_AD_HEIGHT))];
    id function = [CCCallFunc actionWithTarget:self selector:@selector(hideMe)];
    id move = [CCEaseIn actionWithAction:moveTo rate:0.4f];
    [self runAction:[CCSequence actions: move, function, nil]];
}



- (void)hideMe {
    self.visible = false; 
}


- (void)hideMeAndChkSCore {
    GameLayer *gameLayer = [GameHelper getGameLayer];
    if(gameLayer.nowGameState == GameStateStart){
       // if(self.objType == ThingObjChess0){
            [[GameHelper getGameInfo] addScore];
            [SOXSoundUtil play_star];
      //  }
    }
    self.visible = false;
}
 
@end
