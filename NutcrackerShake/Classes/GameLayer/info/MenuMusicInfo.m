//
//  MenuLayer.m
//  SoxFrame
//
//  Created by jason yang on 13-5-9.
//
//

#import "MenuMusicInfo.h"

@implementation MenuMusicInfo
 
- (id)init:(SoundType)soundType
{
	self = [super init];
	if (self) {
        [CCMenuItemFont setFontSize:getRS(16)];
        self.soundType = soundType;
        music_ = [CCSprite spriteWithFile:@"menu_music.png" ];
        musicStop_ = [CCSprite spriteWithFile:@"menu_music_stop.png" ];
        
        
        music_.color = ccSOX_BTN_BASE;
        musicStop_.color = ccSOX_BTN_BASE;
        CCMenuItemSprite *itemMusic =  [ CCMenuItemSprite itemWithNormalSprite:music_ selectedSprite:nil
                                                                        target:self selector:nil ];
        CCMenuItemSprite *itemMusicStop =  [ CCMenuItemSprite itemWithNormalSprite:musicStop_
                                                                    selectedSprite:nil
                                                                            target:self
                                                                          selector:nil ];
        CCMenuItemToggle *itemMusicToggle = [CCMenuItemToggle itemWithTarget:self
                                                                    selector:@selector(musicCallback:)
                                                                       items: itemMusicStop ,itemMusic , nil];
        
        [SOXDBUtil initInfoByMenuItem:itemMusicToggle :G_KEY_SOUND];
        CCMenu *smallMenu = [CCMenu menuWithItems: itemMusicToggle,nil];
        smallMenu.position = CGPointMake(0, 0);
        [smallMenu alignItemsHorizontally];
        [smallMenu alignItemsHorizontallyWithPadding:2]; 
        [self addChild: smallMenu z:1 tag:2 ];

	}
	return self;
}

//设置 声音
- (void)musicCallback: (id) sender
{
    int nowSelected =[sender selectedIndex];
    //同时 设置 全局得 变量值
    [SOXDBUtil saveInfo:G_KEY_SOUND : [SOXUtil intToString:nowSelected]];
    //打开 按钮声
   if( nowSelected == 0){
        [[SOXConfig sharedConfig] setIsOpenSound:false];
        [SOXSoundUtil pause_BackgroundMusic];
    }else{
        [[SOXConfig sharedConfig] setIsOpenSound:true];
        [SOXSoundUtil play_btn];
        [SOXSoundUtil play_GameBackgroundMusic];
    }
    /*
    NSString *strLoading =   NSLocalizedString(@"GameName", @"");
     UIImage *image= [SOXGameUtil makeaShot];
    [WechatShareManager showShareComponentWithText:strLoading image:image urlString:G_KEY_SOX_NUTCRACKER_URL];*/
}



- (CGFloat)getWidth{
    return music_.contentSize.width;
}

- (CGFloat)getHeight{
    return music_.contentSize.height;
}

- (void)setAllColor:(ccColor3B)color
{
    [music_ setColor:color];
    [musicStop_ setColor:color];
}
@end
