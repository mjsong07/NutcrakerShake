//
//  ShareManager.m
//  TestR
//
//  Created by haiqin.wang on 14-5-29.
//  Copyright (c) 2014年 haiqin.wang. All rights reserved.
//

#import "ShareManager.h"

#import "CCDirector.h"

#import "WeixinSessionActivity.h"
#import "WeixinTimelineActivity.h"

//#define IS_IOS7         ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
//#define IS_UP_IOS6      ([[UIDevice currentDevice].systemVersion floatValue] >= 6.0)

#define kIsUpIos7_ShareManager      ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define kIsUpIos6_ShareManager      ([[UIDevice currentDevice].systemVersion floatValue] >= 6.0)

static ShareManager *shareManager_;

@interface ShareManager ()
{
    NSMutableArray *activityArray_;
    BOOL isAlreadySetWeixinActivity_;
}

@end

@implementation ShareManager

+ (void)setWXApiKey:(NSString *)wxApiKey
{
    if (wxApiKey != nil) {
        [WXApi registerApp:wxApiKey];
    }
}

+ (void)showShareComponentWithText:(NSString *)text image:(UIImage *)image urlString:(NSString *)urlString
{
    [[ShareManager sharedManager] showShareComponentWithText:text
                                                       image:image
                                                   urlString:urlString];
}

+ (ShareManager *)sharedManager
{
    if (shareManager_ == nil) {
        shareManager_ = [[ShareManager alloc] init];
    }
    return shareManager_;
}

- (void)dealloc
{
    [activityArray_ release];
    [super dealloc];
}

- (id)init
{
    self = [super init];
    if (self) {
        activityArray_ = [[NSMutableArray alloc] init];
        [self setWeixinActivity];
    }
    return self;
}

- (void)setWeixinActivity
{
    if (isAlreadySetWeixinActivity_ == YES) {
        return;
    }
    isAlreadySetWeixinActivity_ = YES;
    WeixinSessionActivity *weixinSessionActivity = [[WeixinSessionActivity alloc] init];
    WeixinTimelineActivity *weixinTimelineActivity = [[WeixinTimelineActivity alloc] init];
    
    [activityArray_ addObject:weixinSessionActivity];
    [activityArray_ addObject:weixinTimelineActivity];
    
    [weixinSessionActivity release];
    [weixinTimelineActivity release];
}

- (void)showShareComponentWithText:(NSString *)text image:(UIImage *)image urlString:(NSString *)urlString
{
    NSMutableArray *activityItemArray = [NSMutableArray arrayWithCapacity:3];
    if (text != nil) {
        [activityItemArray addObject:text];
    }
    if (image != nil) {
        [activityItemArray addObject:image];
    }
    if (urlString != nil) {
        [activityItemArray addObject:[NSURL URLWithString:urlString]];
    }
    
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:activityItemArray
                                                                                         applicationActivities:activityArray_];
    if (kIsUpIos7_ShareManager) {
        activityViewController.excludedActivityTypes = [NSArray arrayWithObjects:
                                              UIActivityTypePrint,
                                              UIActivityTypeCopyToPasteboard,
                                              UIActivityTypeAssignToContact,
                                              UIActivityTypeAddToReadingList,
                                              UIActivityTypeAirDrop, nil];
    } else {
        activityViewController.excludedActivityTypes = [NSArray arrayWithObjects:
                                                        UIActivityTypePrint,
                                                        UIActivityTypeCopyToPasteboard,
                                                        UIActivityTypeAssignToContact, nil];
    }
    [[CCDirector sharedDirector] presentViewController:activityViewController animated:YES completion:nil];
    [activityViewController release];
    
    /*
    NSArray *activityItem = [NSArray arrayWithObjects:
                             @"这里是标题2",
                             [UIImage imageNamed:@"Oauth"],
                             [NSURL URLWithString:@"https://itunes.apple.com/cn/app/attackonwitch/id867447021?mt=8"], nil];
    UIActivityViewController *activityView = [[UIActivityViewController alloc] initWithActivityItems:activityItem
                                                                               applicationActivities:activity];
    //    // 6.0
    //    activityView.excludedActivityTypes = @[UIActivityTypePrint, UIActivityTypeCopyToPasteboard, UIActivityTypeAssignToContact];
    // 7.0
    activityView.excludedActivityTypes = [NSArray arrayWithObjects:
                                          UIActivityTypePrint,
                                          UIActivityTypeCopyToPasteboard,
                                          UIActivityTypeAssignToContact,
                                          UIActivityTypeAddToReadingList,
                                          UIActivityTypeAirDrop, nil];
    [self presentViewController:activityView animated:YES completion:nil];
     */
}

@end
