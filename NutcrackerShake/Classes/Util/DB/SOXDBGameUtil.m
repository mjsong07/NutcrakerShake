//
//  SOXMapUtil.m
//  SoxFrame
//
//  Created by jason yang on 13-5-27.
//
//

#import "SOXDBGameUtil.h"  
#import "SOXDBUtil.h"
#import "SOXUtil.h"
@implementation SOXDBGameUtil   
+ (double)loadNowStar{
    double nowStar=[SOXDBUtil loadInfoReturnDouble:G_KEY_NOW_STAR_CNT];
    return nowStar;
}
+ (int)loadNowLife{
    int nowLife=[SOXDBUtil loadInfoReturnInt:G_KEY_NOW_LIFE_CNT];
    //如果没有查到 生命记录 取系统默认的 2个
    if(nowLife <= 0){
        nowLife = G_LIFE_CNT_DEF;
        [SOXDBUtil saveInfo:G_KEY_NOW_LIFE_CNT :[SOXUtil intToString:nowLife]];//同时记录一下
    }
    return nowLife;
}
 + (double)loadBestScore{
    double score=[SOXDBUtil loadInfoReturnDouble:G_KEY_LEADERBOARD_SCORE];
    return score;
}
//检测当前是不是debug模式
+ (bool)loadIsDebug{
    bool isDebug = false;
    if(G_DEBUG_ENABLE == 1){
        isDebug = [SOXDBUtil loadInfoReturnBool:G_KEY_IS_DEBUG ];
    }
    return isDebug;
}


@end
