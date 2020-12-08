//
//  Thing.h
//  SoxFrame
//
//  Created by jason yang on 14-02-26
//
//

#import "BaseSprite.h"
#import "HeroBump.h"
@interface Thing : BaseSprite{
    
}

@property(nonatomic,assign)ThingObjType objType;

@property float  nowSpeed;//是否正在移动

+ (id)objInit:(ThingObjType)objType;
- (id)initWithImage:(ThingObjType)objType;
- (void)rebound:(HeroBump*)heroBump;
- (void)drop; 
- (void)rise;
 @end
