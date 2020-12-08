//
//  DataBaseManager.m
//  InstantNews
//
//  Confidential
//

#import "ATDataBaseManager.h"
#import "ATSqlite3Helper.h"
#import "ATAppEntity.h"
#import "NSString+ATAdditions.h"

#import "ATConfig.h"

@interface ATDataBaseManager ()
{
    ATSqlite3Helper *sqlite3Helper_;
}

@end

static ATDataBaseManager *dbManager_;

@implementation ATDataBaseManager

+ (ATDataBaseManager *)sharedManager
{
    if (dbManager_ == nil) {
        dbManager_ = [[ATDataBaseManager alloc] init];
    }
    return dbManager_;
}

+ (NSString *)atDocPath
{
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *atDocPath = [docPath stringByAppendingPathComponent:kDocFileName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:atDocPath] == NO) {
        [fileManager createDirectoryAtPath:atDocPath
               withIntermediateDirectories:NO
                                attributes:nil
                                     error:nil];
    }
    return atDocPath;
}

+ (NSString *)databasePath
{
    static NSString *path = nil;
    if (path == nil) {
        NSString *atDocPath = [self atDocPath];
        NSString *databaseResourcePath = [atDocPath stringByAppendingPathComponent:kDatabaseFileName];
        path = databaseResourcePath;
        LOG(@"db path:%@", path);
    }
    return path;
}

+ (void)createDb
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:[self databasePath]] == NO) {
        NSString *resourcePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:kDatabaseFileName];
        [fileManager copyItemAtPath:resourcePath toPath:[self databasePath] error:nil];
    }
}

- (id)init
{
    self = [super init];
    if (self) {
        [ATDataBaseManager createDb];
        sqlite3Helper_ = [[ATSqlite3Helper alloc] initWithFileName:[[self class] databasePath]];
    }
    return self;
}

#pragma mark - Base Operation

- (void)openDatabase
{
    [sqlite3Helper_ openDatabase];
}

- (void)closeDatabase
{
    [sqlite3Helper_ closeDatabase];
}

- (BOOL)beginTransaction
{
	return [sqlite3Helper_ beginTransaction];
}

- (BOOL)commit
{
    return [sqlite3Helper_ commit];
}

- (BOOL)rollback
{
    return [sqlite3Helper_ rollback];
}

/**
 *  @brief  没有数据则插入新数据
 */
- (BOOL)insertOrUpdateApps:(NSArray *)appArray
{
    [self openDatabase];
    BOOL succeed = YES;
    if (appArray == nil || appArray.count == 0) {
        return succeed;
    }

    @autoreleasepool {
        NSDictionary *appIdDictionary = [self appIdDictionaryFromDatabase];
        
        NSString *sql = @"insert into t_app_info (appId,appName,imgUrl,appUrl,isShow,isDummy,dummyName,dummyImgUrl) values(?,?,?,?,?,?,?,?)";
        for (ATAppEntity *appEntity in appArray) {
            if ([appIdDictionary objectForKey:appEntity.appId] == NO) {
                // insert
                succeed = succeed & [sqlite3Helper_ prepare:sql];
                [sqlite3Helper_ bindText:appEntity.appId index:1];
                [sqlite3Helper_ bindText:appEntity.appName index:2];
                [sqlite3Helper_ bindText:appEntity.appImgUrl index:3];
                [sqlite3Helper_ bindText:appEntity.downloadUrl index:4];
                [sqlite3Helper_ bindInt:appEntity.isShow index:5];
                [sqlite3Helper_ bindInt:appEntity.isDummy index:6];
                if (appEntity.isDummy == YES) {
                    [sqlite3Helper_ bindText:appEntity.dummyName index:7];
                    [sqlite3Helper_ bindText:appEntity.dummyImgUrl index:8];
                } else {
                    [sqlite3Helper_ bindText:@"" index:7];
                    [sqlite3Helper_ bindText:@"" index:8];
                }
                
                succeed = succeed & [sqlite3Helper_ execute];
                succeed = succeed & [sqlite3Helper_ finalizeStmt];
            } else {
                // update
                NSInteger isShow = [NSNumber numberWithBool:appEntity.isShow].integerValue;
                NSInteger isDummy = [NSNumber numberWithBool:appEntity.isDummy].integerValue;
                NSString *dummyName = @"";
                NSString *dummyImgUrl = @"";
                if (appEntity.isDummy == YES) {
                    dummyName = appEntity.appName;
                    dummyImgUrl = appEntity.dummyImgUrl;
                }
                NSString *sql = [NSString stringWithFormat:@"update t_app_info set \
                                 appName=%@,imgUrl=%@,appUrl=%@,isShow='%d',isDummy='%d',dummyName=%@,dummyImgUrl=%@ where appId=%@",
                                 appEntity.appName, appEntity.appImgUrl, appEntity.downloadUrl,
                                 isShow, isDummy, dummyName, dummyImgUrl,
                                 appEntity.appId];
                
                succeed = succeed & [sqlite3Helper_ prepare:sql];
                succeed = succeed & [sqlite3Helper_ execute];
                succeed = succeed & [sqlite3Helper_ finalizeStmt];
            }
            if (succeed == NO) {
                break;
            }
        }
    }
    
    [self closeDatabase];
    return succeed;
}

