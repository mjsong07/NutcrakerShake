//
//  SOXMapUtil.m
//  SoxFrame
//
//  Created by jason yang on 13-5-27.
//
//

#import "SOXEncryption.H"
#import "Encryption.h"
@implementation SOXEncryption

//加密
+ (NSData*)Encrypt: (NSString*)val{   
    NSData *data = [val dataUsingEncoding:NSUTF8StringEncoding];
    NSData *dataAES = [data AES256EncryptWithKey:G_KEY_DB];
    [[dataAES newStringInBase64FromData] autorelease];
    return dataAES; 
}
//解密
+ (NSString*)Decrypt: (NSData*)val{ 
    NSData *data = [val AES256DecryptWithKey:G_KEY_DB];
    NSString *str =[[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
    return str; 
}


@end
