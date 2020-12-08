//
//  ATConfig.h
//  TestR
//
//  Created by haiqin.wang on 14-6-4.
//  Copyright (c) 2014年 haiqin.wang. All rights reserved.
//

#ifndef TestR_ATConfig_h
#define TestR_ATConfig_h

#ifdef DEBUG
#define LOG(...) NSLog(__VA_ARGS__)
#else
#define LOG(...)
#endif

#define kRemoveDataDayInterval      2592000     // (3600 * 24 * 30.0)
#define kDocFileName                @".ATAppTransfer"
#define kDatabaseFileName           @"ATAppTransfer.sqlite3"

#endif
