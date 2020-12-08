//
//  ThingManager.m
//  SoxFrame
//
//  Created by jason yang on 14-02-26
//
//

#import "ThingManager.h"
#import "ThingCache.h"
#import "GameLayer.h" 
#import "SoxCCParticleExplosion.h"
#import "GameInfo.h"
@implementation ThingManager 


- (id)init
{
	self = [super init];
	if (self) {
        self.thingCache  = [ThingCache objInit];
        [self addChild:_thingCache];
        NSArray *array1 = [NSArray arrayWithObjects:@"10", @"50", @"100", nil];//倍数乘集
        NSArray *array2 = [NSArray arrayWithObjects:@"10",  @"50", @"240",nil];//要躲避右边边
        NSArray *array3 = [NSArray arrayWithObjects:@"10", @"200", @"240",@"280",nil];//要躲避左边
        NSArray *array4 = [NSArray arrayWithObjects:@"10", @"170", @"180",@"280",nil];//中间到两边  可能需要调整 有点 难玩
        NSArray *array5 = [NSArray arrayWithObjects:@"10", @"110", @"130",@"300",nil];//中间到两边
        dropArrayList_ = [[[NSMutableArray alloc] initWithCapacity:10]retain];
        revivalArray_ = [[NSArray arrayWithObjects:@"10",@"50", @"100", @"150",@"200",@"250",@"280",nil]retain];//复活 默认 效果
        [dropArrayList_ addObject:array1];
        [dropArrayList_ addObject:array2];
        [dropArrayList_ addObject:array3];
        [dropArrayList_ addObject:array4];
        [dropArrayList_ addObject:array5];
	}
	return self;
}
- (void)resetThing{
    [_thingCache resetAll];
}

- (float)getRandomSpeed{
 float createSpeed1 =arc4random()%G_THING_SPEED_MIN   + G_THING_SPEED_MAX;
    return createSpeed1;
}

