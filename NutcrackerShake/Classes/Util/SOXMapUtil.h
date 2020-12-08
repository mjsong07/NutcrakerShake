//
//  SOXMapUtil.h
//  SoxFrame
//
//  Created by jason yang on 13-5-27.
//
//

#import <Foundation/Foundation.h>
#import "CCSprite.h"
#import "CCTMXTiledMap.h"

@interface SOXMapUtil : NSObject
 
//判断2个 精灵是否 碰击 
+ (bool)chkPointInTMX :(CGPoint)pos :(CCTMXTiledMap*)tileMap;
+ (CGRect)spriteToRect:(CCSprite*)sp;
+ (Boolean)chkHeroIsTouchMapSp:(CCSprite*)hero :(CCSprite*)chkMapSp :(CCTMXTiledMap*)tileMap;
+ (CGRect)spriteToRectByMap:(CCSprite*)sp :(CCTMXTiledMap*)tileMap;
+ (CGPoint)getNowPointInMapLocation:(CGPoint)nowPiont tileMap:(CCTMXTiledMap*)tileMap;
+ (CGPoint)getPonitByMapTile:(CGPoint)heroPiont tileMap:(CCTMXTiledMap*)tileMap;
+ (CGPoint)getPointByObjLayerDict:(NSDictionary*)dict tileMap:(CCTMXTiledMap*)tileMap :(CGFloat)width :(CGFloat) height
;
+ (bool)chkPointIsLessZreo:(CGPoint)pos;
+ (CCArray*)mapIterator:(CCTMXTiledMap*)tileMap :(NSString *)objectLayerName; 
@end
