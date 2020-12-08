//
//  log.m
//  SoxFrame
//
//  Created by jason yang on 13-5-28.
//
//

#import "SOXDebug.h" 
@implementation SOXDebug

+ (void)logInt:(int)i
{
    CCLOG(@"now i:%i",i);
}

+ (void)logBol:(bool)bol
{
    if (bol) {
        CCLOG(@"now bol:是");
    }else{
        CCLOG(@"now bol:否");
    } 
}

+ (void)logFloat:(float)f
{
    CCLOG(@"logF f:%f",f);
}

+ (void)logStr:(NSString* )str
{
    CCLOG(@"logTest str:%@",str);
}

+ (void)logTagStr:(NSString* )tag :(NSString* )str
{
    CCLOG(@"logTest %@ :%@",tag,str);
}

+ (void)logTagInt:(NSString* )tag :(int)i
{
    CCLOG(@"logTest %@ :%d",tag,i);
}

+ (void)logTagFloat:(NSString* )tag :(float)f
{
    CCLOG(@"logTest %@ :%f",tag,f);
}
 


+ (void)logPonit:(CGPoint)point
{
    CCLOG(@"logPonit x:%f,y:%f",point.x,point.y); 
}

+ (void)logAnchorPoint:(id)sprite
{
    if (sprite != nil) {
        CCSprite *s=(CCSprite*)sprite;
        CCLOG(@"logAXY x:%f,y:%f",s.anchorPoint.x,s.anchorPoint.y);
    }
} 
+ (void)logHW:(id)sprite
{
    if (sprite != nil) {
        CCSprite *s=(CCSprite*)sprite;
        CCLOG(@"logHW w:%f,h:%f",s.contentSize.width,s.contentSize.height);
    }
}

+ (void)logImgHW:(id)sprite
{
    if (sprite != nil) {
        CCSprite *s=(CCSprite*)sprite;
        CCLOG(@"logHW w:%f,h:%f",s.textureRect.size.width,s.textureRect.size.height);
    }
}

+ (void)testLongLoadingTime
{
	// Simulating a long loading time by doing some useless calculation a large number of times.
	double a = 122, b = 243;
	for (unsigned int i = 0; i < 1000000000; i++)
	{
		a = a / b;
	}
} 

+ (void)drawRectFaster:(CGRect)rect
{
    glLineWidth( 5.0f );
    ccDrawColor4B(255,0,0,255);
	CGPoint pos1, pos2, pos3, pos4;
	pos1 = CGPointMake(rect.origin.x, rect.origin.y);
	pos2 = CGPointMake(rect.origin.x, rect.origin.y + rect.size.height);
	pos3 = CGPointMake(rect.origin.x + rect.size.width, rect.origin.y + rect.size.height);
	pos4 = CGPointMake(rect.origin.x + rect.size.width, rect.origin.y);
	CGPoint vertices[8];
	vertices[0] = pos1;
	vertices[1] = pos2;
	vertices[2] = pos2;
	vertices[3] = pos3;
	vertices[4] = pos3;
	vertices[5] = pos4;
	vertices[6] = pos4;
	vertices[7] = pos1;
    ccDrawPoly( vertices, 8, false);
}


@end