- (void)createThing:(GameLevel)gameLevel{
    int  arrayIndex = arc4random()%4;// 2;//4;//
       float dropY =  G_SCREEN_SIZE.height- getRS(G_THING_SHOW_SUB_HEIGHT) ;
       // if(G_IS_IPAD){
      //        dropY =  G_SCREEN_SIZE.height- getRS(G_THING_SHOW_SUB_HEIGHT) -64;
      //  }
       // GameLevel gameLevel = [self getNowGameLevel];//获取当前得游戏等级
    
        if(gameLevel  == GameLevel1){//如果当前分数只有 5分以下  则 只显示 一个 棋子   要么左边 要么右边
            float random1 = arc4random()%280;
            float createX1 = 10+random1;
            float createSpeed1 =[self getRandomSpeed];
            int randomCreateType = [self getRandomCreateType];
            ccColor3B randomColor = [self getRandomColor];
            [_thingCache showObjDrop:randomCreateType :randomColor :createSpeed1 :ccp(createX1,dropY)];
            
        }else if(gameLevel == GameLevel2){//如果当前分数只有 5-10分以下  左边，右边一起显示
            float random1 = arc4random()%100;
            float random4 = arc4random()%90;
            
            float createX1 = 10+random1;
            float createX4 =  220+random4;
            
            float createSpeed1 =[self getRandomSpeed];
            float createSpeed3 =[self getRandomSpeed];
            int randomCreateType = [self getRandomCreateType];
            int randomCreateType3 = [self getRandomCreateType];
            ccColor3B randomColor = [self getRandomColor];
            ccColor3B randomColor3 = [self getRandomColor];
            
            [_thingCache showObjDrop:randomCreateType :randomColor :createSpeed1 :ccp(createX1,dropY)];
            [_thingCache showObjDrop:randomCreateType3 :randomColor3 :createSpeed3 :ccp(createX4,dropY)];
        
        }else if(gameLevel == GameLevel3){//正常难度
              NSArray *array  =  [dropArrayList_ objectAtIndex:arrayIndex];
            
            float createSpeed1 =[self getRandomSpeed];
            float createSpeed2 =[self getRandomSpeed];
            float createSpeed3 =[self getRandomSpeed];
            
            int randomCreateType = [self getRandomCreateType];
            int randomCreateType1 = [self getRandomCreateType];
            int randomCreateType2 = [self getRandomCreateType];
            int randomCreateType3 = [self getRandomCreateType];
            
            ccColor3B randomColor = [self getRandomColor];
            ccColor3B randomColor1 = [self getRandomColor];
            ccColor3B randomColor2= [self getRandomColor];
            ccColor3B randomColor3 = [self getRandomColor];
            
            if(arrayIndex== 0){//集中显示
                //            NSArray *array1 = [NSArray arrayWithObjects:@"10", @"50", @"100", nil];//倍数乘集
                float baseInc = arc4random()%130;
                float random1 = arc4random()%70;
                float random2 = arc4random()%70;
                float random3 = arc4random()%70;
                
                float createX1 = [(NSString*)array[0] intValue]+random1+baseInc;
                float createX2 = [(NSString*)array[1] intValue]+random2+baseInc;
                float createX3 = [(NSString*)array[2] intValue] +random3+baseInc;
                [_thingCache showObjDrop:randomCreateType :randomColor :createSpeed1 :ccp(createX1,dropY)];
                [_thingCache showObjDrop:randomCreateType1 :randomColor1 :createSpeed2 :ccp(createX2,dropY)];
                [_thingCache showObjDrop:randomCreateType2 :randomColor2 :createSpeed3 :ccp(createX3,dropY)];
            }else  if(arrayIndex== 1){//中间空开显示
                //            NSArray *array2 = [NSArray arrayWithObjects:@"10",  @"50", @"240",nil];
                float random1 = arc4random()%50;
                float random2 = arc4random()%40;
                float random3 = arc4random()%70;
                float createX1 = [(NSString*)array[0] intValue]+random1;
                float createX2 = [(NSString*)array[1] intValue]+random2;
                float createX3 =  [(NSString*)array[2] intValue]+random3;
                [_thingCache showObjDrop:randomCreateType :randomColor :createSpeed1 :ccp(createX1,dropY)];
                [_thingCache showObjDrop:randomCreateType1 :randomColor1 :createSpeed2 :ccp(createX2,dropY)];
                [_thingCache showObjDrop:randomCreateType2 :randomColor2 :createSpeed3 :ccp(createX3,dropY)];
            }else if(arrayIndex== 2){//中间空开显示
                //            NSArray *array3 = [NSArray arrayWithObjects:@"10", @"200", @"240",@"280",nil];
                float random1 = arc4random()%60;
                float random2 = arc4random()%40;
                float random3 = arc4random()%40;
                float random4 = arc4random()%40;
                float createX1 = [(NSString*)array[0] intValue]+random1;
                float createX2 = [(NSString*)array[1] intValue]+random2;
                float createX3 =  [(NSString*)array[2] intValue]+random3;
                float createX4 =  [(NSString*)array[3] intValue]+random4;
                [_thingCache showObjDrop:randomCreateType :randomColor :createSpeed1 :ccp(createX1,dropY)];
                [_thingCache showObjDrop:randomCreateType1 :randomColor1 :createSpeed2 :ccp(createX2,dropY)];
                [_thingCache showObjDrop:randomCreateType2 :randomColor2 :createSpeed3 :ccp(createX3,dropY)];
                float rand = arc4random()%10;
                if(rand>5){
                    [_thingCache showObjDrop:randomCreateType :randomColor3 :createSpeed3 :ccp(createX4,dropY)];
                }
            }else if(arrayIndex== 3){//中间空开显示
                //            NSArray *array4 = [NSArray arrayWithObjects:@"10", @"170", @"180",@"280",nil];//中间到两边
                float random1 = arc4random()%5;
                float random2 = arc4random()%20;
                float random3 = arc4random()%20;
                float random4 = arc4random()%10;
                
                float createX1 = [(NSString*)array[0] intValue]+random1;
                float createX2 = [(NSString*)array[1] intValue]+random2;
                float createX3 =  [(NSString*)array[2] intValue]+random3;
                float createX4 =  [(NSString*)array[3] intValue]+random4;
                
                
                [_thingCache showObjDrop:randomCreateType :randomColor :createSpeed1 :ccp(createX1,dropY)];
                [_thingCache showObjDrop:randomCreateType1 :randomColor1 :createSpeed2 :ccp(createX2,dropY)];
                [_thingCache showObjDrop:randomCreateType2 :randomColor2 :createSpeed3 :ccp(createX3,dropY)];
                [_thingCache showObjDrop:randomCreateType3 :randomColor3 :createSpeed3 :ccp(createX4,dropY)];
            }else if(arrayIndex== 4){//中间空开显示
                float random1 = arc4random()%20;
                float random2 = arc4random()%20;
                float random3 = arc4random()%10;
                float random4 = arc4random()%10;
                float createX1 = [(NSString*)array[0] intValue]+random1;
                float createX2 = [(NSString*)array[1] intValue]+random2;
                float createX3 =  [(NSString*)array[2] intValue]+random3;
                float createX4 =  [(NSString*)array[3] intValue]+random4;
                [_thingCache showObjDrop:randomCreateType :randomColor :createSpeed1 :ccp(createX1,dropY)];
                [_thingCache showObjDrop:randomCreateType1 :randomColor1 :createSpeed2 :ccp(createX2,dropY)];
                [_thingCache showObjDrop:randomCreateType2 :randomColor2 :createSpeed3 :ccp(createX3,dropY)];
                [_thingCache showObjDrop:randomCreateType3 :randomColor3 :createSpeed3 :ccp(createX4,dropY)];
            }
        } 
    }

