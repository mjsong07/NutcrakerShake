 
#import "HeroBump.h"
@implementation HeroBump {
    
}


//设置跟踪得圆形
- (void)setPositionByHero:(Hero*)hero
{
    
    float nowRotation = abs(hero.rotation);
    float x =  0;
    float xx =  0;
    float y =  0;
    float radians = CC_DEGREES_TO_RADIANS(nowRotation);
    float aa =  sin(radians);
    x =   aa *hero.contentSize.height ;
    y =  cos(radians) *hero.contentSize.height ;
    if(hero.rotation<0){
        xx = (G_SCREEN_SIZE.width /2 -x*0.83) ;
    }else if(hero.rotation>=0 ){
        xx = (G_SCREEN_SIZE.width /2 +x*0.83) ;
    }
    y = y *0.83;
    self.position =  ccp( xx , y  );
}

@end
