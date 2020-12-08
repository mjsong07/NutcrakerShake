//
//  AppTransferManager.m
//  TestR
//
//  Created by haiqin.wang on 14-5-12.
//  Copyright (c) 2014年 haiqin.wang. All rights reserved.
//

#import "ATAppTransferManager.h"
#import "CCDirector.h"

#import "ATDataBaseManager.h"
#import "NSString+ATAdditions.h"
#import "ATFileManager.h"

#import "ATRequest.h"

#define kSuccessStatus          1
#define kLastUpdateKey          @"kLastUpdateKey"

#define kServerAddress      @"http://rexshaw.java.myjhost.net/web/ajax/"
#define kGetAdListURI       @"appAdAjax_getAdList.action"
#define kClickAdURI         @"appAdAjax_clickAd.action"
#define kLoginURI           @"clientAjax_login.action"
#define kLogoutURI          @"clientAjax_logout.action"

static ATAppTransferManager *appTransferManager_;

@interface ATAppTransferManager ()
{
    UIView *transferView_;
    NSMutableArray *buttonArray_;
    
    ATDataBaseManager *dbManager_;
    ATFileManager *atFileManager_;
    NSUserDefaults *userDefaults_;
    
    NSDictionary *appDictionary_;
    NSArray *validAppArray_;
    BOOL needChangeInfo_;
    
    NSTimer *changeTimer_;
    
    BOOL needShowView_;
    CGPoint needShowViewWithPos_;
}

@property (nonatomic, copy) NSString *appId;
@property (nonatomic, retain) UIColor *backColor;
@property (nonatomic, retain) UIColor *borderColor;
@property (nonatomic) NSInteger appChangeInterval;

@property (nonatomic) BOOL isShowAd;
@property (nonatomic) BOOL isLoadSuccess;

@property (nonatomic, copy) ShowAppTransferFailure failureBlock;

@end

@implementation ATAppTransferManager

+ (ATAppTransferManager *)sharedTransfer
{
    if (appTransferManager_ == nil) {
        appTransferManager_ = [[ATAppTransferManager alloc] init];
    }
    return appTransferManager_;
}

+ (void)setAppId:(NSString *)appId
{
    [ATAppTransferManager sharedTransfer].appId = appId;
}

+ (void)setBackColor:(UIColor *)backColor
{
    [ATAppTransferManager sharedTransfer].backColor = backColor;
}

+ (void)setAppBorderColor:(UIColor *)borderColor
{
    [ATAppTransferManager sharedTransfer].borderColor = borderColor;
}

+ (void)setAppChangeInterval:(NSInteger)interval
{
    if (interval <= 0) {
        return;
    }
    [ATAppTransferManager sharedTransfer].appChangeInterval = interval;
}

+ (ATAppEntity *)appWithAppId:(NSString *)appId
{
    return [[ATAppTransferManager sharedTransfer] appWithAppId:appId];
}

+ (CCSprite *)spriteWithAppId:(NSString *)appId
{
    NSString *imageFile = [[ATAppTransferManager sharedTransfer] imageFilePathWithAppId:appId];
    if (imageFile == nil) {
        return nil;
    }
    UIImage *image = [UIImage imageWithContentsOfFile:imageFile];
    CCTexture2D *texture = [[CCTexture2D alloc] initWithCGImage:image.CGImage resolutionType:kCCResolutionUnknown];
    CCSprite *sprite = [CCSprite spriteWithTexture:texture];
    [texture release];
    return sprite;
}

+ (BOOL)isTransferViewShow
{
    return [ATAppTransferManager sharedTransfer].isShowAd;
}

+ (BOOL)isDataLoadSuccess
{
    return [ATAppTransferManager sharedTransfer].isLoadSuccess;
}

+ (void)showTransferViewWithPosition:(CGPoint)pos failure:(ShowAppTransferFailure)failure
{
    [ATAppTransferManager sharedTransfer].failureBlock = failure;
    [[ATAppTransferManager sharedTransfer] showTransferViewWithPosition:pos];
}

+ (void)showTransferViewWithPosition:(CGPoint)pos
{
    [[ATAppTransferManager sharedTransfer] showTransferViewWithPosition:pos];
}

+ (void)hideTransferView
{
    [[ATAppTransferManager sharedTransfer] hideTransferView];
}

- (void)dealloc
{
    [_appId release];
    [transferView_ release];
    [buttonArray_ release];
    
    [atFileManager_ release];
    
    [appDictionary_ release];
    [validAppArray_ release];
    
    [changeTimer_ invalidate];
    changeTimer_ = nil;
    
    [_backColor release];
    [_borderColor release];
    
    self.failureBlock = nil;
    
    [super dealloc];
}

