//
//  ScoreLayer
//  SoxFrame
//
//  Created by jason yang on 14-02-26
//
//

#import "CCLayer.h"
#import "MenuScoreInfo.h"
@interface MenuScoreInfo : CCLayer{
    CCLabelTTF *labelNowScore_;
    CCLabelTTF *labelBestScore_;
    NSMutableDictionary* nowScoreMapDict_;
}
- (void)updateScore;
- (NSMutableDictionary*)updateDBScoreInfo;
- (void)hiddenLayer;
@end
