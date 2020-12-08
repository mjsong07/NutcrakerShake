//
//  SOXMapUtil.h
//  SoxFrame
//
//  Created by jason yang on 13-5-27.
//
//

#import <Foundation/Foundation.h>
 
@interface SOXEncryption : NSObject
+ (NSData*)Encrypt: (NSString*)val;
+ (NSString*)Decrypt: (NSData*)val;

@end
