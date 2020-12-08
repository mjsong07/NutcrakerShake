
#import <Foundation/Foundation.h>


@interface CCAnimation (Helper)

+ (CCAnimation*)animationWithFileSingle:(NSString*)name;
//+ (CCAnimation*)animationWithFile:(NSString*)name frameCount:(int)frameCount delay:(float)delay;
+ (CCAnimation*)animationWithFrame:(NSString*)frame suffix:(NSString*)suffix frameCount:(int)frameCount delay:(float)delay ;
+ (CCAnimation*)animationWithFrameBeginEnd:(NSString*)frame suffix:(NSString*)suffix frameCount:(int)frameCount begin:(int)begin end:(int)end delay:(float)delay ; 
+ (CCAnimation*)animationWithFrameArray:(NSString*)frame suffix:(NSString*)suffix inputArray:(NSArray*)inputArray   delay:(float)delay  ;

+ (CCAnimation*)animationWithFrameArrayDiff:(NSString*)frame suffix:(NSString*)suffix inputArray:(NSArray*)inputArray   delay:(float)delay  ;
@end