- (GameLevel)getNowGameLevel
{
    GameLayer *gameLayer = [GameHelper getGameLayer];
    GameLevel gameLevel = GameLevel1;//默认最高
    
    //超过40分 认为是 高级游戏者  直接 跳过处理
    if(gameLayer.historyTopScore >= G_START_TO_HARD_CNT){
        gameLevel = GameLevel3;
    }else{
        GameInfo *gameInfo = [GameHelper getGameInfo];
        double nowScore_ = 0 ;
        if (gameInfo != nil){
            nowScore_ = [gameInfo.nowScore.string doubleValue];
        }
        if(nowScore_<=G_Level_1_CNT){//如果当前分数只有 5分以下  则 只显示 一个 棋子   要么左边 要么右边
            gameLevel = GameLevel1;
        }else if(nowScore_>G_Level_1_CNT && nowScore_<=G_Level_2_CNT){//如果当前分数只有 5-10分以下  左边，右边一起显示
            gameLevel = GameLevel2;
        }else{//正常难度
            gameLevel = GameLevel3;
        }
    }
    return gameLevel;
}



- (void)dealloc
{
    [dropArrayList_ release];
    [revivalArray_ release];
    [super release];
    [super dealloc];
}

//重生
- (void)revival{
    [_thingCache resetAll];
    float random1 = arc4random()%30;
    float random2 = arc4random()%30;
    float random3 = arc4random()%30;
    float random4 = arc4random()%30;
    float random5 = arc4random()%30;
    float random6 = arc4random()%30;
    float random7 = arc4random()%30;
    
    float createSpeed1 =[self getRandomSpeed];  
    float createSpeed2 =[self getRandomSpeed];   
    float createSpeed3 =[self getRandomSpeed];  
    float createSpeed4 =[self getRandomSpeed];  
    float createSpeed5 =[self getRandomSpeed];  
    float createSpeed6 =[self getRandomSpeed];  
    float createSpeed7 =[self getRandomSpeed];  
    
    float createX1 = [(NSString*)revivalArray_[0] intValue]+random1;
    float createX2 = [(NSString*)revivalArray_[1] intValue]+random2;
    float createX3 =  [(NSString*)revivalArray_[2] intValue]+random3;
    float createX4 =  [(NSString*)revivalArray_[3] intValue]+random4;
    float createX5 =  [(NSString*)revivalArray_[4] intValue]+random5;
    float createX6 =  [(NSString*)revivalArray_[5] intValue]+random6;
    float createX7 =  [(NSString*)revivalArray_[6] intValue]+random7;
    
    
    int randomCreateType = [self getRandomCreateType];
    int randomCreateType1 = [self getRandomCreateType];
    int randomCreateType2 = [self getRandomCreateType];
    int randomCreateType3 = [self getRandomCreateType];
    int randomCreateType4 = [self getRandomCreateType];
    int randomCreateType5 = [self getRandomCreateType];
    int randomCreateType6 = [self getRandomCreateType];
    
    ccColor3B randomColor = [self getRandomColor];
    ccColor3B randomColor1 = [self getRandomColor];
    ccColor3B randomColor2 = [self getRandomColor];
    ccColor3B randomColor3 = [self getRandomColor];
    ccColor3B randomColor4 = [self getRandomColor];
    ccColor3B randomColor5 = [self getRandomColor];
    ccColor3B randomColor6 = [self getRandomColor];
    
    [_thingCache showObjRise:randomCreateType :randomColor :createSpeed1 :ccp(createX1,0)];
    [_thingCache showObjRise:randomCreateType1 :randomColor1 :createSpeed2:ccp(createX2,0)];
    [_thingCache showObjRise:randomCreateType2 :randomColor2 :createSpeed3 :ccp(createX3,0)];
    [_thingCache showObjRise:randomCreateType3 :randomColor3 :createSpeed4 :ccp(createX4,0)];
    [_thingCache showObjRise:randomCreateType4 :randomColor4 :createSpeed5 :ccp(createX5,0)];
    [_thingCache showObjRise:randomCreateType5 :randomColor5 :createSpeed6 :ccp(createX6,0)];
    [_thingCache showObjRise:randomCreateType6 :randomColor6 :createSpeed7 :ccp(createX7,0)];
}