- (id)init
{
    self = [super init];
    if (self) {
        self.isShowAd = YES;
        self.isLoadSuccess = YES;
        dbManager_ = [ATDataBaseManager sharedManager];
        atFileManager_ = [[ATFileManager alloc] init];
        userDefaults_ = [NSUserDefaults standardUserDefaults];
        
        self.backColor = [UIColor whiteColor];
        self.borderColor = [UIColor blackColor];
        self.appChangeInterval = 30;
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(appDidEnterBackground)
                                                     name:UIApplicationDidEnterBackgroundNotification
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(appWiilEnterForeground)
                                                     name:UIApplicationWillEnterForegroundNotification
                                                   object:nil];
    }
    return self;
}

- (void)setAppId:(NSString *)appId
{
    if (_appId == nil || (_appId != appId && [_appId isEqualToString:appId] == NO)) {
        [_appId release];
        _appId = nil;
        
        _appId = [appId retain];
        
        [self startLoginRequest];
    }
}

#pragma mark - Public Method

- (ATAppEntity *)appWithAppId:(NSString *)appId
{
    ATAppEntity *appEntity = [appDictionary_ objectForKey:appId];
    if (appEntity == nil) {
        return nil;
    }
    if ([atFileManager_ isFileExistWithUrl:appEntity.appImgUrl] == NO) {
        return nil;
    }
    return appEntity;
}

- (NSString *)imageFilePathWithAppId:(NSString *)appId
{
    ATAppEntity *appEntity = [appDictionary_ objectForKey:appId];
    if (appEntity == nil) {
        return nil;
    }
    if ([atFileManager_ isFileExistWithUrl:appEntity.appImgUrl] == NO) {
        return nil;
    }
    return [atFileManager_ filePathWithUrl:appEntity.appImgUrl];
}

- (void)showTransferViewWithPosition:(CGPoint)pos
{
    if (self.isShowAd == NO) {
        if (self.failureBlock != nil) {
            self.failureBlock();
            self.failureBlock = nil;
        }
        return;
    }
    
    if (transferView_ == nil) {
        [self setTransferView];
    }
    
    if (appDictionary_ == nil) {
        needShowView_ = YES;
        needShowViewWithPos_ = pos;
        return;
    }
    
    CGRect transferFrame = transferView_.frame;
    transferFrame.origin = pos;
    transferView_.frame = transferFrame;
    
    if ([transferView_ isHidden] == NO) {
        return;
    }
    
    if (validAppArray_.count != 0 && needChangeInfo_ == NO) {
        transferView_.hidden = NO;
        return;
    }
    
    [validAppArray_ release];
    validAppArray_ = [[NSArray alloc] initWithArray:[self findValidAppArray]];
    
    if (validAppArray_.count > 4) {
        needChangeInfo_ = YES;
    } else {
        needChangeInfo_ = NO;
        if (validAppArray_.count == 0) {
            self.isLoadSuccess = NO;
            if (self.failureBlock != nil) {
                self.failureBlock();
                self.failureBlock = nil;
            }
            return;
        }
    }
    self.isLoadSuccess = YES;
    
    for (int i = 0; i < buttonArray_.count; i++) {
        UIButton *appButton = [buttonArray_ objectAtIndex:i];
        if (validAppArray_.count > i) {
            ATAppEntity *appEntity = [validAppArray_ objectAtIndex:i];
            UIImage *appImage = [UIImage imageWithContentsOfFile:[self imageFilePathWithAppId:appEntity.appId]];
            [appButton setBackgroundImage:appImage
                                 forState:UIControlStateNormal];
            appButton.hidden = NO;
        } else {
            appButton.hidden = YES;
        }
    }
    transferView_.hidden = NO;
    
    if (needChangeInfo_ == YES) {
        [changeTimer_ invalidate];
        changeTimer_ = nil;
        changeTimer_ = [NSTimer scheduledTimerWithTimeInterval:_appChangeInterval
                                                        target:self
                                                      selector:@selector(changeInfo)
                                                      userInfo:nil
                                                       repeats:YES];
    }
}

- (void)hideTransferView
{
    transferView_.hidden = YES;
    
    [changeTimer_ invalidate];
    changeTimer_ = nil;
}

#pragma mark - Button Action

- (void)appButtonAction:(UIButton *)button
{
    NSInteger tag = button.tag;
    ATAppEntity *appEntity = [validAppArray_ objectAtIndex:tag];
    [self startClickAdRequst:appEntity.appId];
    
    NSString *scheme = [NSString stringWithFormat:@"AT%@://", appEntity.appId];
    BOOL canOpen = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:scheme]];
    if (canOpen == YES) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:scheme]];
    } else{
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:appEntity.downloadUrl]];
    }
    
    /* dummy 先不处理
    if (appEntity.isDummy == YES) {
        
    }
    */
}

