//
//  SOXMapUtil.m
//  SoxFrame
//
//  Created by jason yang on 13-5-27.
//
//

#import "SOXUtil.h"   
#import "AppDelegate.h"
@implementation SOXUtil
+ (NSString*)intToString:(int)i{
    return [NSString stringWithFormat:@"%d",i];
}
+ (NSString*)floatToString:(float)f{
    return [NSString stringWithFormat:@"%f",f];
}

+ (NSString*)doubleToString:(double)d{
    return [NSString stringWithFormat:@"%f",d];
}

+ (int)floatToInt:(float)f{
    return [[SOXUtil floatToString:f]intValue];
}

+ (int)intToFloat:(int)i{
    return [[SOXUtil intToString:i]floatValue];
}
+ (int)intToDouble:(int)i{
    return [[SOXUtil intToString:i]doubleValue];
}

+ (NSString*)isNull:(NSString *)str{
    if(str==nil || [str isEqualToString:@""]){
        return true;
    }
    return false;
}
+ (NSString*)isNotNull:(NSString *)str{
    if(str!=nil && ![str isEqualToString:@""]){
        return true;
    }
    return false; 
}
   
+ (NSString *)getFormatTimeStr:(int)time{
    NSString *strSecond = @"";
    if (time < 10) {
        strSecond= [NSString stringWithFormat:@"0%d",time] ;// strSecond = ""
    } else {
        strSecond= [NSString stringWithFormat:@"%d",time] ;
    }
    return strSecond;
}
+ (NSString *)getFormatAllTimeStr:(float)time{
    NSString *strReturn = @"";
    NSNumber *n_minute=[NSNumber numberWithFloat:time/60];
    NSNumber *n_second=[NSNumber numberWithFloat:time];
    int minute=[n_minute intValue];
    int second=[n_second intValue]%60;
    NSString *strMinute=[SOXUtil getFormatTimeStr:minute];
    NSString *strSecond=[SOXUtil getFormatTimeStr:second];
    strReturn=[NSString stringWithFormat:@"%@:%@",strMinute, strSecond];
    return strReturn;
}
+ (NSString *)getFormatAllDistanceStr:(float)time{
    NSString *strReturn = @"";
    NSNumber *n_minute=[NSNumber numberWithFloat:time/60];
    NSNumber *n_second=[NSNumber numberWithFloat:time];
    int minute=[n_minute intValue];
    int second=[n_second intValue]%60;
    NSString *strMinute=[SOXUtil getFormatTimeStr:minute];
    NSString *strSecond=[SOXUtil getFormatTimeStr:second];
    strReturn=[NSString stringWithFormat:@"%@:%@",strMinute, strSecond];
    return strReturn;
}

+ (NSString *)notRounding:(double)price afterPoint:(int)position{
    NSDecimalNumberHandler* roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown scale:position raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    NSDecimalNumber *ouncesDecimal;    NSDecimalNumber *roundedOunces;
    ouncesDecimal = [[NSDecimalNumber alloc] initWithDouble:price];
    roundedOunces = [ouncesDecimal decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    [ouncesDecimal release];
    return [NSString stringWithFormat:@"%@",roundedOunces];
}


+ (int)getRandomByDict :(NSMutableDictionary*)dict{
   // srand(time(NULL));
    if(dict == nil){
        return 0;
    }
    NSArray *keyArray = [dict allKeys];
    if(keyArray.count == 0){
        return 0;
    }
    int i = arc4random()%keyArray.count;
    return [[keyArray objectAtIndex:i] intValue];
}



//注意 生产的 总是尽量是 原始char的 +2  或以上  否则 如果+1 默认之后加在最后面 。。。
+ (NSString*)createRandomCharList :(NSString*)strChar :(int)createCnt{
    if(createCnt <= strChar.length ){
        return strChar;
    }
    NSString *lastVal = @"";
    int _insertCount = createCnt - strChar.length ;
  //  if(_insertCount == 0){
   //     return strChar;
  //  }
    for (int i = 0; i < [strChar length]; i++){
        //找拼接
        int nowInesrtCnt = arc4random()%_insertCount;
        _insertCount = _insertCount-nowInesrtCnt;
        NSString *insertStr= [SOXUtil getRandomCharList:strChar :nowInesrtCnt];
        //取出初始值
        NSString *strOri = [strChar substringWithRange:NSMakeRange(i, 1)];
        //第一个参数 往前面插入
        if(i == 0){
            lastVal = [NSString stringWithFormat:@"%@%@%@",lastVal,insertStr,strOri];
        }else{
            //第一个之后  往后面插入
            lastVal = [NSString stringWithFormat:@"%@%@%@",lastVal,strOri,insertStr];
        }
    }
    //把剩余 没有生成的 补上
    if(_insertCount>0){
        NSString *insertStr= [SOXUtil getRandomCharList:strChar :_insertCount];
        lastVal = [NSString stringWithFormat:@"%@%@",lastVal,insertStr];
    }
    return lastVal;
}

+ (NSString*)getRandomCharList :(NSString*)strChar :(int )insertCnt{
    NSString *newVal = @"";
    for (int i=0; i<insertCnt; i++) {
        NSString *randomStr= [SOXUtil getRandomChar:strChar];
        newVal = [NSString stringWithFormat:@"%@%@",randomStr,newVal];
    }
    return newVal;
}
//between -1 and 1
+ (float)getRandomMinus1_1{
    return CCRANDOM_MINUS1_1() ;
}
//returns a random float between 0 and 1
+ (float)getRandom0_1{
    return CCRANDOM_0_1() ;
}

+ (NSString*)getRandomChar :(NSString*)strChar{
    NSString *nowVal = @"";
    if(strChar!=nil && [strChar length] > 0){
        int i =arc4random()%[strChar length];
        nowVal = [strChar substringWithRange:NSMakeRange(i, 1)];
    }
    return nowVal;
}


+(void)showAlert:(NSString *)title :(NSString *)message {
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:title
                          message:message
                          delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil];
    [alert show];
    [alert release];
}

 

@end
