//
//  ActionSprite.m
//  PompaDroid
//
//  Created by Allen Benson G Tan on 10/21/12.
//  Copyright 2012 WhiteWidget Inc. All rights reserved.
//

#import "BaseSprite.h"

#import "CCAnimationHelper.h"
@implementation BaseSprite 
- (void)setToHidden
{
    self.visible = false;
}

- (void)setToTouch
{
    self.isTouch = true;
}
//子类如果 只有一张图片  可以使用以下方法
/*
- (id)initWithImage
{
    [super initWithSpriteFrameName:@"xxx.png"];
	return self;
}*/
@end
