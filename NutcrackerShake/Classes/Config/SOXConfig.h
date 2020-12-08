//
//  Config.h
//  SoxFrame
//
//  Created by jason yang on 13-5-23.
//
//

#import <Foundation/Foundation.h>
#import "SOXUtil.h"
#import "SOXEnum.h"
@interface SOXConfig : NSObject{

}
@property(nonatomic,assign)int nowMapRunTimes;//当前 已经循环了多少次关卡
@property(nonatomic,assign)int nowGameLevel;//当前游戏等级
@property(nonatomic,assign)int nowOpeningType;//1 菜单  2 游戏画面
@property(nonatomic)BOOL isOpenMusic;//背景声音 0 为 开 1 为关
@property(nonatomic)BOOL isOpenSound;//按钮声音 


@property(nonatomic,assign)DeviceType nowDeviceType;//当前移动方向


+(SOXConfig*) sharedConfig ;
- (void)setIsOpenMusicStr:(NSString *)index;
- (void)setIsOpenSoundStr:(NSString *)index;

- (void)initAll;
- (void)resetAll;
 
@end
