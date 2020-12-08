//
//  SOXMapUtil.h
//  SoxFrame
//
//  Created by jason yang on 13-5-27.
//
//

#import <Foundation/Foundation.h> 
 
#import "AppDelegate.h"
#import "ThingCache.h"
@interface SOXGameUtil : NSObject{
}
//游戏页面截图
+(UIImage*) makeaShot;
//获取当前代理
+(AppDelegate*)getAppDelegate ;
//获取当前 根页面对象
+(MyRootNavigationController*)getBaseRootView;

+(void) toChkNowIsPlayingToPause;


@end
