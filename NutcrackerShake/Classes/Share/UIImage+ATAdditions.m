//
//  UIImage+ATAdditions.m
//  TestR
//
//  Created by haiqin.wang on 14-6-4.
//  Copyright (c) 2014年 haiqin.wang. All rights reserved.
//

#import "UIImage+ATAdditions.h"

@implementation UIImage (ATAdditions)

- (UIImage *)clipFromCenterWithSize:(CGSize)size
{
    CGSize resizeSize;
    if (self.size.width > self.size.height) {
        resizeSize.height = size.height;
        resizeSize.width = self.size.width * resizeSize.height / self.size.height;
    } else if (self.size.width < self.size.height) {
        resizeSize.width = size.width;
        resizeSize.height = self.size.height * resizeSize.width / self.size.width;
    } else {
        resizeSize = size;
    }
    
    CGRect resizeImageRect = CGRectMake(-(resizeSize.width - size.width) * 0.5, -(resizeSize.height - size.height) * 0.5,
                                        resizeSize.width, resizeSize.height);
    
    UIGraphicsBeginImageContext(size);
    [self drawInRect:resizeImageRect];
    UIImage *clipImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return clipImage;
}

- (UIImage *)clipImageRect:(CGRect)rect
{
    CGImageRef imageRef = self.CGImage;
    CGImageRef newImageRef = CGImageCreateWithImageInRect(imageRef, rect);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    CGImageRelease(newImageRef);
    return newImage;
}

- (UIImage *)resizeImageSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext(newSize);
    [self drawInRect:CGRectMake(0.0, 0.0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (UIImage *)resizeImageAspectFitWithWidth:(CGFloat)width
{
    float imageWidth = self.size.width;
    float imageHeight = self.size.height;
    
    if (imageWidth == width) {
        return self;
    }
    
    CGSize newSize;
    newSize.width = width;
    float ratio = imageWidth / width;
    newSize.height = roundf(imageHeight / ratio);
    
    return [self resizeImageSize:newSize];
}

- (UIImage *)resizeImageAspectFitWithHeight:(CGFloat)height
{
    float imageWidth = self.size.width;
    float imageHeight = self.size.height;
    
    if (imageHeight == height) {
        return self;
    }
    
    CGSize newSize;
    newSize.height = height;
    float ratio = imageHeight / height;
    newSize.width = roundf(imageWidth / ratio);
    
    return [self resizeImageSize:newSize];
}

- (UIImage *)rotateImageOrientation:(UIDeviceOrientation)orient
{
	CGImageRef imgRef = self.CGImage;
	CGFloat width = CGImageGetWidth(imgRef);
	CGFloat height = CGImageGetHeight(imgRef);
    
	CGAffineTransform transform = CGAffineTransformIdentity;
    
    CGSize drawSize;
    CGFloat rotateRadian = 0;
    switch (orient) {
        case UIInterfaceOrientationLandscapeLeft: {
            // CW 90, home button left
            //            transform = CGAffineTransformMakeTranslation(0, 0);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            drawSize = CGSizeMake(height, width);
            rotateRadian = M_PI_2;
            break;
        }
        case UIInterfaceOrientationPortraitUpsideDown: {
            // CW 180, home button top
            transform = CGAffineTransformMakeTranslation(width, 0);
            transform = CGAffineTransformScale(transform, 1.0, -1.0);
            drawSize = CGSizeMake(width, height);
            rotateRadian = M_PI;
            break;
        }
        case UIInterfaceOrientationLandscapeRight: {
            // CW 270, home button right
            transform = CGAffineTransformMakeTranslation(height, width);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            drawSize = CGSizeMake(height, width);
            rotateRadian = 3 * M_PI_2;
            break;
        }
        default:
            return nil;
            break;
    }
	transform = CGAffineTransformRotate(transform, rotateRadian);
    
	UIGraphicsBeginImageContext(drawSize);
	CGContextRef context = UIGraphicsGetCurrentContext();
    
	CGContextConcatCTM(context, transform);  // will upside down ??
	CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, width, height), imgRef);
	UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return newImage;
}

@end
