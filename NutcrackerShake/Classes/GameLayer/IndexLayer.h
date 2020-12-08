//
//  GameLayer.h
//  SoxFrame
//
//  Created by jason yang on 14-02-26
//
//

#import "CCLayer.h" 
#import "BaseLayer.h"
@interface IndexLayer : BaseLayer {
    
}

//自动 效果隐藏
- (void)autoShowLayer;
- (void)autoHideLayer;

- (void)setAllColor:(ccColor3B)color;
@end
