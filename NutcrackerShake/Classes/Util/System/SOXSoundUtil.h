//
//  SOXMapUtil.h
//  SoxFrame
//
//  Created by jason yang on 13-5-27.
//
//

#import <Foundation/Foundation.h> 

@interface SOXSoundUtil : NSObject
//初始化所有音频
+ (void)initSoundMusic;
+ (void)pause_BackgroundMusic;
+ (void)playEffect:(NSString *)fileName;
+ (void)playBg:(NSString *)fileName;
//静音
+ (void)close_sound;
//还原 声音
+ (void)open_sound;

+ (void)play_GameBackgroundMusic;
+ (void)play_star;
+ (void)play_click;
+ (void)play_btn;
//失败
+ (void)play_fall;
//弹出游戏分数
+ (void)play_score;
//死亡
+ (void)play_hurt;
//
+ (void)play_revival;


+ (void)play_zoom;
+ (void)play_popUp; 
+ (void)play_beginFall;

+ (void)play_pullDown;

@end
