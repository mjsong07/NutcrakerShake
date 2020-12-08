//
//  GameLayer.m
//  SoxFrame
//
//  Created by jason yang on 14-02-26
//
//

#import "BaseLayer.h"
@implementation BaseLayer {
   
}

- (void)showLayer{
    self.visible = true;
    self.touchEnabled = true;
}
- (void)hideLayer
{
    self.visible = false;
    self.touchEnabled = false;
}
@end
