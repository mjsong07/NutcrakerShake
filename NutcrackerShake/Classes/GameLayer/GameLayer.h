//
//  GameLayer.h
//  SoxFrame
//
//  Created by jason yang on 14-02-26
//
//

#import "CCLayer.h"
#import "Hero.h"   
#import "GADBannerView.h" 
#import "HeroBump.h"
@interface GameLayer : CCLayer {
    Hero *hero_;
    HeroBump *heroBump_; 
}
@property(nonatomic,assign)GameState nowGameState;//


@property(nonatomic,assign)double historyTopScore;//每次开始 记录最高历史分数


+(GameLayer*) sharedGameLayer;
-(void)toIndex;
-(void)startGame;
-(void)gameOver;
+ (id)scene;
@end
