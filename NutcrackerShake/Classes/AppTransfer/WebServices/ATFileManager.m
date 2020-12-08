//
//  GOHeadManagerFile.m
//  golo
//
//  Created by launch03 on 13-11-14.
//  Copyright (c) 2013年 LAUNCH. All rights reserved.
//

#import "ATFileManager.h"
#import "ATDataBaseManager.h"
#import "NSString+ATAdditions.h"

#define IM_HEAD_DIR     ([NSString stringWithFormat:@"%@/Documents/abc/HeadImage",NSHomeDirectory()])
#define PATH_IN_USER    ([NSString stringWithFormat:@"%@/Documents/abc", NSHomeDirectory()])
#define PATH_IN_IM_HEAD_DIR(f)      ([NSString stringWithFormat:@"%@/Documents/abc/HeadImage/%@",NSHomeDirectory(),f])


@interface ATFileManager ()
{
    NSFileManager *fileManager_;
}

@end

@implementation ATFileManager

- (id)init
{
    self = [super init];
    if (self) {
        fileManager_ = [NSFileManager defaultManager];
        
        /*
        NSFileManager *fm = [NSFileManager defaultManager];
        NSString* lujing = IM_HEAD_DIR;
        NSString *path = PATH_IN_USER;
        if (![fm fileExistsAtPath:path isDirectory:NULL])
        {
            [fm createDirectoryAtPath:path
          withIntermediateDirectories:YES
                           attributes:nil
                                error:nil];
        }
        
        if (![fm fileExistsAtPath:lujing isDirectory:NULL])
        {
            [fm createDirectoryAtPath:lujing
          withIntermediateDirectories:NO
                           attributes:nil
                                error:nil];
        }
        */
    }
    return self;
}

- (BOOL)isFileExistWithUrl:(NSString *)url
{
    NSString *filePath = [[ATDataBaseManager atDocPath] stringByAppendingPathComponent:[url MD5String]];
    return [fileManager_ fileExistsAtPath:filePath];
}

- (void)writeImage:(UIImage *)image url:(NSString *)url
{
    NSString *filePath = [[ATDataBaseManager atDocPath] stringByAppendingPathComponent:[url MD5String]];
    [UIImagePNGRepresentation(image) writeToFile:filePath atomically:YES];
}

- (void)writeImageData:(NSData *)imageData url:(NSString *)url
{
    NSString *filePath = [[ATDataBaseManager atDocPath] stringByAppendingPathComponent:[url MD5String]];
    [imageData writeToFile:filePath atomically:YES];
}

- (NSString *)filePathWithUrl:(NSString *)url
{
    return [[ATDataBaseManager atDocPath] stringByAppendingPathComponent:[url MD5String]];
}

-(UIImage *)readImage:(NSString *)fileName
{
    NSFileManager *fm = [NSFileManager defaultManager];
    NSString *str = PATH_IN_USER;
    if (![fm fileExistsAtPath:str isDirectory:NULL])
    {
        [fm createDirectoryAtPath:str
      withIntermediateDirectories:NO
                       attributes:nil
                            error:nil];
    }
    NSString *path = PATH_IN_IM_HEAD_DIR(fileName);
    NSData *reader = [NSData dataWithContentsOfFile:path];
    return [UIImage imageWithData:reader];
}

- (void)removeImage:(NSString *)fileName
{
    NSFileManager *fm = [NSFileManager defaultManager];
    NSString *str = PATH_IN_USER;
    if (![fm fileExistsAtPath:str isDirectory:NULL])
    {
        [fm createDirectoryAtPath:str
      withIntermediateDirectories:NO
                       attributes:nil
                            error:nil];
    }
    
    NSString *path = PATH_IN_IM_HEAD_DIR(fileName);
    
    if ([fm fileExistsAtPath:path isDirectory:NULL]) {
        [fm removeItemAtPath:path error:NULL];
    }
}


@end
