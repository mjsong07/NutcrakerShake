//
//  UIImage+ATAdditions.h
//  TestR
//
//  Created by haiqin.wang on 14-6-4.
//  Copyright (c) 2014年 haiqin.wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ATAdditions)

- (UIImage *)clipFromCenterWithSize:(CGSize)size;
- (UIImage *)clipImageRect:(CGRect)rect;
- (UIImage *)resizeImageSize:(CGSize)newSize;
- (UIImage *)resizeImageAspectFitWithWidth:(CGFloat)width;
- (UIImage *)resizeImageAspectFitWithHeight:(CGFloat)height;

- (UIImage *)rotateImageOrientation:(UIDeviceOrientation)orient;

@end
