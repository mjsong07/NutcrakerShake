 

#import "CCAnimationHelper.h"

@implementation CCAnimation (Helper) 
// Creates an animation from single files.
+ (CCAnimation*)animationWithFileSingle:(NSString*)name 
{
    NSMutableArray* frames = [NSMutableArray arrayWithCapacity:1]; 
    NSString* file = [NSString stringWithFormat:@"%@", name];
    CCSpriteFrameCache* frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
    CCSpriteFrame* frame = [frameCache spriteFrameByName:file];
    [frames addObject:frame];
    return [CCAnimation animationWithSpriteFrames:frames delay:1.0f];
	//return [CCAnimation animationWithName:name delay:1.0f frames:frames];
}
 /*
+ (CCAnimation*)animationWithFile:(NSString*)name frameCount:(int)frameCount delay:(float)delay
{ 
	NSMutableArray* frames = [NSMutableArray arrayWithCapacity:frameCount];
	for (int i = 0; i < frameCount; i++) { 
		NSString* file = [NSString stringWithFormat:@"%@%i.png", name, i+1];
		CCTexture2D* texture = [[CCTextureCache sharedTextureCache] addImage:file]; 
		CGSize texSize = [texture contentSize];
		CGRect texRect = CGRectMake(0, 0, texSize.width, texSize.height);
		//CCSpriteFrame* frame = [CCSpriteFrame frameWithTexture:texture rect:texRect offset:CGPointZero];
         CCSpriteFrame* frame = [frameCache spriteFrameByName:file];
		[frames addObject:frame];
	}
    return [CCAnimation animationWithSpriteFrames:frames delay:delay];
	//return [CCAnimation animationWithName:name delay:delay frames:frames];
}*/
 //系统默认 从 1开始 count结束  suffix 文件格式后缀
+ (CCAnimation*)animationWithFrame:(NSString*)frame suffix:(NSString*)suffix frameCount:(int)frameCount delay:(float)delay 
{ 
	NSMutableArray* frames = [NSMutableArray arrayWithCapacity:frameCount];
	for (int i = 1; i <= frameCount; i++)
	{
		NSString* file = [NSString stringWithFormat:@"%@%i.%@", frame, i,suffix];
		CCSpriteFrameCache* frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
		CCSpriteFrame* frame = [frameCache spriteFrameByName:file];
		[frames addObject:frame];
	}
    return [CCAnimation animationWithSpriteFrames:frames delay:delay];
	//return [CCAnimation animationWithName:frame delay:delay frames:frames];
} 

+ (CCAnimation*)animationWithFrameBeginEnd:(NSString*)frame
                                    suffix:(NSString*)suffix
                                frameCount:(int)frameCount
                                     begin:(int)begin
                                       end:(int)end
                                     delay:(float)delay
{
	NSMutableArray* frames = [NSMutableArray arrayWithCapacity:end - begin];
	for (int i = begin; i <= end; i++)
	{
		NSString* file = [NSString stringWithFormat:@"%@%i.%@", frame, i,suffix];
		CCSpriteFrameCache* frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
		CCSpriteFrame* frame = [frameCache spriteFrameByName:file];
		[frames addObject:frame];
	} 
    return [CCAnimation animationWithSpriteFrames:frames delay:delay]; 
	//return [CCAnimation animationWithName:frame delay:delay frames:frames];
}

//特殊处理 指定同一个名称的 某个几张图片
 // NSArray *inputArray=[[NSArray alloc]initWithObjects:@"1",@"2",@"3",@"4",@"5", nil];
+ (CCAnimation*)animationWithFrameArray:(NSString*)frame suffix:(NSString*)suffix inputArray:(NSArray*)inputArray   delay:(float)delay 
{ 
	NSMutableArray* frames = [NSMutableArray arrayWithCapacity:[inputArray count] ];
	for (int i = 0; i < [inputArray count]; i++)
	{
		NSString* file = [NSString stringWithFormat:@"%@%i.%@", frame, i,suffix];
		CCSpriteFrameCache* frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
		CCSpriteFrame* frame = [frameCache spriteFrameByName:file];
		[frames addObject:frame];
	}
     return [CCAnimation animationWithSpriteFrames:frames delay:delay];
	//return [CCAnimation animationWithName:frame delay:delay frames:frames];
} 
//特殊处理 指定不同名称的  几张图片
 // NSArray *inputArray=[[NSArray alloc]initWithObjects:@"1",@"2",@"3",@"4",@"5", nil];
+ (CCAnimation*)animationWithFrameArrayDiff:(NSString*)frame suffix:(NSString*)suffix inputArray:(NSArray*)inputArray   delay:(float)delay 
{ 
	NSMutableArray* frames = [NSMutableArray arrayWithCapacity:[inputArray count] ];
	for (int i = 0; i < [inputArray count]; i++)
	{
		NSString* file = [NSString stringWithFormat:@"%@.%@", [inputArray objectAtIndex:i],suffix];
		CCSpriteFrameCache* frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
		CCSpriteFrame* frame = [frameCache spriteFrameByName:file];
		[frames addObject:frame];
	}
     return [CCAnimation animationWithSpriteFrames:frames delay:delay];
	//return [CCAnimation animationWithName:frame delay:delay frames:frames];
} 
@end
