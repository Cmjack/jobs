//
//  SinaSDK.m
//  job
//
//  Created by caiming on 13-12-14.
//  Copyright (c) 2013年 impressly. All rights reserved.
//

#import "SinaSDK.h"
#import "WeiboSDK.h"
#import "headSetting.h"
@interface SinaSDK ()<WBHttpRequestDelegate>
@end
@implementation SinaSDK
- (void)ssoButtonPressed
{
    WBAuthorizeRequest *request = [WBAuthorizeRequest request];
    request.redirectURI = kRedirectURI;
    request.scope = @"all";
//    request.userInfo = @{@"SSO_From": @"SendMessageToWeiboViewController",
//                         @"Other_Info_1": [NSNumber numberWithInt:123],
//                         @"Other_Info_2": @[@"obj1", @"obj2"],
//                         @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
    [WeiboSDK sendRequest:request];
}

- (void)ssoOutButtonPressed
{
    NSString *token = [[NSUserDefaults standardUserDefaults]objectForKey:WEIBOTOKEN];
    [WeiboSDK logOutWithToken:token delegate:self withTag:@"user1"];
}




- (void)request:(WBHttpRequest *)request didFinishLoadingWithResult:(NSString *)result
{
    NSString *title = nil;
    UIAlertView *alert = nil;
    
    title = @"收到网络回调";
    alert = [[UIAlertView alloc] initWithTitle:title
                                       message:[NSString stringWithFormat:@"%@",result]
                                      delegate:nil
                             cancelButtonTitle:@"确定"
                             otherButtonTitles:nil];
    [alert show];
}

- (void)request:(WBHttpRequest *)request didFailWithError:(NSError *)error;
{
    NSString *title = nil;
    UIAlertView *alert = nil;
    
    title = @"请求异常";
    alert = [[UIAlertView alloc] initWithTitle:title
                                       message:[NSString stringWithFormat:@"%@",error]
                                      delegate:nil
                             cancelButtonTitle:@"确定"
                             otherButtonTitles:nil];
    [alert show];
}
-(void)request:(WBHttpRequest *)request didFinishLoadingWithDataResult:(NSData *)data
{
    
}
@end
