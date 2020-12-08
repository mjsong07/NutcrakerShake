//
//  Config.h
//  SoxFrame
//
//  Created by jason yang on 13-5-23.
//
//

#import <Foundation/Foundation.h>

#define G_KEY_SOX_NUTCRACKER_URL @"https://itunes.apple.com/app/nutcracker-shake/id858934198?ls=1&mt=8"

#define G_KEY_SOX_WECHATE_URL @"http://mp.weixin.qq.com/s?__biz=MjM5ODQ3MjgxNA==&mid=200519797&idx=1&sn=5bd9503541a88d56feb432c128a61cb3#rd"

//本地存储加密 key  注意此处 已发布的游戏不能随便更改 否则原来的数据 反加密会出错。。
#define G_KEY_DB @"www.soxstudio.cn"

//广告 id
#define G_KEY_AD_ADMOB @"a15344b45e37fc8"

//应用互推的 appKey
#define G_KEY_AT_APPKEY_NUTCRACKER @"858934198"



/* 微信接口 信息*/
#define G_KEY_WECHAT_APPID @"wx5fb5e70d7b7ca68c"

#define G_KEY_WECHAT_APPSECRET @"f9a0820ee042aac7438ced79775814c4"



/* 当前是否debug模式*/
#define G_KEY_IS_DEBUG @"nowIsDebugFlag"
 
#define G_KEY_SOUND @"sound"

#define G_KEY_NOW_STAR_CNT @"nowStarCnt"
#define G_KEY_NOW_LIFE_CNT @"nowLifeCnt"


//当前已完的游戏次数
#define G_KEY_GAME_TIMES @"gameTimes" 


//是否点击过评价
#define G_KEY_IS_CLICK_RANK @"isClickRank"

 
#define G_KEY_ACHIEVEMENT_FLAG @"flag"   
#define G_KEY_ACHIEVEMENT_NOWVAL @"nowVal"
#define G_KEY_ACHIEVEMENT_WEB_FLAG @"webFlag" 
#define G_KEY_ACHIEVEMENT_WEB_NOWVAL @"webNowVal"

#define G_KEY_LEADERBOARD_SCORE @"com.sox.nutcrackershake.leaderboard.score"


#define G_KEY_PURCHASES_STAR_099 @"com.sox.nutcrackershake.purchases.star.099"
#define G_KEY_PURCHASES_STAR_199 @"com.sox.nutcrackershake.purchases.star.199"

@interface SOXKey : NSObject{

} 
@end
