//
//  ThingCache.m
//  SoxFrame
//  工厂方法  统一生成物品  提高性能
//
//  Created by jason yang on 13-6-3.
//
//

#import "ThingCache.h"   
#import "GameLayer.h"
#import "Hero.h"
#import "SOXBumpUtil.h"
@implementation ThingCache
+ (id)objInit
{
    ThingCache *sprite = [[self alloc] init];
    [sprite initAllThing];
	return [sprite autorelease];
} 

- (id)init
{
	if ((self = [super init]))
	{ 
		CCSpriteFrame* bulletFrame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"star.png"];//此图片 必须是 zwd里面的 图片名子
		ccBatchNode_ = [CCSpriteBatchNode batchNodeWithTexture:bulletFrame.texture];
		[self addChild:ccBatchNode_ z:10];
	}
     	
	return self;
}
 
- (void)initAllThing
{
    int totalNum = ThingObjMax * G_THING_CACHE_NUM;
    self.things = [[[CCArray alloc] initWithCapacity:totalNum]autorelease];
    for (int i = 0; i < ThingObjMax; i++)
	{
        [self createBatchForObjType:_things  :G_THING_CACHE_NUM :i];
	}
}
-(void) dealloc{
    [_things release];
    [super dealloc];
}
//
- (void)createBatchForObjType:(CCArray*)array :(int)createNum  :(ThingObjType)objType
{ 
    for (int j = 0; j < createNum; j++)
    {
        BaseSprite *baseSprite = nil;
        //由于 文字box 的 特殊需要动态显示文字 不能使用统一的缓存ccBatchNode  需要单独直接创建
        baseSprite = [Thing objInit :objType];
        [ccBatchNode_ addChild:baseSprite z:0 tag:objType];
        [baseSprite setVisible:false];
        [array addObject:baseSprite];
    }
}

 
//注意  当前只处理 x轴 的ipad兼容  y轴 不处理
- (BaseSprite*)showObjDrop:(ThingObjType)objType :(ccColor3B)color :(float)speed :(CGPoint)startPosition
{
	Thing* thing = nil;
	CCARRAY_FOREACH(_things, thing)
	{
        if( thing.objType == objType){
            if (thing.visible == NO)
            {
                thing.color =color;
                [thing setVisible: true];
                 [thing setPosition:ccp(getRS_W(startPosition.x),  startPosition.y)];
                [thing setNowSpeed:speed];
                [thing drop];
                break;
            }
        } 
	}
    return thing;
}



//注意  当前只处理 x轴 的ipad兼容  y轴 不处理
- (BaseSprite*)showObjRise:(ThingObjType)objType :(ccColor3B)color :(float)speed :(CGPoint)startPosition
{
	Thing* thing = nil;
	CCARRAY_FOREACH(_things, thing)
	{
        if( thing.objType == objType){
            if (thing.visible == NO)
            {
                [thing setVisible: true];
                thing.color =color;
                [thing setPosition:ccp(getRS_W(startPosition.x), startPosition.y)];
                [thing setNowSpeed:speed];
//                [thing startToMove];
                [thing rise];
                break;
            }
        }
	}
    return thing;
}


- (int)getNowShowIngThing
{
    Thing* thing = nil;
    int cnt = 0;
	CCARRAY_FOREACH(_things, thing)
	{
            if (thing.visible == YES)
            {
                if(thing.position.y > G_SCREEN_CENTER.y){
                    cnt++;
                }
               
            }
	}
    return  cnt;
}

//检查当前是否碰撞
- (CCSprite*)chkNowIsBump:(HeroBump *)heroBump
{
	BOOL  flag = false;
    Thing* thing = nil;
    CCSprite *bumpObj = nil;
    //如果当前只有3个 则可以重新生成
	CCARRAY_FOREACH(_things, thing)
	{
        if (thing.visible == YES  )//&& thing.objType == ThingObjChess0
        {
            flag =  [SOXBumpUtil chkIsBumpCircle:thing :heroBump];
            if(flag==true){
                bumpObj = thing ;
               float dis =  [SOXBumpUtil getBumpDistance2:thing :heroBump];
                 //此处 特殊处理  重新调整  物品的 高度 为
                if(dis>0){
                    [thing setPosition:ccp(thing.position.x, thing.position.y+dis)];
                }
                [thing rebound:heroBump];
                break;
            }
        }
	}
    return bumpObj;
}
 

//隐藏 所有
- (void)resetAll
{
    for (int j = 0; j < _things.count; j++)
    {
        BaseSprite *obj=  (BaseSprite*)[_things objectAtIndex:j];
        obj.isTouch = false;
        obj.isMoveing = false;
        obj.visible = false;
        obj.position = ccp(0, G_SCREEN_SIZE.height);
        [obj stopAllActions];
    }
}
 @end

