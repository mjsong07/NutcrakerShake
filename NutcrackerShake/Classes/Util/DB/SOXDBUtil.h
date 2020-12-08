//
//  SOXMapUtil.h
//  SoxFrame
//
//  Created by jason yang on 13-5-27.
//
//

#import <Foundation/Foundation.h> 

@interface SOXDBUtil : NSObject

+ (void)saveInfo:(NSString *)key :(NSString *) value;
+ (NSString *)loadInfo:(NSString *)key;

+ (void)initInfoByMenuItem:(CCMenuItemToggle *)menuItem :(NSString *)key;

+ (BOOL)loadInfoReturnBool:(NSString *)key;
+ (void)updateInfoByBool:(NSString *)key :(BOOL) value;

+ (int)loadInfoReturnInt:(NSString *)key;
+ (double)loadInfoReturnDouble:(NSString *)key;

+ (BOOL)updateInfoByInt:(NSString *)key :(int) value;
+ (BOOL)updateInfoByFloat:(NSString *)key :(float) value;
+ (BOOL)updateInfoByDouble:(NSString *)key :(double) value;

+ (BOOL)chkIsNeedUpdateByInt:(NSString *)key :(int) value;
+ (BOOL)chkIsNeedUpdateByFloat:(NSString *)key :(float) value;
+ (BOOL)chkIsNeedUpdateByDouble:(NSString *)key :(double) value;
@end
