//
//  DataBaseManager.h
//  InstantNews
//
//  Confidential
//

#import <Foundation/Foundation.h>
#import "ATAppEntity.h"

@interface ATDataBaseManager : NSObject

+ (ATDataBaseManager *)sharedManager;
+ (NSString *)atDocPath;
+ (NSString *)databasePath;

- (void)openDatabase;
- (void)closeDatabase;

- (BOOL)beginTransaction;
- (BOOL)commit;
- (BOOL)rollback;

- (BOOL)insertOrUpdateApps:(NSArray *)appInfosArray;
//- (BOOL)updateApp:(ATAppEntity *)appInfoEntity;
- (NSDictionary *)dictionaryForAllApps;
- (BOOL)deleteAllApp;

@end
