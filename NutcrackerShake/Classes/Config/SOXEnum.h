//
//  Defines.h
//  PompaDroid
//
//  Created by Allen Benson G Tan on 10/21/12.
//
//
typedef enum _SoundType{
    T_SOUND_NULL,
    T_SOUND_GAME
} SoundType;

typedef enum _DeviceType{
    T_DEVICE_No_Iphone5,
    T_DEVICE_Iphone5
} DeviceType;

//游戏场景切换
typedef enum _TargetScene{
    T_SCENE_NULL,
    T_SCENE_LOGO,
    T_SCENE_GAME_LAYER,
    T_SCENE_MAX
} TargetScene; 


//对象层级
enum T_Layer
{
    T_Layer_BG=-11,
    T_Layer_BG_Particle=-10,
    T_Layer_Game=-9,
    T_Layer_Thing=-8,
    T_Layer_Input=-7,
    T_Layer_Index=-6,//首页和 分数 添加在 gamelayer 上面
    T_Layer_Score=-5,//
    
    T_Layer_BG_Shake_White=-4,//
    T_Layer_BG_Shake=-3,//
    T_Layer_Pause=-2,//
    T_Layer_GameInfo=-111,//
    T_Layer_Cache=0//
};
//对象层级
enum T_OBJ
{  
    T_OBJ_HERO=2,
    T_OBJ_HERO_BUMP=3
}; 

//对象层级
enum T_BG_OBJ
{
    T_BG_White=1,
    T_BG_Black=2,
    T_BG_Sun=3,
    T_BG_Moon=4,
    T_BG_Earth=5,
    T_BG_EarthAll=6,
    T_BG_House1=10,
    T_BG_House2=11,
    T_BG_House3=12,
    T_BG_House4=13
};


//实际 物件类别
typedef enum _ThingObjType
{
    ThingObjNull=-1,
	ThingObjChess0=0,//  ThingObjLife=4,
    ThingObjChess1=1,
    ThingObjChess2=2,
    ThingObjChess3=3,
    ThingObjChess4=4,
    ThingObjChess5=5,
    ThingObjMax=6
} ThingObjType;


//ThingObjChess1=1,
//ThingObjChess2=2,


//基本动作
typedef enum _ActionState
{
    kActionStateNone = 0,
    kActionStateDef,
    kActionStateRun,
    kActionStateDead 
} ActionState;




//游戏状态
typedef enum _GameLevel
{
    GameLevel1 = 0,
    GameLevel2 = 1,
    GameLevel3 = 2,
} GameLevel;


//游戏状态
typedef enum _GameState
{
    GameStateStop= 0,
    GameStateStart = 1,
    GameStateOver= 2,
} GameState;

//点击类型
typedef enum _TouchType
{
    TouchTypeNull=-1,
    TouchTypeOff=0,
    TouchTypeOn=1
} TouchType;

//移动类型
typedef enum _MoveType
{
    MoveTypeLeft=-1,
    MoveTypeStop=0,
    MoveTypeRight=1
} MoveType;
 
