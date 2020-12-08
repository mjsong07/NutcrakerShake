//
//  LoadingScene.h
//  SoxFrame
//
//  Created by jason yang on 14-02-26
//
//

@interface SceneSwitch : CCScene{
    TargetScene _targetScene;
    CGPoint _positionCenter;
}
+ (id)showScene:(TargetScene)targetScene; 
- (id)initWithTargetScene:(TargetScene)targetScene;
- (void)update:(ccTime)delta;
@end
