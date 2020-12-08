//
//  SOXMapUtil.m
//  SoxFrame
//
//  Created by jason yang on 13-5-27.
//
//

#import "SOXDBUtil.h"  
#import "SOXUtil.h"
#import "SOXEncryption.h"
@implementation SOXDBUtil   

//初始化 保存的 信息
+ (void)initInfoByMenuItem:(CCMenuItemToggle *)menuItem :(NSString *)key{
    if (menuItem != nil ) {
        NSString *musicFlag= [SOXDBUtil loadInfo:key];
        if( [musicFlag isEqualToString:G_STR_NO] ){
            [menuItem setSelectedIndex:0];
        }else{
            [menuItem setSelectedIndex:1];
        }
    }
}



//检测当前是否 需要更新   以大为主
+ (BOOL)chkIsNeedUpdateByFloat:(NSString *)key :(float) value{
     BOOL flag = false;
    float now = value;
    float ori = 0.0f; 
    NSString *strSaveVal=[SOXDBUtil loadInfo:key];
    if ([SOXUtil isNotNull:strSaveVal]  ){
        ori =[strSaveVal floatValue];
    } 
    if (now > ori){
        flag = true;
    }
    return flag;
}


+ (BOOL)chkIsNeedUpdateByInt:(NSString *)key :(int) value{
    int now = value;
    int ori = 0; 
    BOOL flag = false;
    NSString *strSaveVal=[SOXDBUtil loadInfo:key];
    if ([SOXUtil isNotNull:strSaveVal]){
        ori =[strSaveVal intValue];
    } 
    if (now > ori){
        flag = true;
    }
    return flag;
}
+ (BOOL)chkIsNeedUpdateByDouble:(NSString *)key :(double) value{
    double now = value;
    double ori = 0;
    BOOL flag = false;
    NSString *strSaveVal=[SOXDBUtil loadInfo:key];
    if ([SOXUtil isNotNull:strSaveVal]){
        ori =[strSaveVal doubleValue];
    }
    if (now > ori){
        flag = true;
    }
    return flag;
}


//更新 根据 最新 最大 覆盖 返回是否更新了
+ (BOOL)updateInfoByInt:(NSString *)key :(int) value{
    bool isNeedUpdate = [SOXDBUtil chkIsNeedUpdateByInt:key :value];
    if(isNeedUpdate){
        NSString *strValue = [SOXUtil intToString:value];
        [SOXDBUtil saveInfo:key :strValue]; 
    }
    return isNeedUpdate;
}
//更新 根据 最新 最大 覆盖  返回是否更新了
+ (BOOL)updateInfoByFloat:(NSString *)key :(float) value{
    bool isNeedUpdate = [SOXDBUtil chkIsNeedUpdateByFloat:key :value];
    if(isNeedUpdate){ 
        NSString *strValue = [SOXUtil floatToString:value];
        [SOXDBUtil saveInfo:key :strValue];
    }
    return isNeedUpdate;
}
+ (BOOL)updateInfoByDouble:(NSString *)key :(double) value{
    bool isNeedUpdate = [SOXDBUtil chkIsNeedUpdateByDouble:key :value];
    if(isNeedUpdate){
        NSString *strValue = [SOXUtil doubleToString:value];
        [SOXDBUtil saveInfo:key :strValue];
    }
    return isNeedUpdate;
}

//save 用户数据
+ (void)saveInfo:(NSString *)key :(NSString *) value{
    //Save
    NSUserDefaults *saveDefaults = [NSUserDefaults standardUserDefaults];
    //此处需要注意 设置可以为空的 情况  可能会影响之前的 保存为空代码
    if(value!=nil){// && ![value isEqualToString:@""]
        NSData *data=  [SOXEncryption Encrypt:value];//添加加密
        [saveDefaults setObject:data forKey:key];
    }
}
//load 用户数据
+ (NSString *)loadInfo:(NSString *)key{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData  *data = [userDefaults objectForKey:key];//str
    NSString *str= @"";
    if(data!=nil){
        str=  [SOXEncryption Decrypt:data]; //添加解密
    } 
    return str;
}
//加载返回 int类型
+ (int)loadInfoReturnInt:(NSString *)key{  
     NSString  *str = [SOXDBUtil loadInfo:key];
    int val = 0;
    if([SOXUtil isNotNull:str]){
        val = [str intValue];
    }
    return val;
}
//加载返回 double类型
+ (double)loadInfoReturnDouble:(NSString *)key{
    NSString  *str = [SOXDBUtil loadInfo:key];
    double val = 0;
    if([SOXUtil isNotNull:str]){
        val = [str doubleValue];
    }
    return val;
}
//加载返回 bool类型
+ (BOOL)loadInfoReturnBool:(NSString *)key{ 
     int  val = [SOXDBUtil loadInfoReturnInt:key];  
    if(val>0){
        return true;
    }else{
        return false;
    } 
}

+ (void)updateInfoByBool:(NSString *)key :(BOOL) value{
    if(value == true){
        [SOXDBUtil saveInfo:key :G_STR_YES];
    }else{
        [SOXDBUtil saveInfo:key :G_STR_NO];
    }
}

@end