/**
 *  @brief  更新数据
 */
/*
- (BOOL)updateApp:(ATAppEntity *)appEntity
{
    [self openDatabase];
    BOOL succeed = YES;
    if (appEntity == nil) {
        return succeed;
    }
    
    NSInteger isDummy = [NSNumber numberWithBool:appEntity.isDummy].integerValue;
    NSString *dummyName = @"";
    NSString *dummyImgUrl = @"";
    if (appEntity.isDummy == YES) {
        dummyName = appEntity.appName;
        dummyImgUrl = appEntity.dummyImgUrl;
    }
    NSString *sql = [NSString stringWithFormat:@"update t_app_info set \
                     appName=%@,imgUrl=%@,appUrl=%@,isDummy='%d',dummyName=%@,dummyImgUrl=%@ where appId=%@",
                     appEntity.appName, appEntity.appImgUrl, appEntity.downloadUrl,
                     isDummy, dummyName, dummyImgUrl,
                     appEntity.appId];

    succeed = succeed & [sqlite3Helper_ prepare:sql];
    succeed = succeed & [sqlite3Helper_ execute];
    succeed = succeed & [sqlite3Helper_ finalizeStmt];
    
    [self closeDatabase];
    return succeed;
}
*/

/**
 *  @brief  读取数据
 */
- (NSDictionary *)dictionaryForAllApps
{
    [self openDatabase];
    NSMutableDictionary *appDictionary = [NSMutableDictionary dictionaryWithCapacity:1];
    NSString *sql = @"select appId,appName,imgUrl,appUrl,isShow,isDummy,dummyName,dummyImgUrl from t_app_info";
    
    BOOL succeed = [sqlite3Helper_ prepare:sql];
    while ([sqlite3Helper_ fetch]) {
        ATAppEntity *appEntity = [[ATAppEntity alloc] init];
        appEntity.appId = [sqlite3Helper_ resultText:0];
        appEntity.appName = [sqlite3Helper_ resultText:1];
        appEntity.appImgUrl = [sqlite3Helper_ resultText:2];
        appEntity.downloadUrl = [sqlite3Helper_ resultText:3];
        appEntity.isShow = [NSNumber numberWithInt:[sqlite3Helper_ resultInt:4]].boolValue;
        appEntity.isDummy = [NSNumber numberWithInt:[sqlite3Helper_ resultInt:5]].boolValue;
        if (appEntity.isDummy == YES) {
            appEntity.dummyName = [sqlite3Helper_ resultText:6];
            appEntity.dummyImgUrl = [sqlite3Helper_ resultText:7];
        }
        
        [appDictionary setObject:appEntity forKey:appEntity.appId];
        [appEntity release];
    }
    succeed = succeed & [sqlite3Helper_ finalizeStmt];
    [self closeDatabase];
    
    if (succeed == NO) {
        return nil;
    }
    if (appDictionary.count == 0) {
        return nil;
    }
    return appDictionary;
}

/**
 *  @brief  取出数据库中的rssId写入dictionary (用于写入时判断是否包含此数据)
 */
- (NSDictionary *)appIdDictionaryFromDatabase
{
    NSMutableDictionary *appIdDictionary = [NSMutableDictionary dictionaryWithCapacity:2000];
    NSString *sql = @"select appId from t_app_info";
    [sqlite3Helper_ prepare:sql];
    while ([sqlite3Helper_ fetch]) {
        NSString *appId = [sqlite3Helper_ resultText:0];
        [appIdDictionary setObject:appId forKey:appId];
    }
    [sqlite3Helper_ finalizeStmt];
    return appIdDictionary;
}

/**
 *  @brief  删除数据
 */
- (BOOL)deleteAllApp
{
    [self openDatabase];
    BOOL succeed = YES;
    NSString *sql = @"delete from t_app_info";
    succeed = succeed & [sqlite3Helper_ prepare:sql];
    succeed = succeed & [sqlite3Helper_ execute];
    succeed = succeed & [sqlite3Helper_ finalizeStmt];
    [self closeDatabase];
    return succeed;
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/**
 *  @brief  删除过期数据
 */
/*
- (BOOL)deleteExpiredData
{
    NSString *dateString = [self dateStringWithDate:[NSDate date] fromat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *sql = [NSString stringWithFormat:@"delete from t_news where (julianday('%@') - julianday(publishDate) > %f);", dateString, kRemoveDataDayInterval];
    [sqlite3Helper_ prepare:sql];
    BOOL succeed = [sqlite3Helper_ execute];
    succeed = succeed & [sqlite3Helper_ finalizeStmt];
    return succeed;
}
*/

#pragma mark - Private Method

/**
 *  @brief  判断是否有数据
 */
/*
- (BOOL)isItemExistsWithTable:(NSString *)tableName itemName:(NSString *)itemName itemValue:(NSString *)itemID
{
    NSString *sql = [NSString stringWithFormat:@"select count(1) from %@ where %@=?;", tableName, itemName];
    [sqlite3Helper_ prepare:sql];
    [sqlite3Helper_ bindText:itemID index:1];
    
    BOOL isExists = NO;
    if ([sqlite3Helper_ fetch]) {
        isExists = [sqlite3Helper_ resultInt:0];
    }
    [sqlite3Helper_ finalizeStmt];
    return isExists;
}
 */

@end
