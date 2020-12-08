//
//  SOXMapUtil.m
//  SoxFrame
//
//  Created by jason yang on 13-5-27.
//
//

#import "SOXMapUtil.h"
#import "CCTMXTiledMap.h" 
@implementation SOXMapUtil   

//获取 当前 精灵 实际图片rect（） 通过动态输出的 textureRect（也就是实际显示图片的 大小）
+ (CGRect)spriteToRect:(CCSprite*)sp
{
    CGRect rect = CGRectMake(sp.position.x - sp.textureRect.size.width/2, sp.position.y - sp.textureRect.size.height/2, sp.textureRect.size.width, sp.textureRect.size.height);  
  return rect;
}

//获取计算出 当前精灵在地图 的rect
+ (CGRect)spriteToRectByMap:(CCSprite*)sp :(CCTMXTiledMap*)tileMap
{
     CGPoint nowPoint = [SOXMapUtil getNowPointInMapLocation:sp.position tileMap:tileMap]; 
    CGRect rect = CGRectMake(nowPoint.x - sp.textureRect.size.width/2, nowPoint.y - sp.textureRect.size.height/2, sp.textureRect.size.width, sp.textureRect.size.height);   
    return rect;
}

//获取计算出 当前精灵在地图 的rect
+ (CGRect)spriteToRectByMap2:(CCSprite*)sp :(float)subX
{
    CGPoint nowPoint =CGPointMake(sp.position.x+subX, sp.position.y);//[SOXMapUtil getNowPointInMapLocation:sp.position tileMap:tileMap];
    CGRect rect = CGRectMake(nowPoint.x - sp.textureRect.size.width/2, nowPoint.y - sp.textureRect.size.height/2, sp.textureRect.size.width, sp.textureRect.size.height);
    return rect;
}


//检查人物是否 碰撞 地图
+ (Boolean)chkHeroIsTouchMapSp:(CCSprite*)hero :(CCSprite*)chkMapSp :(CCTMXTiledMap*)tileMap
{ 
    CGRect rect1 = [SOXMapUtil spriteToRectByMap:chkMapSp :tileMap];
    CGRect rect2 = [self spriteToRect:hero];
    bool bol = false;
    if (CGRectIntersectsRect(rect1, rect2)) {
        bol = true;
    } 
    return bol; 
}

//计算出 当前 人物 坐标   对应的 bg 瓦专对应的 地图坐标
+ (CGPoint)getPonitByMapTile:(CGPoint)nowPiont tileMap:(CCTMXTiledMap*)tileMap
{
	CGPoint pos = ccpSub(nowPiont, tileMap.position); 
	pos.x = (int)(pos.x / tileMap.tileSize.width);
    float tileMapHeightAll = tileMap.mapSize.height * tileMap.tileSize.height;
	pos.y = (int)((tileMapHeightAll - pos.y) / tileMap.tileSize.height); 
	return pos;
}
//根据当前 设置 得objLayer 的字典dict 信息 返回 实际页面的 点坐标
+ (CGPoint)getPointByObjLayerDict:(NSDictionary*)dict tileMap:(CCTMXTiledMap*)tileMap :(CGFloat)width :(CGFloat) height
{
    float x, y;
    //此处特殊处理  17 是实际地图显示的 时候偏差值
    x = [[dict valueForKey:@"x"] floatValue] + 17 ;//+ tileMap.position.x  ?? 
	y = [[dict valueForKey:@"y"] floatValue] + tileMap.position.y + height/2;
    return  CGPointMake(x,y);
}

//计算出 当前 人物 坐标   对应的 bg 瓦专对应的 地图坐标 
+ (CGPoint)getNowPointInMapLocation:(CGPoint)nowPiont tileMap:(CCTMXTiledMap*)tileMap;
{ 
	CGPoint pos = ccpAdd(tileMap.position , nowPiont);
	return pos;
}
//检查 当前节点 是否 在  地图范围内
+ (bool)chkPointInTMX :(CGPoint)pos :(CCTMXTiledMap*)  tileMap
{
    if (pos.x >= 0 && pos.y >= 0 && pos.x < tileMap.mapSize.width && pos.y < tileMap.mapSize.height) {
        return false;
    }
    return true;
}
//检查当前节点x,y 是否都小于0
+ (bool)chkPointIsLessZreo:(CGPoint)pos
{
    if( pos.x <=0 || pos.y <=0){
        return true;
    }
    return false;
}

//遍历地图tileLayer 所有信息
+ (CCArray*)mapIterator:(CCTMXTiledMap*)tileMap :(NSString *)objectLayerName
{
     CCArray *array=[CCArray arrayWithCapacity:10];
    CCTMXLayer *objectLayer = [tileMap layerNamed:objectLayerName];
    CGSize s = [objectLayer layerSize];
    for( int x=0; x<s.width;x++) { 
        for (int y=0; y<s.height; y++) {
            unsigned int tmpgid = [objectLayer tileGIDAt:ccp(x,y)];
            NSDictionary* properties = [tileMap propertiesForGID:tmpgid];
            if (properties)
            {
                NSString* ObjTypeId = [properties valueForKey:@"ObjTypeId"];
                [array addObject:ObjTypeId]; 
            }
        }
    }
    return true;
}

@end