- (int)getRandomCreateType{
 int randomCreateType = arc4random()%6;
    return randomCreateType;
}

- (ccColor3B)getRandomColor{
    //主要颜色 红黄蓝
    ccColor3B randomColor = ccSOX_BLUE;
    int randomCreateType = arc4random()%5;
    if(randomCreateType == 0){
        randomColor = ccRED;
    }else if(randomCreateType == 1){
        randomColor = ccSOX_BLUE ;
    }else if(randomCreateType == 2){
        randomColor = ccSOX_GREEN;
    }else if(randomCreateType == 3){
        randomColor = ccSOX_PINK;
    }else if(randomCreateType == 4){
        randomColor = ccSOX_ORANGE2 ;
    }/*
    else if(randomCreateType == 5){
        randomColor = ccSOX_PURPLE;
    }else if(randomCreateType == 6){
        randomColor = ccSOX_BROWN;
    }else if(randomCreateType == 7){
        randomColor = ccSOX_BLACK;
    }*/
    
    
    
    
    
    
    return randomColor;
}


- (void)updateThing:(ccTime)delta :(HeroBump *)heroBump{
    int cnt = [_thingCache getNowShowIngThing ];
    
    GameLevel gameLevel = [self getNowGameLevel];//获取当前得游戏等级
    
    if(gameLevel  == GameLevel1){//如果当前分数只有 5分以下  则 只显示 一个 棋子   要么左边 要么右边
        if(cnt==0 ){//如果当前还有 超过3个在中上 没有显示 不创建
            [self createThing:gameLevel];//生成
        }
    }else if(gameLevel == GameLevel2){//如果当前分数只有 5-10分以下  左边，右边一起显示
        if(cnt==0){//如果当前还有 超过3个在中上 没有显示 不创建
            [self createThing:gameLevel];//生成
        }
        
    }else if(gameLevel == GameLevel3){
        if(cnt>=0 && cnt<=1){//如果当前还有 超过3个在中上 没有显示 不创建
            [self createThing:gameLevel];//生成
        }
    }
    
    
   
    CCSprite *bumpSprite =  [_thingCache chkNowIsBump:heroBump];
    if(bumpSprite != nil){//gameover
        CGPoint showEffectPoint = ccp(bumpSprite.position.x,bumpSprite.position.y- bumpSprite.contentSize.height/2);
        CCParticleSystem *particle = [SoxCCParticleExplosion objInit:8 :@"effect_star0.png" :showEffectPoint];
        [self addChild:particle z:12 ];
        [[GameLayer sharedGameLayer]gameOver];
    }else{
        
    }
}

