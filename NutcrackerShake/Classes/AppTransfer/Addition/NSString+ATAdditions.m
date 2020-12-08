//
//  NSString+ATAdditions.m
//  TestR
//
//  Created by haiqin.wang on 14-6-4.
//  Copyright (c) 2014年 haiqin.wang. All rights reserved.
//

#import "NSString+ATAdditions.h"
#import <CommonCrypto/CommonDigest.h>
#include <sys/socket.h>
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>

@implementation NSString (ATAdditions)

/**
 * @brief 设备唯一值
 */
+ (NSString *)uniqueKey
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.1) {
        return [UIDevice currentDevice].identifierForVendor.UUIDString;
    }
    
    int                 mgmtInfoBase[6];
    char                *msgBuffer = NULL;
    size_t              length;
    unsigned char       macAddress[6];
    struct if_msghdr    *interfaceMsgStruct;
    struct sockaddr_dl  *socketStruct;
    NSString            *errorFlag = NULL;
    
    // Setup the management Information Base (mib)
    mgmtInfoBase[0] = CTL_NET;        // Request network subsystem
    mgmtInfoBase[1] = AF_ROUTE;       // Routing table info
    mgmtInfoBase[2] = 0;
    mgmtInfoBase[3] = AF_LINK;        // Request link layer information
    mgmtInfoBase[4] = NET_RT_IFLIST;  // Request all configured interfaces
    
    // With all configured interfaces requested, get handle index
    if ((mgmtInfoBase[5] = if_nametoindex("en0")) == 0)
        errorFlag = @"if_nametoindex failure";
    else {
        // Get the size of the data available (store in len)
        if (sysctl(mgmtInfoBase, 6, NULL, &length, NULL, 0) < 0)
            errorFlag = @"sysctl mgmtInfoBase failure";
        else {
            // Alloc memory based on above call
            if ((msgBuffer = malloc(length)) == NULL)
                errorFlag = @"buffer allocation failure";
            else {
                // Get system information, store in buffer
                if (sysctl(mgmtInfoBase, 6, msgBuffer, &length, NULL, 0) < 0)
                    errorFlag = @"sysctl msgBuffer failure";
                //                else
                //errorFlag = @"";
            }
        }
    }
    
    if (errorFlag != NULL) {
        free(msgBuffer);
        return errorFlag;
    }
    
    // Map msgbuffer to interface message structure
    interfaceMsgStruct = (struct if_msghdr *) msgBuffer;
    
    // Map to link-level socket structure
    socketStruct = (struct sockaddr_dl *) (interfaceMsgStruct + 1);
    
    // Copy link layer address data in socket structure to an array
    memcpy(&macAddress, socketStruct->sdl_data + socketStruct->sdl_nlen, 6);
    
    // Read from char array into a string object, into traditional Mac address format
    NSString *macAddressString = [NSString stringWithFormat:@"%02X:%02X:%02X:%02X:%02X:%02X",
                                  macAddress[0], macAddress[1], macAddress[2],
                                  macAddress[3], macAddress[4], macAddress[5]];
    
    free(msgBuffer);
    
    return macAddressString;
}

/**
 *  @brief  URLに使えない文字コードをエスケープする
 *  @return NSString エスケープした文字列
 */
- (NSString *)stringURIEncoding {
	return [((NSString* )CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
																 (CFStringRef)self,
																 NULL,
																 (CFStringRef)@"!*'();:@&=+$,/?%#[]",
																 kCFStringEncodingUTF8)) autorelease];
}

/**
 *  @brief  MD5暗号化
 */
- (NSString *)MD5String {
	const char *cStr = [self UTF8String];
	unsigned char digest[CC_MD5_DIGEST_LENGTH];
	CC_MD5(cStr, strlen(cStr), digest);
	char md5string[CC_MD5_DIGEST_LENGTH*2];
	int i;
	for(i=0; i<CC_MD5_DIGEST_LENGTH; i++) {
		sprintf(md5string+i*2, "%02X", digest[i]);
	}
	return [[NSString stringWithCString:md5string encoding:NSUTF8StringEncoding] lowercaseString];
}

@end
