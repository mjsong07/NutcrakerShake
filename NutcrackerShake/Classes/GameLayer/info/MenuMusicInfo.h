//
//  MenuLayer.h
//  SoxFrame
//
//  Created by jason yang on 13-5-9.
//
// 

@interface MenuMusicInfo : BaseSprite{
    CCSprite *music_ ;
    CCSprite *musicStop_ ;
}
@property SoundType  soundType;//当前默认设置的声音

- (id)init:(SoundType)soundType;//

- (void)setAllColor:(ccColor3B)color;


- (CGFloat)getWidth;


- (CGFloat)getHeight;

@end
