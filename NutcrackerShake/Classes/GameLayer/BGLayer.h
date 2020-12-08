//
//  BGLayer.h
//  SoxFrame
//
//  Created by jason yang on 13-5-16.
//
//

#import "BaseLayer.h" 
@interface BGLayer : CCLayer 
{
	CCSpriteBatchNode* spriteBatch_;
    int increase_ ;
    int nowTotalTime_ ;
    int showSunMoonX_ ;//默认显示的x坐标
    int showSunMoonY_ ;//默认显示的x坐标

}

@property(nonatomic,assign)int dayType;//生命数量
- (void)update:(ccTime)delta;
- (void)setShowLayer;
- (void)startMoive;
@end
