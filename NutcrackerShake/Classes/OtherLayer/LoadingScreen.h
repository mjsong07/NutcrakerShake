//
//  LoadingScreen.h
//
//  Created by Six Foot Three Foot on 28/05/12.
//  Copyright 2012 Six Foot Three Foot. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface LoadingScreen : CCLayer {
    CCProgressTimer *progress;
    float           progressInterval;
    int             assetCount;
    
    //设备类型
    int deviceType;
}
+(CCScene *) scene;


/** Called if there are any sfx to load, it loads the files one by one via the NSArray */
-(void) loadSounds:(NSArray *) soundClips;

/** Called if there are any Sprite Sheets to load, it loads the files one by one via the NSArray */
-(void) loadSpriteFrameCache:(NSArray *) spriteSheets;

/** Called if there are any images to load, it loads the files one by one via the NSArray.
 Images can be a cache of backgrounds or anything else.  You can add to this method
 to have it do whatever you want with the list.
 */
-(void) loadImages:(NSArray *) images;
 

/** updates the progress bar with the next step.  When progress bar reaches 100%
 It calls loadingComplete which can change scenes, or do anything else you wish.
 */
-(void) progressUpdate;

/** Called by progressUpdate when all assets are loaded from the manifest. */
-(void) loadingComplete;
@end
