//
//  SOXMapUtil.h
//  SoxFrame
//
//  Created by jason yang on 13-5-27.
//
//

#import <Foundation/Foundation.h> 

@interface SOXMenuUtil : NSObject

+ (SOXMenuUtil*) sharedMenuUtil ;
- (CCMenu*)init:(id)imgUrl target:(id)target selector:(SEL)selector;
@end
