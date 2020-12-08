//
//  InAppRageIAPHelper.m
//  InAppRage
//
//  Created by Ray Wenderlich on 2/28/11.
//  Copyright 2011 Ray Wenderlich. All rights reserved.
//

#import "InAppRageIAPHelper.h"

@implementation InAppRageIAPHelper

static InAppRageIAPHelper * _sharedHelper;

+ (InAppRageIAPHelper *) sharedHelper {
    
    if (_sharedHelper != nil) {
        return _sharedHelper;
    }
    _sharedHelper = [[InAppRageIAPHelper alloc] init];
    return _sharedHelper;
    
}

- (id)init {
    
    NSSet *productIdentifiers = [NSSet setWithObjects:
        G_KEY_PURCHASES_STAR_099,
        G_KEY_PURCHASES_STAR_199, 
        nil];
    
    if ((self = [super initWithProductIdentifiers:productIdentifiers])) {                
        
    }
    return self;
    
}

@end
