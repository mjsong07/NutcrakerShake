//
//  NSString+ATAdditions.h
//  TestR
//
//  Created by haiqin.wang on 14-6-4.
//  Copyright (c) 2014年 haiqin.wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (ATAdditions)

+ (NSString *)uniqueKey;
- (NSString *)stringURIEncoding;
- (NSString *)MD5String;

@end
