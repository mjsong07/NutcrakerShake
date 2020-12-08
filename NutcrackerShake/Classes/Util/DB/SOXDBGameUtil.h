//
//  SOXMapUtil.h
//  SoxFrame
//
//  Created by jason yang on 13-5-27.
//
//

#import <Foundation/Foundation.h> 

@interface SOXDBGameUtil : NSObject
 //获取当前星星
+ (double)loadNowStar;
 //获取当前最大生命
+ (int)loadNowLife;
+ (double)loadBestScore;
 
+ (bool)loadIsDebug;

@end
