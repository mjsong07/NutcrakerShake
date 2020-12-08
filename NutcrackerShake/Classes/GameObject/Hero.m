 
#import "Hero.h"
#import "IndexLayer.h"
@implementation Hero {
    
}
+ (id)objInit
{ 
    Hero *sprite = [[self alloc] initWithImage];
	return [sprite autorelease];
} 
- (id)initWithImage //只初始化图片动画  留给子类 重写实现
{
    //默认的
    if ((self = [super initWithSpriteFrameName:@"def_1.png"])) {
        CCAnimation *defAnimation1 = [CCAnimation animationWithFrameBeginEnd: @"def_"  suffix:@"png" frameCount:1 begin:1 end:1  delay:0.1f];
        self.defImgAct = [CCAnimate actionWithAnimation:defAnimation1];
        
        CCAnimation *deadAnimation1 = [CCAnimation animationWithFrameBeginEnd: @"def_"  suffix:@"png" frameCount:1 begin:2 end:2  delay:0.1f];
        self.deadImgAct = [CCAnimate actionWithAnimation:deadAnimation1];

        
        
        self.centerToLeft = self.contentSize.width/2;//
        self.baseInc = G_MOVE_DEF;
        self.anchorPoint = ccp(0.5, 0);
         self.position =  ccp( G_SCREEN_SIZE.width /2 , G_SCREEN_SIZE.height );
    }
    return self;
}


//第一次运行
- (void)birth
{
    self.rotation = 0;
    [self defaultDo];
    self.lifes = [SOXDBGameUtil loadNowLife];
    self.nowMoveType = MoveTypeStop;
}




//默认动作
- (void)defaultDo
{
    self.position =  ccp( G_SCREEN_SIZE.width /2 , G_SCREEN_SIZE.height );
    [self stopNowAction];
    self.nowActState = kActionStateDef;
    [self initDefAction];
    [self runAction:self.defAct];

    CCDelayTime *delay1 = [CCDelayTime actionWithDuration:2.2f];
    float time  = 0.8;
    id move = [CCMoveTo actionWithDuration:time position:ccp(self.position.x,0)];
    id move1 = [CCEaseBounceOut actionWithAction:move];
    id function = [CCCallFunc actionWithTarget:self selector:(@selector(toShowIndexLayer))];
    id seq = [CCSequence actions:delay1,move1,function,nil];
    [self runAction:seq];
}


//重生
- (void)toShowIndexLayer{
    [[GameHelper getIndexLayer] autoShowLayer];
}

//重生
- (void)revival{
    [SOXSoundUtil play_revival];
    [self stopNowAction];
    self.nowActState = kActionStateDef;
    [self initDefAction];
    [self runAction:self.defAct];
    
    float time = 1.5;
    id rotate = [CCRotateTo actionWithDuration:time angle:0];
    id move1 = [CCEaseElasticOut actionWithAction:rotate];
    
    
    id function = [CCCallFunc actionWithTarget:self selector:(@selector(toShowIndexLayer))];
    id seq = [CCSequence actions:move1,function,nil];
    [self runAction:seq];
    self.lifes = [SOXDBGameUtil loadNowLife];
    self.nowMoveType = MoveTypeStop;
    
}

//开始运动
- (void)run
{
    self.nowActState = kActionStateRun;
}

- (void)play_fall_sound
{
    [SOXSoundUtil play_fall];
}


//默认动作
- (void)dead
{
    [SOXSoundUtil play_hurt]; 
    id deplay1 = [CCDelayTime actionWithDuration:0.7];
    id deplay2 = [CCDelayTime actionWithDuration:0.7];
    id funPlaySound1 = [CCCallFunc actionWithTarget:self selector:(@selector(play_fall_sound))];
    [self runAction:[CCSequence actions:deplay1,funPlaySound1,deplay2,[funPlaySound1 copy], nil]];
    [self stopNowAction];
    self.nowActState = kActionStateDead;
    [self initDeadAction];
    [self runAction:self.deadAct];
    
    int muilt = 1;
    if(self.rotation >0){
        muilt = 1;
    }else {
        muilt = -1;
    }
    float time = 2;
    id rotate = [CCRotateTo actionWithDuration:time angle:100*muilt];
   //头昏效果
  //  id move = [CCEaseElasticIn actionWithAction:rotate period:0.4f];
    //正常倒下
    id move = [CCEaseBounceOut actionWithAction:rotate  ];
    //正常倒下2
//    id move = [CCEaseBackOut actionWithAction:rotate ];
    //人物倒下后 把 当前界面的 物品还原
   // id function = [CCCallFunc actionWithTarget:self selector:(@selector(toShowIndexLayer))];
    [self runAction:move];
}
- (void)updateAct:(ccTime)delta
{
    if(self.rotation<G_MOVE_ANGLE_MAX*(-1)){
        self.rotation = G_MOVE_ANGLE_MAX*(-1);
        self.nowMoveType = MoveTypeRight;
    }else if(self.rotation>G_MOVE_ANGLE_MAX){
        self.rotation=  G_MOVE_ANGLE_MAX;
        self.nowMoveType = MoveTypeLeft;
    }
    //设置 不倒翁 左右角度移动
    self.rotation = self.rotation + self.baseInc*self.nowMoveType;
}





//初始所有碰击box
- (void)initDefAction
{
    self.defAct = [CCRepeatForever actionWithAction:self.defImgAct];
    [self.defAct setTag:kActionStateDef];
}

- (void)initDeadAction
{
    self.deadAct = [CCRepeatForever actionWithAction:self.deadImgAct];
    [self.deadAct setTag:kActionStateDead];
}

- (void)stopNowAction
{
    [self stopActionByTag:self.nowActState];
}
@end
