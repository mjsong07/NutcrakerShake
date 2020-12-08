//
//  BGLayer.m
//  SoxFrame
//
//  Created by jason yang on 13-5-16.
//
//

#import "BGParticleLayer.h"
#import "CCAnimationHelper.h"
#import "GameLayer.h"
#import "GameHelper.h"
#import "ATAppTransferManager.h"
@implementation BGParticleLayer
- (id)init
{
	if ((self = [super init])) {//Untitled.plist  bg_effect.plist
        CCParticleSystem* particle = [CCParticleSystemQuad particleWithFile:@"bg_effect.plist"];
        particle.positionType = kCCPositionTypeFree;
        particle.position = ccp(G_SCREEN_CENTER.x, G_SCREEN_SIZE.height-40);
//        particle.visible = false;
        if(G_IS_IPAD){
            particle.startSize = particle.startSize*2;
            particle.posVar =ccp(particle.posVar.x, particle.posVar.y *2);
        }
        [self addChild:particle z:1 tag:1];
        
        /*
        CCParticleSystem* particle2 = [CCParticleSystemQuad particleWithFile:@"Untitled.plist"];
        particle2.positionType = kCCPositionTypeFree;
        particle2.position = ccp(-64, G_SCREEN_SIZE.height-40);
        //   particle.visible = false;
        if(G_IS_IPAD){
            particle2.startSize = particle2.startSize*2;
            particle2.posVar =ccp(particle2.posVar.x, particle2.posVar.y *2);
        }
        [self addChild:particle2 z:1 tag:2];
        */
        
	}
	return self;
}


//开始动画
- (void)showBgParticle
{
    CCParticleSystem *particle =  (CCParticleSystem*)[self getChildByTag:1];
    
    particle.visible = true;
}

- (void)hideBgParticle
{
    CCParticleSystem *particle =  (CCParticleSystem*)[self getChildByTag:1];
    particle.visible = false;
//    [particle stopSystem];
}
@end
