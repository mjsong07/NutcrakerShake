//
//  GameLayer.m
//  SoxFrame
//
//  Created by jason yang on 14-02-26
//
//

#import "InputLayer.h"
#import "GameLayer.h"
@implementation InputLayer {
   
}

- (id)init
{
    if(self = [super init]){
        self.TouchEnabled = YES;
      //  [self addChild:imgSprite];
    }
    return self;
}


- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if([[GameHelper getGameLayer]nowGameState] == GameStateStart){
        [SOXSoundUtil play_click];
        Hero *hero = [GameHelper getHero];
        //UITouch *touch = [touches anyObject];
        //CGPoint location = [touch locationInView:[touch view]];
        //location = [[CCDirector sharedDirector] convertToGL:location];
        if(hero.nowMoveType == MoveTypeStop || hero.nowMoveType == MoveTypeLeft ){
            hero.nowMoveType = MoveTypeRight;
        }else if(hero.nowMoveType == MoveTypeRight ){
            hero.nowMoveType = MoveTypeLeft;
        }
        hero.baseInc = G_MOVE_FAST;
    }
    
}


- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
     if([[GameHelper getGameLayer]nowGameState] == GameStateStart){
         [GameHelper getHero].baseInc = G_MOVE_DEF;
     }
}


@end
