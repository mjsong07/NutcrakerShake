//
//  ScoreLayer
//  SoxFrame
//
//  Created by jason yang on 14-02-26
//
//

#import "CCLayer.h"
#import "BaseLayer.h" 
@interface ScoreLayer : BaseLayer<UIAlertViewDelegate>{
    
}
@property double nowScore;//记录当前分数 用于分享时候 全局访问
- (void)showLayer;

- (void)hideLayer;

- (void)hideToIndexLayer;

- (void)setAllColor:(ccColor3B)color;

@end