#pragma mark - Notification Method

- (void)appDidEnterBackground
{
    CCLOG(@"app transfer enter background");
    [self startLogoutRequest];
}

- (void)appWiilEnterForeground
{
    CCLOG(@"app transfer enter foreground");
    [self startLoginRequest];
}

#pragma mark - Private Method

- (void)setTransferView
{
    transferView_ = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 50)];
    transferView_.backgroundColor = _backColor;
    
    [[CCDirector sharedDirector].view addSubview:transferView_];
    transferView_.hidden = YES;
    
    buttonArray_ = [[NSMutableArray alloc] initWithCapacity:4];
    for (int i = 0; i < 4; i++) {
        CGRect buttonRect = CGRectMake(26 * (i + 1) + 48 * i, 1, 48, 48);
        UIButton *appButton = [UIButton buttonWithType:UIButtonTypeCustom];
        appButton.frame = buttonRect;
        appButton.tag = i;
        appButton.layer.borderWidth = 1.0;
        appButton.layer.borderColor = _borderColor.CGColor;
        appButton.layer.cornerRadius = 5.0;
        appButton.layer.masksToBounds = YES;
        [appButton addTarget:self action:@selector(appButtonAction:) forControlEvents:UIControlEventTouchDown];
        [transferView_ addSubview:appButton];
        
        [buttonArray_ addObject:appButton];
    }
}

/*
 *  获得所有app信息
 */
- (void)cacheAllApp
{
    NSDictionary *dbDict = [dbManager_ dictionaryForAllApps];
    if (dbDict == nil) {
        // 数据库没有数据
        return;
    }
    
    // cache image
    // dummy 暂不处理
    NSArray *appArray = [dbDict allValues];
    
    /*
    // 异步下载
    for (ATAppEntity *appEntity in appArray) {
        if ([atFileManager_ isFileExistWithUrl:appEntity.appImgUrl] == NO) {
            // 图片未下载的, 下载保存到本地
            [ATRequest startImageRequestWithPath:appEntity.appImgUrl success:^(NSData *imageData) {
                [atFileManager_ writeImageData:imageData url:appEntity.appImgUrl];
            } failure:nil];
        }
    }
     */
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 另一线程内同步下载
        for (ATAppEntity *appEntity in appArray) {
            if ([atFileManager_ isFileExistWithUrl:appEntity.appImgUrl] == NO) {
                NSData *imageData = [ATRequest startSyncImageRequestWithPath:appEntity.appImgUrl];
                if (imageData != nil) {
                    [atFileManager_ writeImageData:imageData url:appEntity.appImgUrl];
                }
            }
        }
        // 全部下载完成后:
        dispatch_async(dispatch_get_main_queue(), ^{
            if (appDictionary_ == nil) {
                appDictionary_ = [[NSDictionary alloc] initWithDictionary:dbDict];
            }
            
            if (needShowView_ == YES) {
                needShowView_ = NO;
                [self showTransferViewWithPosition:needShowViewWithPos_];
            }
        });
    });
}

/*
 *  显示的app切换
 */
- (void)changeInfo
{
    CCLOG(@"change info");
    [UIView animateWithDuration:0.5 animations:^{
        for (UIButton *appButotn in buttonArray_) {
            appButotn.alpha = 0.0;
        }
    } completion:^(BOOL finished) {
        [validAppArray_ release];
        validAppArray_ = [[NSArray alloc] initWithArray:[self findValidAppArray]];
        
        for (int i = 0; i < buttonArray_.count; i++) {
            UIButton *appButton = [buttonArray_ objectAtIndex:i];
            ATAppEntity *appEntity = [validAppArray_ objectAtIndex:i];
            
            UIImage *appImage = [UIImage imageWithContentsOfFile:[self imageFilePathWithAppId:appEntity.appId]];
            [appButton setBackgroundImage:appImage forState:UIControlStateNormal];
            
            [UIView animateWithDuration:0.5 animations:^{
                appButton.alpha = 1.0;
            }];
        }
    }];
}

/*
 *  找到可以显示的app(图片已下载)
 */
