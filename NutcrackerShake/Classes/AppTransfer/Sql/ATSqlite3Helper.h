//
//  Sqlite3Helper.h
//  TFTFramework
//
//  Confidential
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

/**
 *  @brief  sqlite3の マネージャー
 */
@interface ATSqlite3Helper : NSObject
{
	NSString *fileName;
	
	sqlite3 *db;
	sqlite3_stmt *stmt;
}

@property (nonatomic, retain) NSString *fileName;

- (id)initWithFileName:(NSString *)name;

- (BOOL)openDatabase;
- (BOOL)closeDatabase;

- (BOOL)beginTransaction;
- (BOOL)commit;
- (BOOL)rollback;

- (BOOL)prepare:(NSString *)sql;
- (BOOL)execute;
- (BOOL)fetch;
- (BOOL)finalizeStmt;

- (BOOL)bindText:(NSString *)param index:(NSUInteger)index;
- (BOOL)bindInt:(NSUInteger)param index:(NSUInteger)index;
- (BOOL)bindBlob:(NSData *)param index:(NSUInteger)index;

- (NSString *)resultText:(NSUInteger)index;
- (NSUInteger)resultInt:(NSUInteger)index;
- (NSData *)resultBolb:(NSUInteger)index;

- (NSUInteger)lastInsertRowID;

@end
