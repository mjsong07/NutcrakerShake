//
//  Constant.h
//  SoxFrame
//
//  Created by jason yang on 14-02-26
//
//

#import <Foundation/Foundation.h> 
#define G_DEBUG_ENABLE 1 //当前是否debug状态 默认0 打开1


#define G_AD_HEIGHT 70  //广告高度


#define G_THING_CACHE_NUM 10 //单个类型  生成的缓冲数量 8


#define G_THING_RANDOM_NUM 10 //每次随机生成的最大数量

#define G_THING_SPEED_MAX 200 //每次随机生成的最大速度   100 ~ 350 之间
#define G_THING_SPEED_MIN 150 //最小速度



#define G_THING_SHOW_SUB_HEIGHT 20 //显示高度相减


#define G_SPEED_DEF 5  //地图移动速度
#define G_LIFE_CNT_DEF 1 //默认 生命数 1
#define G_LIFE_CNT_MAX 8 //最大 生命数 8
#define G_THING_CNT_DEF 1 //默认  物体数量
//处理屏幕差异化
#define G_LIFE_SHOW_IMG_CNT_3_5 4 //当 数量为 4 显示心
#define G_LIFE_SHOW_IMG_CNT_4_0 6 //当 数量为 6 显示心

#define G_ALERT_DELAY_TIMES 2  //alert显示时间

#define G_STR_NULL @""

#define G_STR_YES @"1"
#define G_STR_NO @"0"

#define G_INT_YES 1
#define G_INT_NO 0
 

//判断是否为 iphone
#define G_IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
//判断是否为 ipad
#define G_IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

//判断是否为iPhone4    640x960
#define G_IS_IPHONE_4  [[UIScreen mainScreen] bounds].size.height <= 480.0f

//判断是否为iPhone5  640x1136
#define G_IS_IPHONE_5  [[UIScreen mainScreen] bounds].size.height >= 568.0f

#define G_MOVE_DEF 1.2  //默认速度1.2
#define G_MOVE_FAST 2.0  //默认速度1.2

#define G_MOVE_ANGLE_MAX 70  //最大移动角度


//根据游戏多少次数  显示评价弹出框
#define G_RANK_SHOW_1 10
#define G_RANK_SHOW_2 30
#define G_RANK_SHOW_3 200



//根据游戏多少次数  显示评价弹出框
#define G_Level_1_CNT 1
#define G_Level_2_CNT 8

#define G_START_TO_HARD_CNT 40



//! Gray Color (166,166,166)
static const ccColor3B ccSOX_BLUE = {0 ,102,255};

static const ccColor3B ccSOX_BLUE2 = {1 ,35,109};
static const ccColor3B ccSOX_BLUE_SEL = {0,80,202};

static const ccColor3B ccSOX_PINK = {255, 0 ,255};
static const ccColor3B ccSOX_PINK_SEL = {255,0,204};

static const ccColor3B ccSOX_GRAY = {102,102,102};

static const ccColor3B ccSOX_GRAY2 = {192,192,192};//{142,142,142};//{192,192,192};


static const ccColor3B ccSOX_GRAY3 = {78,39,39};


static const ccColor3B ccSOX_BROWN = {128,64,64};

static const ccColor3B ccSOX_BLACK = {94,104,110};

static const ccColor3B ccSOX_PURPLE = {153,0,153};

static const ccColor3B ccSOX_GREEN ={0 ,128,0};// {102,166,114};//{0 ,128,0};

static const ccColor3B ccSOX_BTN_BASE ={231 ,133,16};//{0 ,102,255};蓝色   {231 ,133,16};橙色

static const ccColor3B ccSOX_ORANGE ={255 ,128,0};


static const ccColor3B ccSOX_ORANGE2 ={248 ,212,4};


static const ccColor3B ccSOX_ORANGE3 ={231 ,133,16};

static const ccColor3B ccSOX_RED = {255,0,128};



@interface SOXGlobal : NSObject{
    
} 
@end
