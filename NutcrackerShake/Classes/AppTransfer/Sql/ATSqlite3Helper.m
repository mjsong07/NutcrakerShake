//
//  Sqlite3Helper.m
//  TFTFramework
//
//  Confidential
//

#import "ATSqlite3Helper.h"


@implementation ATSqlite3Helper

@synthesize fileName;


#pragma mark -
#pragma mark Initialization

/**
 *  @brief  データベースのアクセスを初期化する
 */
- (id)initWithFileName:(NSString *)name {
	if (self = [super init]) {
		self.fileName = name;
	}
	return self;
}


#pragma mark -
#pragma mark Operator methods

/**
 *  @brief  トランザクションを始める
 */
- (BOOL)beginTransaction {
	if (sqlite3_exec(db, "BEGIN", 0, 0, 0) == SQLITE_OK) {
		return YES;
	}
	return NO;
}

/**
 *  @brief  トランザクションをコミットする
 */
- (BOOL)commit {
	if (sqlite3_exec(db, "COMMIT", 0, 0, 0) == SQLITE_OK) {
		return YES;
	}
	return NO;
}

/**
 *  @brief  トランザクションをロールバックする
 */
- (BOOL)rollback {
	if (sqlite3_exec(db, "ROLLBACK", 0, 0, 0) == SQLITE_OK) {
		return YES;
	}
	return NO;
}

/**
 *  @brief  データベースを開ける
 */
- (BOOL)openDatabase {
	if (sqlite3_open([fileName UTF8String], &db) == SQLITE_OK) {
		return YES;
	}
	return NO;
}

/**
 *  @brief  sqlステートメントを準備する
 */
- (BOOL)prepare:(NSString *)sql {
	if (sqlite3_prepare_v2(db, [sql UTF8String], -1, &stmt, NULL) == SQLITE_OK) {
		return YES;
	}
	return NO;
}

/**
 *  @brief  今まで全部の操作をリセットする
 */
- (BOOL)reset {
	if (sqlite3_reset(stmt) == SQLITE_OK) {
		return YES;
	}
	return NO;
}

/**
 *  @brief  今までsqlステートメントでバインドされたインデックスをクリアする
 */
- (BOOL)clearBinds {
	if (sqlite3_clear_bindings(stmt) == SQLITE_OK) {
		return YES;
	}
	return NO;
}

/**
 *  @brief  テキスト内容を今までsqlステートメントにバインドする
 */
- (BOOL)bindText:(NSString *)param index:(NSUInteger)index {
	if (sqlite3_bind_text(stmt, index, [param UTF8String], -1, SQLITE_TRANSIENT) == SQLITE_OK) {
		return YES;
	}
	return NO;
}

/**
 *  @brief  数字内容を今までsqlステートメントにバインドする
 */
- (BOOL)bindInt:(NSUInteger)param index:(NSUInteger)index {
	if (sqlite3_bind_int(stmt, index, param) == SQLITE_OK) {
		return YES;
	}
	return NO;
}

/**
 *  @brief  バイナリデータ内容を今までsqlステートメントにバインドする
 */
- (BOOL)bindBlob:(NSData *)param index:(NSUInteger)index {
	if (sqlite3_bind_blob(stmt, index, [param bytes], [param length], NULL) == SQLITE_OK) {
		return YES;
	}
	return NO;
}

/**
 *  @brief  今までsqlステートメントを実行する
 */
- (BOOL)execute {
	if (sqlite3_step(stmt) == SQLITE_DONE) {
		return YES;
	}
	return NO;
}

/**
 *  @brief  sqlステートメントの実行した毎行の結果を取る
 */
- (BOOL)fetch {
	if (sqlite3_step(stmt) == SQLITE_ROW) {
		return YES;
	}
	return NO;
}

/**
 *  @brief  結果中の指定したインデックスの文字バリュー を取る
 */
- (NSString *)resultText:(NSUInteger)index {
	char *text = (char *)sqlite3_column_text(stmt, index);
	if (text != nil) {
		return [NSString stringWithUTF8String:text];
	}
	return nil;
}

/**
 *  @brief  結果中の指定したインデックスの数字バリュー を取る
 */
- (NSUInteger)resultInt:(NSUInteger)index {
	return sqlite3_column_int(stmt, index); 
}

/**
 *  @brief  結果中の指定したインデックスのバイナリバリュー を取る
 */
- (NSData *)resultBolb:(NSUInteger)index {
	NSUInteger bytesLength = sqlite3_column_bytes(stmt, index);
	return [NSData dataWithBytes:sqlite3_column_blob(stmt, index) length:bytesLength]; 
}

/**
 *  @brief  最後でインサートした行の番号を取る
 */
- (NSUInteger)lastInsertRowID {
	sqlite3_int64 rowid = sqlite3_last_insert_rowid(db);
	return [[NSNumber numberWithLongLong:rowid] unsignedIntValue];
}

/**
 *  @brief  stmtを完成させる
 */
- (BOOL)finalizeStmt {
	if (sqlite3_finalize(stmt) == SQLITE_OK) {
		return YES;
	}
	return NO;
}

/**
 *  @brief  データベースをクローズする
 */
- (BOOL)closeDatabase {
	if (sqlite3_close(db) == SQLITE_OK) {
		return YES;
	}
	return NO;
}


#pragma mark -
#pragma mark Memory management

- (void)dealloc {
	[fileName release];
	fileName = nil;
	
	[super dealloc];
}

@end
