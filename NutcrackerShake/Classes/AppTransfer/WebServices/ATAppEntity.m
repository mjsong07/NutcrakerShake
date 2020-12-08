//
//  ATAppInfoEntity.m
//  TestR
//
//  Created by haiqin.wang on 14-5-13.
//  Copyright (c) 2014年 haiqin.wang. All rights reserved.
//

#import "ATAppEntity.h"

@implementation ATAppEntity

- (void)dealloc
{
    [_appId release];
    [_appImgUrl release];
    [_appName release];
    [_downloadUrl release];
    
    [_dummyImgUrl release];
    [_dummyName release];
    [super dealloc];
}

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.appId = [[dictionary objectForKey:@"appKey"] description];
        self.appImgUrl = [dictionary objectForKey:@"appImgUrl"];
        self.appName = [dictionary objectForKey:@"appName"];
        self.downloadUrl = [dictionary objectForKey:@"downloadUrl"];
        self.isShow = [[dictionary objectForKey:@"isShow"] description].integerValue;
        
        self.isDummy = [[dictionary objectForKey:@"isDummy"] description].integerValue;
        if (self.isDummy == YES) {
            self.dummyImgUrl = [dictionary objectForKey:@"dummyImgUrl"];
            self.dummyName = [dictionary objectForKey:@"dummyName"];
        }
    }
    return self;
}

@end
