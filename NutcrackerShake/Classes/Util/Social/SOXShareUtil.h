//
//  SOXMapUtil.h
//  SoxFrame
//
//  Created by jason yang on 13-5-27.
//
//

#import <Foundation/Foundation.h> 


#import <Social/Social.h>
#import <Accounts/Accounts.h>
@interface SOXShareUtil : NSObject
+ (void)showSharePage: (NSString*)shareType :(NSString*)content :(UIViewController*) baseRootView;

+ (bool)chkIsSetAccount: (NSString*)shareType;

@end
