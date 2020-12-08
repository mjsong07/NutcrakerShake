//
//  ShareManager.h
//  TestR
//
//  Created by haiqin.wang on 14-5-29.
//  Copyright (c) 2014年 haiqin.wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXApi.h"

@interface ShareManager : NSObject

// 初始化
+ (void)setWXApiKey:(NSString *)wxApiKey;

+ (void)showShareComponentWithText:(NSString *)text image:(UIImage *)image urlString:(NSString *)urlString;

@end
