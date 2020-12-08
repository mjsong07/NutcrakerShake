//
//  ScoreLayer
//  SoxFrame
//
//  Created by jason yang on 14-02-26
//
//

#import "CCLayer.h"
#import "GameInfo.h"
@interface GameInfo : CCLayer{
    
}
- (void)showLayer;
- (void)hiddenLayer;

- (void)addScore;
 
@property(nonatomic,assign)CCLabelTTF *nowScore;//

- (void)setAllColor:(ccColor3B)color;
@end