/*
//检查生成是否为倍数 关系
- (int)chkspacingMulit:(int)base :(int)now{
    int spaci = abs(base-now);
    int mulitInt = 0;
    if(now - base<0){
        mulitInt =  -1;
    }else{
        mulitInt =  1;
    }
    int lastInt = 0;
    
    if(spaci>100 && spaci<120  ){
        lastInt =  mulitInt*1;
    }
    if(spaci>200 && spaci<220  ){
        lastInt =  mulitInt*2;
    }
    return lastInt;
}
*/
/*
- (void)createThing:(int)createdCnt{
    int createNum =   3;//G_THING_RANDOM_NUM -createdCnt;
    if(createNum>0){
        int first = 0;
        bool  isOneMulitLeft = false;//1倍 负数
        bool  isOneMulitRight = false;//1倍 负数
        bool isTwoMulitLeft = false;
        bool isTwoMulitRight = false;
        for (int i = 0; i<= createNum; i++) {
            // int thingObjType =arc4random()%3; // 需要产生的类型
            int  createX =arc4random()%310+10; // 生成的距离 在10～ 320 左右
            if(i == 0){
                if(createX > 320/2 - 10 && createX > 320/2 + 10){
                    createX =arc4random()%50+10;
                }
                first = createX;
                
            }else{
                createX =arc4random()%310+10;
                if(i >=1 ){
                    
                    int val =   [self chkspacingMulit:first :createX];
                    if(val != 0 ){
                        if(val == -1 ){
                            if(isOneMulitLeft == true ){
                                // createX = createX+50;
                            }else  if(isTwoMulitLeft == true ){
                                createX = createX-50;
                            }else  if(isOneMulitRight == true ){
                                createX = createX+50;
                            }
                            isOneMulitLeft = true;
                        }else if(val == 1  ){
                            if(isOneMulitRight == true ){
                                //  createX = createX+50;
                            }else  if(isTwoMulitRight == true ){
                                createX = createX+50;
                            }else  if(isOneMulitLeft == true ){
                                createX = createX-50;
                            }
                            isOneMulitRight = true;
                        }else if(val == 2  ){
                            if(isTwoMulitRight == true ){
                                //createX = createX+50;
                            }else  if(isOneMulitRight == true ){
                                createX = createX+50;
                            }
                            isTwoMulitRight = true;
                        }else if(val == -2  ){
                            if(isTwoMulitLeft == true ){
                                // createX = createX+50;
                            }else if(isOneMulitLeft == true ){
                                createX = createX-50;
                            }
                            isTwoMulitLeft = true;
                        }
                    }
                    
                }
            }
            float createSpeed =arc4random()%G_THING_SPEED_MIN+G_THING_SPEED_MAX;  
            [_thingCache showObjDrop:randomCreateType :randomColor :createSpeed :ccp(createX, G_SCREEN_SIZE.height-G_THING_SHOW_SUB_HEIGHT)];
        }
    }
}*/
@end
