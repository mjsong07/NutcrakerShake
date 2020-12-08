//
//  AppTransferManager.h
//  TestR
//
//  Created by haiqin.wang on 14-5-12.
//  Copyright (c) 2014年 haiqin.wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ATAppEntity.h"

#import "CCSprite.h"

typedef void(^ShowAppTransferFailure)(void);

@interface ATAppTransferManager : NSObject

// 初始化
+ (void)setAppId:(NSString *)appId;
+ (void)setBackColor:(UIColor *)backColor;          // 设置广告栏背景色, 不设置为默认白色
+ (void)setAppBorderColor:(UIColor *)borderColor;   // 设置应用边框颜色, 不设置为默认黑色
+ (void)setAppChangeInterval:(NSInteger)interval;   // 设置应用切换时间, 不设置为默认30秒
//

+ (ATAppEntity *)appWithAppId:(NSString *)appId;
+ (CCSprite *)spriteWithAppId:(NSString *)appId;
+ (BOOL)isTransferViewShow;
+ (BOOL)isDataLoadSuccess;

// cocoa 坐标轴, 左上角的点的位置
+ (void)showTransferViewWithPosition:(CGPoint)pos failure:(ShowAppTransferFailure)failure;
+ (void)hideTransferView;
+ (void)setTransferViewFrame:(CGRect)frame;

@end
