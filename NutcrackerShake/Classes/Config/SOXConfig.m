//
//  log.m
//  SoxFrame
//
//  Created by jason yang on 13-5-28.
//
//

#import "SOXConfig.h" 
#import "GameLayer.h"
#import "SOXEnum.h"
@implementation SOXConfig

static SOXConfig *soxConfig = nil;
+(SOXConfig*) sharedConfig {
    
    if (soxConfig == nil) {
        soxConfig = [[SOXConfig alloc] init] ;
        [soxConfig initAll];
    }
    return  soxConfig;
}



- (void)initAll{
 //  _isOpenMusic=false;//默认打开
    _isOpenSound=true;
    [self judgeDeviceType];
    NSString *sound= [SOXDBUtil loadInfo:G_KEY_SOUND];
    if([SOXUtil isNotNull:sound]){
        if([sound isEqualToString:G_STR_YES]){
            _isOpenSound=true;
        }else{
            _isOpenSound=false;
        }
    }
}

//判断设备是否属于Iphone或最新ipod touch
-(void)judgeDeviceType{
    CGSize result = [[UIScreen mainScreen]bounds].size;
    if(result.height ==480){
        _nowDeviceType = T_DEVICE_No_Iphone5;
    }else if(result.height ==568){
         _nowDeviceType = T_DEVICE_Iphone5;
    }
}

- (void)setIsOpenMusicStr:(NSString *)index{
    if( [index isEqualToString:@"0"] ){
        _isOpenMusic = true;
    }else{
        _isOpenMusic = false;
    } 
}
- (void)setIsOpenSoundStr:(NSString *)index{
    if( [index isEqualToString:@"0"] ){
        _isOpenSound = true;
    }else{
        _isOpenSound = false;
    }
}

- (void)resetAll{
    //是否打开测试模式
    BOOL isDebug = [SOXDBGameUtil loadIsDebug];
    if(isDebug == true){
        
    }else{
        _nowMapRunTimes = 0;
        _nowGameLevel = 0;
    }
    
}
 

@end
