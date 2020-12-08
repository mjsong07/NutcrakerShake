//
//  SOXMapUtil.h
//  SoxFrame
//
//  Created by jason yang on 13-5-27.
//
//

#import <Foundation/Foundation.h> 

@interface SOXBumpUtil : NSObject

+ (BOOL)chkIsBumpCircle:(CCSprite*)rect :(CCSprite*)circle;

+ (BOOL)chkIsBumpByRect:(CCSprite*)rect :(CCSprite*)circle;
+ (bool)test:(int)m_radius :(CCSprite*)m_center  :(CCSprite*)rect   ;

+ (float)getBumpDistance:(CCSprite*)rect :(CCSprite*)circle;

+ (float)getBumpDistance2:(CCSprite*)rect :(CCSprite*)circle;
+ (CGRect)spriteToRect:(CCSprite*)sp;
@end
