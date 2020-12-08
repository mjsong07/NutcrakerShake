//
//  ATAppInfoEntity.h
//  TestR
//
//  Created by haiqin.wang on 14-5-13.
//  Copyright (c) 2014年 haiqin.wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ATAppEntity : NSObject

@property (nonatomic, copy) NSString *appId;
@property (nonatomic, copy) NSString *appImgUrl;
@property (nonatomic, copy) NSString *appName;
@property (nonatomic, copy) NSString *downloadUrl;
@property (nonatomic) BOOL isShow;

@property (nonatomic) BOOL isDummy;
@property (nonatomic, copy) NSString *dummyImgUrl;
@property (nonatomic, copy) NSString *dummyName;

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
