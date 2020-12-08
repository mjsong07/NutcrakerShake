//
//  Debug.h
//  SoxFrame
//
//  Created by jason yang on 13-5-28.
//
//

#import <Foundation/Foundation.h>
@interface SOXDebug : NSObject


+ (void)logStr:(NSString* )str;
+ (void)logTagStr:(NSString* )tag :(NSString* )str;
+ (void)logImgHW:(id)sprite; 

+ (void)logTagInt:(NSString* )tag :(int)i;
+ (void)logTagFloat:(NSString* )tag :(float)f;

+ (void)logHW:(id)sprite; 
+ (void)logFloat:(float)f;
+ (void)logInt:(int)i;
+ (void)logBol:(bool)bol;
+ (void)logPonit:(CGPoint)point;
+ (void)logAnchorPoint:(id)sprite;

+ (void)testLongLoadingTime;
+ (void)drawRectFaster:(CGRect)rect;
@end
