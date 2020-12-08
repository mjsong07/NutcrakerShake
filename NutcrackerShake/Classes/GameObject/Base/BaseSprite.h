//
//  ActionSprite.h
//  PompaDroid
//
//  Created by Allen Benson G Tan on 10/21/12.
//  Copyright 2012 WhiteWidget Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCAnimationHelper.h" 
@interface BaseSprite : CCSprite {
    
}

@property bool  isMoveing;//是否正在移动
@property bool  isTouch;//是否 已经碰撞
@property float centerToLeft;//人物的中心点 与 左右上下距离



@property(nonatomic,assign)float centerToBottom;
@property(nonatomic,assign)ActionState nowActState;//基本动作 当前

@property(nonatomic,retain)id baseImgAct;//基本动画
@property(nonatomic,retain)CCAction *baseAct;//基本动画

@end