- (NSArray *)findValidAppArray
{
    NSMutableArray *allInfoArray = [NSMutableArray arrayWithArray:[appDictionary_ allValues]];
    NSMutableArray *findInfoArray = [NSMutableArray arrayWithCapacity:5];
    while (allInfoArray.count > 0 && findInfoArray.count < 5) {
        NSInteger randIndex = arc4random() % allInfoArray.count;
        ATAppEntity *appEntity = [allInfoArray objectAtIndex:randIndex];
        if ([appEntity.appId isEqualToString:_appId] == NO &&
            appEntity.isShow == YES &&
            [atFileManager_ isFileExistWithUrl:appEntity.appImgUrl]) {
            [findInfoArray addObject:appEntity];
        }
        [allInfoArray removeObjectAtIndex:randIndex];
    }
    return findInfoArray;
}

- (NSString *)pathWithUri:(NSString *)uri
{
    return [NSString stringWithFormat:@"%@%@", kServerAddress, uri];
}

- (NSInteger)statusForDictionary:(NSDictionary *)dict
{
    return [[dict objectForKey:@"status"] description].integerValue;
}

#pragma mark - Request Method

- (NSDictionary *)commonParamDict
{
    NSArray *keyArray = [NSArray arrayWithObjects:
                         @"webServiceKey",
                         @"clientReqVO.appKey",
                         @"clientReqVO.clientKey",
                         @"clientReqVO.clientType",
                         @"clientReqVO.clientVersion",
                         @"clientReqVO.clientLang", nil];
    NSArray *objectArray = [NSArray arrayWithObjects:
                            @"qwe123",
                            _appId,
                            [NSString uniqueKey],
                            @"1",       // 1 iOS
                            [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString*)kCFBundleVersionKey],
                            [[NSLocale preferredLanguages] objectAtIndex:0], nil];
    
    return [NSDictionary dictionaryWithObjects:objectArray forKeys:keyArray];
}

- (void)startLoginRequest
{
    NSString *path = [self pathWithUri:kLoginURI];
    [ATRequest startPostRequestWithPath:path parameterDic:[self commonParamDict] success:^(id response) {
        NSDictionary *responseDict = (NSDictionary *)response;
        if ([self statusForDictionary:responseDict] == kSuccessStatus) {
            NSString *lastUpdate = [responseDict objectForKey:@"adLastUpdDate"];
            self.isShowAd = [[responseDict objectForKey:@"isShowAd"] description].boolValue;
            if ([[userDefaults_ objectForKey:kLastUpdateKey] isEqualToString:lastUpdate] == NO) {
                // 最新更新日期 与 记录日期不一致, 请求新数据
                [self startGetAdListRequest];
            } else {
                [self cacheAllApp];
            }
        } else {
            [self cacheAllApp];
        }
    } failure:^(NSError *error) {
        [self cacheAllApp];
    }];
}

- (void)startLogoutRequest
{
    NSString *path = [self pathWithUri:kLogoutURI];
    [ATRequest startPostRequestWithPath:path parameterDic:[self commonParamDict] success:nil failure:nil];
}

- (void)startGetAdListRequest
{
    NSString *path = [self pathWithUri:kGetAdListURI];
    [ATRequest startPostRequestWithPath:path parameterDic:[self commonParamDict] success:^(id response) {
        NSDictionary *responseDict = (NSDictionary *)response;
        if ([self statusForDictionary:responseDict] == kSuccessStatus) {
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                NSString *lastUpdate = [responseDict objectForKey:@"adLastUpdDate"];
                [userDefaults_ setObject:lastUpdate forKey:kLastUpdateKey];
                [userDefaults_ synchronize];
                
                [dbManager_ deleteAllApp];
                
                NSArray *adListArray = [responseDict objectForKey:@"adList"];
                if (adListArray != nil && adListArray.count > 0) {
                    NSMutableArray *appArray = [[NSMutableArray alloc] initWithCapacity:adListArray.count];
                    for (NSDictionary *dict in adListArray) {
                        ATAppEntity *appEntity = [[ATAppEntity alloc] initWithDictionary:dict];
                        [appArray addObject:appEntity];
                        [appEntity release];
                    }
                    [dbManager_ insertOrUpdateApps:appArray];
                    [appArray release];
                }
                
                [self cacheAllApp];
            });
        } else {
            [self cacheAllApp];
        }
    } failure:^(NSError *error) {
        [self cacheAllApp];
    }];
}

- (void)startClickAdRequst:(NSString *)appId
{
    NSString *path = [self pathWithUri:kClickAdURI];
    
    NSMutableDictionary *paramDict = [NSMutableDictionary dictionaryWithDictionary:[self commonParamDict]];
    [paramDict setObject:appId forKey:@"clientReqVO.clickAppKey"];
    
    [ATRequest startPostRequestWithPath:path parameterDic:paramDict success:nil failure:nil];
}

@end
