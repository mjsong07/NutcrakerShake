//
//  SOXMapUtil.m
//  SoxFrame
//
//  Created by jason yang on 13-5-27.
//
//

#import "SOXShareUtil.h"  
 
@implementation SOXShareUtil
 
//显示 分享页面
+ (void)showSharePage: (NSString*)shareType :(NSString*)content :(UIViewController*) baseRootView
{  
    SLComposeViewController *currentComposeViewController = [SLComposeViewController composeViewControllerForServiceType:shareType];
    if(currentComposeViewController == nil){
    
    }else{
        [currentComposeViewController setInitialText:content];
        // [currentComposeViewController addImage:[UIImage imageNamed:@"Default.png"]];
        UIImage *image= [SOXGameUtil makeaShot];
        [currentComposeViewController addImage:image];
        [currentComposeViewController addURL:[NSURL URLWithString:G_KEY_SOX_NUTCRACKER_URL]];
        currentComposeViewController.completionHandler = ^(SLComposeViewControllerResult result){
            switch (result)
            {
                case SLComposeViewControllerResultDone:
                    //                [SOXUtil showAlert:G_ALERT_TITLE_INFO :@"Share success!"];
                    break;
                case SLComposeViewControllerResultCancelled:
                    //[SOXUtil showAlert:@"Info!" :@"fail"];
                default:
                    break;
            }
            [currentComposeViewController	dismissViewControllerAnimated:YES
                                                             completion:nil];
        };
        [baseRootView presentModalViewController: currentComposeViewController animated: YES];
    } 
}

+ (bool)chkIsSetAccount: (NSString*)shareType
{
    SLComposeViewController *currentComposeViewController = [SLComposeViewController composeViewControllerForServiceType:shareType];
    if(currentComposeViewController != nil){
        return true;
    }else{
        return false;
    }
}


/*  备用 截图代码
-(bool)shareInfo:(UIImage*)img_{
    ACAccountStore *account = [[ACAccountStore alloc] init];
    ACAccountType *accountType = [account accountTypeWithAccountTypeIdentifier:
                                  ACAccountTypeIdentifierSinaWeibo];
    [account requestAccessToAccountsWithType:accountType options:nil
     
                                  completion:^(BOOL granted, NSError *error)
     
     {
         if (granted == YES)
         {
             NSArray *arrayOfAccounts = [account accountsWithAccountType:accountType];
             ACAccount *ac;
             if([arrayOfAccounts count] > 0)
             {
                 ac = [arrayOfAccounts objectAtIndex:0];
             }
             //  UIImage *img = img_ ;
             UIImage *img =[UIImage imageNamed:@"sox-logo.png"];
             NSURL *url = [NSURL URLWithString:@"https://upload.api.weibo.com/2/statuses/upload.json"];
             NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"SLRequest post pic.", @"status", img, @"pic", nil];
             SLRequest  *m_pSLRequest = [SLRequest requestForServiceType:SLServiceTypeSinaWeibo
                                                           requestMethod:SLRequestMethodPOST
                                                                     URL:url
                                                              parameters:params];
             [m_pSLRequest setAccount:ac];
             [m_pSLRequest performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
                 dispatch_async(dispatch_get_main_queue(), ^{
                     
                     NSString *response = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
                     NSLog(@"Post comment result:%@",response);
                     [response release];
                     
                   //  id jsonObj = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:&error];
                 });
             }]; 
         }else{
             [SOXDebug logStr:@"sns no login"];
         }
         
     }];
    return false;
}
*/
 
@end
