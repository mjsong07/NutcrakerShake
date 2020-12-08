//
//  GOHeadManagerFile.h
//  golo
//
//  Created by launch03 on 13-11-14.
//  Copyright (c) 2013年 LAUNCH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ATFileManager : NSObject

- (BOOL)isFileExistWithUrl:(NSString *)url;
- (void)writeImage:(UIImage *)image url:(NSString *)url;
- (void)writeImageData:(NSData *)imageData url:(NSString *)url;
- (NSString *)filePathWithUrl:(NSString *)url;

- (UIImage *)readImage:(NSString *)fileName;
- (void)removeImage:(NSString *)fileName;

@end
