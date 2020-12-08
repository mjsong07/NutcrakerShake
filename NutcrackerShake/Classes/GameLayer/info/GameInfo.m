//
//  ScoreLayer
//  SoxFrame
//
//  Created by jason yang on 14-02-26
//
//

#import "GameLayer.h"
#import "GameInfo.h"
@implementation GameInfo

- (id)init
{
	self = [super init];
	if (self) {
        //HelveticaNeue-Bold STHeitiSC-Medium
        
        self.nowScore = [CCLabelTTF labelWithString:@"0" fontName:@"HelveticaNeue" fontSize:getRS(60)];
     //  self.nowScore = [CCLabelBMFont labelWithString:@"0" fntFile:@"futura-48.fnt"];
        [self addChild:_nowScore];
        _nowScore.position = ccp(G_SCREEN_SIZE.width/2,G_SCREEN_SIZE.height- getRS(G_AD_HEIGHT) );//   G_SCREEN_CENTER.y
        _nowScore.color = ccSOX_BTN_BASE;
        self.visible = false;
	}
	return self;
}


- (void)addScore
{
   double nowVal =  [[_nowScore string]doubleValue] ;
   nowVal = nowVal+1;
   NSString *strScore = [SOXUtil notRounding:nowVal afterPoint:0];
   [_nowScore setString:strScore];
} 

- (void)showLayer
{
    [_nowScore setString:@"0"];
    [self setVisible:true];
}
- (void)hiddenLayer
{
    [self setVisible:false];
}

- (void)setAllColor:(ccColor3B)color
{
    [_nowScore setColor:color];
}
@end
