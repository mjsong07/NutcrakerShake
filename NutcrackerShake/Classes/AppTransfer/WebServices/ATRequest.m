//
//  ATRequest.m
//  TestR
//
//  Created by haiqin.wang on 14-6-3.
//  Copyright (c) 2014年 haiqin.wang. All rights reserved.
//

#import "ATRequest.h"
#import "ATReachability.h"
#import "ATConfig.h"

typedef enum {
	HttpMethodGet = 0,
	HttpMethodPost,
} HttpMethod;

@implementation ATRequest

+ (void)startGetRequestWithPath:(NSString *)path
                   parameterDic:(NSDictionary *)parDic
                        success:(void(^)(id response))success
                        failure:(void(^)(NSError *error))failure
{
    [self startRequstWithPath:path
                 parameterDic:parDic
                   httpMethod:HttpMethodGet
                      success:success
                      failure:failure];
}

+ (void)startPostRequestWithPath:(NSString *)path
                   parameterDic:(NSDictionary *)parDic
                         success:(void(^)(id response))success
                         failure:(void(^)(NSError *error))failure
{
    [self startRequstWithPath:path
                 parameterDic:parDic
                   httpMethod:HttpMethodPost
                      success:success
                      failure:failure];
}

+ (void)startImageRequestWithPath:(NSString *)path
                          success:(void(^)(NSData *imageData))success
                          failure:(void(^)(NSError *error))failure
{
    [[ATReachability sharedReachability] setHostName:@"http://www.apple.com"];
	if ([[ATReachability sharedReachability] internetConnectionStatus] == NotReachable) {
        if (failure) {
            failure(nil);
        }
    } else {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            LOG(@"image url :%@", path);
            NSURLResponse *response = nil;
            NSError *error = nil;
            NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:path]];
            [request addValue:@"image/*" forHTTPHeaderField:@"Accept"];
            
            NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
            NSInteger httpCode = [(NSHTTPURLResponse *)response statusCode];
            LOG(@"response code: %d", httpCode);
            if (error == nil) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (success) {
                        success(responseData);
                    }
                });
            } else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    LOG(@"error:%@", error);                    
                    if (failure) {
                        failure(error);
                    }
                });
            }
        });
    }
}

+ (NSData *)startSyncImageRequestWithPath:(NSString *)path
{
    [[ATReachability sharedReachability] setHostName:@"http://www.apple.com"];
	if ([[ATReachability sharedReachability] internetConnectionStatus] == NotReachable) {
        return nil;
    } else {
        LOG(@"image url :%@", path);
        NSURLResponse *response = nil;
        NSError *error = nil;
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:path]];
        [request addValue:@"image/*" forHTTPHeaderField:@"Accept"];
        
        NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        NSInteger httpCode = [(NSHTTPURLResponse *)response statusCode];
        LOG(@"response code: %d", httpCode);
        if (error == nil) {
            return responseData;
        } else {
            return nil;
        }
    }
}

// contentType 未加
+ (void)startRequstWithPath:(NSString *)path
               parameterDic:(NSDictionary *)parDic
                 httpMethod:(HttpMethod)httpMethod
                    success:(void(^)(id response))success
                    failure:(void(^)(NSError *error))failure
{
    [[ATReachability sharedReachability] setHostName:@"http://www.apple.com"];
	if ([[ATReachability sharedReachability] internetConnectionStatus] == NotReachable) {
        if (failure) {
            failure(nil);
        }
    } else {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSURLResponse *response = nil;
            NSError *error = nil;
            NSURLRequest *request = [self makeHttpRequestParamDic:parDic path:path httpMethod:httpMethod];
            NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
            NSInteger httpCode = [(NSHTTPURLResponse *)response statusCode];
            LOG(@"response code: %d", httpCode);
            LOG(@"receive data:%@", [[[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding] autorelease]);
            if (error == nil) {
                id jsonObject = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:&error];
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (jsonObject == nil || error != nil) {
                        LOG(@"An error happened while deserializing the JSON data.");
                        if (failure) {
                            failure(error);
                        }
                    } else {
                        if ([jsonObject isKindOfClass:[NSDictionary class]] || [jsonObject isKindOfClass:[NSArray class]]) {
                            LOG(@"receive (%@):%@", NSStringFromClass([jsonObject class]), jsonObject);
                            if (success) {
                                success(jsonObject);
                            }
                        } else {
                            LOG(@"An error happened while deserializing the JSON data.");
                            if (failure) {
                                failure(error);
                            }
                        }
                    }
                });
            } else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    LOG(@"error:%@", error);
                    if (failure) {
                        failure(error);
                    }
                });
            }
        });
    }
}

+ (NSURLRequest *)makeHttpRequestParamDic:(NSDictionary *)parDic path:(NSString *)path httpMethod:(HttpMethod)httpMethod
{
    NSString *parStrng = nil;
    if (parDic.count > 0) {
        NSMutableArray *parArray = [NSMutableArray arrayWithCapacity:parDic.count];
        [parDic enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            NSString *oneParString = [NSString stringWithFormat:@"%@=%@", key, obj];
            [parArray addObject:oneParString];
        }];
        
        parStrng = [parArray componentsJoinedByString:@"&"];
    }
    
	NSMutableURLRequest *newRequest = nil;
    
	if (httpMethod == HttpMethodGet) {
        NSString *requestURLString = nil;
        if (parStrng == nil) {
            requestURLString = [NSString stringWithFormat:@"%@", path];
        } else {
            requestURLString = [NSString stringWithFormat:@"%@?%@", path, parStrng];
        }
        LOG(@"address:%@", requestURLString);
        
		newRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:requestURLString]];
		[newRequest setHTTPMethod:@"GET"];
	} else if (httpMethod == HttpMethodPost) {
        LOG(@"address:%@",[NSString stringWithFormat:@"%@?%@", path, parStrng]);
		newRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:path]];
        [newRequest setHTTPMethod:@"POST"];
        [newRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
		
		NSData *bodyData = [parStrng dataUsingEncoding:NSUTF8StringEncoding];
        LOG(@"body data: %@", [[[NSString alloc] initWithData:bodyData encoding:NSUTF8StringEncoding] autorelease]);
        
		NSString *contentLength = [NSString stringWithFormat:@"%d", [bodyData length]];
		[newRequest setValue:contentLength forHTTPHeaderField:@"Content-Length"];
		[newRequest setHTTPBody:bodyData];
	}
    
    /*
     NSString *bundleID = [[NSBundle mainBundle] bundleIdentifier];
     NSString *model = ([UIScreen mainScreen].scale == 2.0) ? @"iphone" : @"iphone3gs";
     NSString *version = [[[NSBundle mainBundle] infoDictionary]
     objectForKey:(NSString*)kCFBundleVersionKey];
     NSString *macAddress = [NSString uniqueKey];
     
     [newRequest setValue:model forHTTPHeaderField:@"x-client-model"];
     [newRequest setValue:version forHTTPHeaderField:@"x-client-version"];
     [newRequest setValue:bundleID forHTTPHeaderField:@"x-client-bundleid"];
     [newRequest setValue:macAddress forHTTPHeaderField:@"x-client-deviceid"];
     //    [newRequest setValue:[[NSLocale preferredLanguages] objectAtIndex:0]
     //      forHTTPHeaderField:@"x-client-language"];
     */
    
	[newRequest setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
	
    //    loadingTimeoutTimer_ = [NSTimer scheduledTimerWithTimeInterval:DEFAULT_REQUEST_TIMEOUT target:self selector:@selector(handleTimer) userInfo:nil repeats:NO];
    
	return newRequest;
}

@end
