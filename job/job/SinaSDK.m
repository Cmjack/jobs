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
#import "HttpRequest.h"
#import "DataModel.h"
@interface SinaSDK ()<WBHttpRequestDelegate,WeiboSDKDelegate,HttpRequestDelegate>
@end
@implementation SinaSDK
+(id)shareSinaSdk
{
    
    static SinaSDK *g_instance = nil;

    @synchronized(self)
    {
        if (nil == g_instance)
        {
            g_instance = [[super allocWithZone:nil] init];
            
        }
    }
    
    return g_instance;
}

- (void)ssoButtonPressed
{
    [WeiboSDK enableDebugMode:YES];
    NSLog(@"WeiboSDK:%i",[WeiboSDK registerApp:kAppKey]);
    
    WBAuthorizeRequest *request = [WBAuthorizeRequest request];
    request.redirectURI = kRedirectURI;
    request.scope = @"all";
//    request.userInfo = @{@"SSO_From": @"SendMessageToWeiboViewController",
//                         @"Other_Info_1": [NSNumber numberWithInt:123],
//                         @"Other_Info_2": @[@"obj1", @"obj2"],
//                         @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
    [WeiboSDK sendRequest:request];
    
    [DataModel setLoginType:WEIBOLOGIN];
    
}

//sso 回调方法。。
-(void)didReceiveWeiboRequest:(WBBaseRequest *)request
{
    
}
- (void)didReceiveWeiboResponse:(WBBaseResponse *)response
{
    if ([response isKindOfClass:WBSendMessageToWeiboResponse.class])
    {
        
    }
    else if ([response isKindOfClass:WBAuthorizeResponse.class])
    {
        
        [[NSUserDefaults standardUserDefaults]setObject:[(WBAuthorizeResponse *)response accessToken] forKey:WEIBOTOKEN];
        NSLog(@"token %@",[(WBAuthorizeResponse *)response accessToken]);
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:[(WBAuthorizeResponse *)response accessToken],@"access_token",[(WBAuthorizeResponse *)response userID],@"uid", nil];
        [DataModel setUserName:[dict objectForKey:@"uid"]];
        HttpRequest *http = [[HttpRequest alloc]init];
        http.delegate = self;
        [http sinaGetUserInfo:dict];
    }
}
#pragma mark - HttpRequestDelegate
-(void)getSinaLoginData:(NSDictionary *)dict
{
    NSLog(@"%@",dict);
    [DataModel setHeadURL:[dict objectForKey:@"avatar_large"]];
    [DataModel setNickName:[dict objectForKey:@"screen_name"]];
    HttpRequest *http = [[HttpRequest alloc]init];
    http.delegate = self;
    [http registerUserEmail:[DataModel getUserName] withPassWard:@"1234" withType:WEIBOLOGIN];
}
-(void)signSucessOrFail:(BOOL)isSucess
{
   
    if ([self.delegate respondsToSelector:@selector(sinaLoginSuccess)]) {
        [self.delegate sinaLoginSuccess];
    }
}
#pragma mark -
#pragma mark - 多余的。。。

- (void)request:(WBHttpRequest *)request didFinishLoadingWithResult:(NSString *)result
{
   
}

- (void)request:(WBHttpRequest *)request didFailWithError:(NSError *)error;
{

}
-(void)request:(WBHttpRequest *)request didFinishLoadingWithDataResult:(NSData *)data
{
    
}
-(void)request:(WBHttpRequest *)request didReceiveResponse:(NSURLResponse *)response
{
    
}



@end
