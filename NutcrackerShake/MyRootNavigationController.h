//
//  AppDelegate.h
//  SoxFrame
//
//  Created by jason yang on 14-02-26.
//  Copyright jason yang 2013年. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GADBannerViewDelegate.h"
#import "GADBannerView.h"
// Added only for iOS 6 support
@interface MyRootNavigationController : UINavigationController <CCDirectorDelegate,GADBannerViewDelegate>{
    
    GADBannerView  *bannerView_;
}

//移除 删除广告 客户端接收到广告后调用
- (void)removeGAD;
//隐藏 
- (void)hiddenGAD;
//显示 
- (void)showGAD;
//初始化 新增广告
- (void)initGAD; 
@end