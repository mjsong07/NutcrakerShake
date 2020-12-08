//
//  MenuLayer.m
//  SoxFrame
//
//  Created by jason yang on 14-02-26
//  已废弃
//

#import "MenuShareInfo.h"  

#import "Reachability.h"
#import "MBProgressHUD.h"
#import "GameHelper.h"
#import "ScoreLayer.h"

@implementation MenuShareInfo



- (void)setTouchEnabled:(bool)bol{
  CCMenu *shareMenu =  (CCMenu*)[self getChildByTag:1];
    if(shareMenu !=nil){
        [shareMenu setTouchEnabled:bol];
    }
}
- (id)init
{
	self = [super init];
	if (self) {
        [CCMenuItemFont setFontSize:getRS(16)];
        CCSprite *facebookImg = [CCSprite spriteWithFile:@"menu_share_facebook.png" ];
        CCSprite *twitterImg = [CCSprite spriteWithFile:@"menu_share_twitter.png" ];
        CCSprite *weiboImg = [CCSprite spriteWithFile:@"menu_share_weibo.png" ];
        
        
        facebookImg.color = ccSOX_BTN_BASE;
        twitterImg.color = ccSOX_BTN_BASE;
        weiboImg.color = ccSOX_BTN_BASE;
        
        CCMenuItemSprite *itemFacebook =  [ CCMenuItemSprite itemWithNormalSprite:facebookImg selectedSprite:nil
                                                                           target:self selector:@selector(toFacebook:) ];
        
        CCMenuItemSprite *itemTwitter =  [ CCMenuItemSprite itemWithNormalSprite:twitterImg selectedSprite:nil
                                                                          target:self selector:@selector(toTwitter:) ];
        CCMenuItemSprite *itemWeibo =  [ CCMenuItemSprite itemWithNormalSprite:weiboImg selectedSprite:nil
                                                                        target:self selector:@selector(toWeibo:) ];
        
        CCMenu *shareMenu = [CCMenu menuWithItems:itemFacebook, itemTwitter,itemWeibo,nil];  
        [shareMenu alignItemsHorizontallyWithPadding:2];
        [shareMenu alignItemsHorizontally];
        shareMenu.position = ccp(0,0); 
        [self addChild: shareMenu z:1 tag:1 ];
        
        self.reach = [Reachability reachabilityForInternetConnection];
        self.netStatus = [self.reach currentReachabilityStatus];
        self.nowSelected = SLServiceTypeTwitter;
	}
	return self;
}


- (void)dismissHUD:(id)arg { 
    _hud.removeFromSuperViewOnHide = YES;
    [_hud hide:YES];
    self.hud = nil;
}
//用于提示框
- (void)showHuDByStr:(NSString*)title :(NSString*)message :(double)delay {
    self.hud= [MBProgressHUD showHUDAddedTo:[SOXGameUtil getBaseRootView].view animated:YES];
    _hud.labelText = title;
    _hud.detailsLabelText = message;
    [self performSelector:@selector(dismissHUD:) withObject:nil afterDelay:delay];
}

- (NSString*)getShowScore 
{
    double  score = [[GameHelper getScoreLayer]nowScore ] ;
    if( score<=0){
      // showScore_ =@"I playing the Game!";//
         NSString *shareContent =NSLocalizedString(@"shareContent", @"");
         showScore_ = shareContent;
    }else{
        NSString *shareScoreContent =NSLocalizedString(@"shareScoreContent", @"");
        NSString *shareScoreContentBy =NSLocalizedString(@"shareScoreContentBy", @"");
        NSString *strScore =[SOXUtil notRounding:score afterPoint:0];
        showScore_ = [NSString  stringWithFormat:@"%@ %@ %@!",shareScoreContent,strScore,shareScoreContentBy];
    }
    return showScore_; 
}

- (void)toCommonShare : (NSString*) type
{
    [SOXSoundUtil play_btn];
    NSString *Warning =NSLocalizedString(@"Warning", @"");
    NSString *NoInternet =NSLocalizedString(@"NoInternet", @"");
    NSString *NoSetAccount =NSLocalizedString(@"NoSetAccount", @"");
    if (self.netStatus == NotReachable) {
        
        [self showHuDByStr:Warning :NoInternet:G_ALERT_DELAY_TIMES];
    } else {
        if([SOXShareUtil chkIsSetAccount:type]){
            [SOXShareUtil showSharePage:type:[self getShowScore]:[SOXGameUtil getBaseRootView]];
        }else{
            [self showHuDByStr:Warning :NoSetAccount:G_ALERT_DELAY_TIMES];
        }
    }
 
}


- (void)toFacebook: (id) sender
{
    [self toCommonShare:SLServiceTypeFacebook];
}
- (void)toTwitter: (id) sender
{
     [self toCommonShare:SLServiceTypeTwitter];
   
}

- (void)toWeibo: (id) sender
{
    [self toCommonShare:SLServiceTypeSinaWeibo];
}
- (void)dealloc
{
    [_hud release];
    [_reach release];
    [super dealloc];
}
@end
