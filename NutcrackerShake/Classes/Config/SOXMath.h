//
//  Config.h
//  SoxFrame
//
//  Created by jason yang on 13-5-23.
//
//

#import <Foundation/Foundation.h>

//convenience measurements
//屏幕 大小
#define G_SCREEN_SIZE [[CCDirector sharedDirector] winSize]
//屏幕 居中坐标
#define G_SCREEN_CENTER ccp(G_SCREEN_SIZE.width/2, G_SCREEN_SIZE.height/2)
//随机 时间
#define G_CURTIME CACurrentMediaTime()

#define F_RANDOM_RANGE(low,high) (arc4random()%(high-low+1))+low
#define F_FRANDOM (float)arc4random()/UINT64_C(0x100000000)
#define F_FRANDOM_RANGE(low,high) ((high-low)*frandom)+low

@interface SOXMath : NSObject{

} 
@end
