//
//  MenuLayer.h
//  SoxFrame
//
//  Created by jason yang on 14-02-26
//  已废弃
//
#import "MBProgressHUD.h"
#import "Reachability.h"
@interface MenuShareInfo : BaseSprite{ 
    NSString *showScore_;
}
- (id)init;
- (void)setTouchEnabled:(bool)bol;

@property (retain) MBProgressHUD *hud; 
@property(nonatomic,retain)Reachability *reach;//基本动画
@property NetworkStatus netStatus;//基本动画


@property(nonatomic,retain)NSString *nowSelected;//基本动画

- (void)showHuDByStr:(NSString*)title :(NSString*)message :(double)delay ;
@end
