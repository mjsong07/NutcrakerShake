//
//  SOXMapUtil.h
//  SoxFrame
//
//  Created by jason yang on 13-5-27.
//
//

#import <Foundation/Foundation.h> 

@interface SOXUtil : NSObject

+ (NSString*)floatToString:(float)f;
+ (NSString*)doubleToString:(double)d;
+ (NSString*) intToString:(int)i;

+ (int)floatToInt:(float)f; 
+ (int)intToFloat:(int)i; 
+ (int)intToDouble:(int)i;


+ (NSString *)getFormatTimeStr:(int)time;
+ (NSString *)getFormatAllTimeStr:(float)time;
+ (NSString *)getFormatAllDistanceStr:(float)time;
+ (NSString*)isNull:(NSString *)str;
+ (NSString*)isNotNull:(NSString *)str;
+ (int)getRandomByDict  :(NSMutableDictionary*)dict;
+ (NSString*)createRandomCharList :(NSString*)strChar :(int)createCnt;

+ (NSString *)notRounding:(double)price afterPoint:(int)position;


+ (float)getRandomMinus1_1;
+ (float)getRandom0_1;

+(void)showAlert:(NSString *)title :(NSString *)message ;
@end
