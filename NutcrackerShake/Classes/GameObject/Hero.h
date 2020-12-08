 

#import <Foundation/Foundation.h>
 
#import "BaseSprite.h" 
@interface Hero : BaseSprite{
    
}
@property(nonatomic,assign)int lifes;//生命数量
@property(nonatomic,assign)int scores;//数量

@property(nonatomic,assign)MoveType nowMoveType;//当前移动方向
@property(nonatomic,assign)float baseInc;//速度


- (void)initDefAction; 


@property(nonatomic,assign)CCSprite *bumpObj;//当前移动方向
//动画
@property(nonatomic,retain)CCAction *defAct;
@property(nonatomic,retain)CCAction *deadAct;


@property(nonatomic,retain)id defImgAct;
@property(nonatomic,retain)id deadImgAct;




//默认动作
- (void)defaultDo;

+ (id)objInit;
- (id)initWithImage;//只初始化图片动画
//基本动作
- (void)defaultDo; //基本默认
- (void)dead;//死亡

- (void)updateAct:(ccTime)delta;
- (void)revival;

- (void)birth;


@end
