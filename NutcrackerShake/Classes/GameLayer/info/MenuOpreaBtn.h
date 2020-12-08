//
//  ScoreLayer
//  SoxFrame
//
//  Created by jason yang on 14-02-26
//
//

#import "CCLayer.h"
#import "MenuOpreaBtn.h"
@class MenuGameCenterInfo;
@interface MenuOpreaBtn : CCSprite{
    CCMenu *menuStart_;
    CCMenu *menuShare_;
    MenuGameCenterInfo *MenuGameCenterInfo_; 
}

- (void)setAllColor:(ccColor3B)color;
@end
