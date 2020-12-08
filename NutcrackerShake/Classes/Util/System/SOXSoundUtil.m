//
//  SOXMapUtil.m
//  SoxFrame
//
//  Created by jason yang on 13-5-27.
//
//

#import "SOXSoundUtil.h"  
#import "SimpleAudioEngine.h"
@implementation SOXSoundUtil  

//预加载 所有音频
+ (void)initSoundMusic
{
    /*
    //游戏中音乐
    [[SimpleAudioEngine sharedEngine] preloadBackgroundMusic:@"bg.wav"];
     //菜单音乐
     
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"btn.mp3"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"dead.mp3"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"hurt.mp3"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"revival.mp3"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"score.wav"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"hurt.wav"]; 
     */
}

//按钮声
+ (void)playEffect:(NSString *)fileName
{
    //[SOXDebug logInt:[[SOXConfig sharedConfig] isOpenSound]];
    if( [[SOXConfig sharedConfig] isOpenSound] ){
        [[SimpleAudioEngine sharedEngine] playEffect:fileName];
    }
}
+ (void)playBg:(NSString *)fileName
{
     [[SimpleAudioEngine sharedEngine]   setBackgroundMusicVolume:0.1];
    if( [[SOXConfig sharedConfig] isOpenSound] ){
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:fileName loop:true];
       
    }
}
//设置静音
+ (void)close_sound
{ 
    [[SimpleAudioEngine sharedEngine] setMute:YES];
}

//还原 声音
+ (void)open_sound
{
    [[SimpleAudioEngine sharedEngine] setMute:NO];
}

+ (void)play_GameBackgroundMusic
{
    [SOXSoundUtil playBg:@"bg.mp3"];
}

+ (void)pause_BackgroundMusic
{
    [[SimpleAudioEngine sharedEngine] pauseBackgroundMusic];
}


//按钮声
+ (void)play_pullDown
{
    [SOXSoundUtil playEffect:@"pull_down.wav"];
}

//按钮声
+ (void)play_zoom
{
    [SOXSoundUtil playEffect:@"zoom.caf"];
}

//按钮声
+ (void)play_popUp
{
    [SOXSoundUtil playEffect:@"pop_up.wav"];
}

//按钮声
+ (void)play_beginFall
{
    [SOXSoundUtil playEffect:@"begin_fall.wav"];
}


//按钮声
+ (void)play_btn
{
    [SOXSoundUtil playEffect:@"click.mp3"];
}


//按钮声
+ (void)play_click
{
    [SOXSoundUtil playEffect:@"click.mp3"];
}


//倒下
+ (void)play_fall
{
    [SOXSoundUtil playEffect:@"fall.mp3"];
}
//弹出游戏分数
+ (void)play_score
{
    [SOXSoundUtil playEffect:@"score.wav"];
} 

+ (void)play_star
{
    [SOXSoundUtil playEffect:@"star.mp3"];
}


+ (void)play_hurt
{
    [SOXSoundUtil playEffect:@"hurt.mp3"];
}
//重生
+ (void)play_revival
{
    [SOXSoundUtil playEffect:@"revival.mp3"];
}

@end
