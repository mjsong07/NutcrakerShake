//
//  ATRequest.h
//  TestR
//
//  Created by haiqin.wang on 14-6-3.
//  Copyright (c) 2014年 haiqin.wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ATRequest : NSObject

+ (void)startGetRequestWithPath:(NSString *)path
                   parameterDic:(NSDictionary *)parDic
                        success:(void(^)(id response))success
                        failure:(void(^)(NSError *error))failure;

+ (void)startPostRequestWithPath:(NSString *)path
                    parameterDic:(NSDictionary *)parDic
                         success:(void(^)(id response))success
                         failure:(void(^)(NSError *error))failure;

+ (void)startImageRequestWithPath:(NSString *)path
                          success:(void(^)(NSData *imageData))success
                          failure:(void(^)(NSError *error))failure;
+ (NSData *)startSyncImageRequestWithPath:(NSString *)path;

@end
