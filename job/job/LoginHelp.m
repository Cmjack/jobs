//
//  LoginHelp.m
//  job
//
//  Created by caiming on 13-12-19.
//  Copyright (c) 2013年 impressly. All rights reserved.
//

#import "LoginHelp.h"
#import "headSetting.h"
#import "DataModel.h"
#import "HttpRequest.h"
#import "TecentSDK.h"
#import "SinaSDK.h"
@implementation LoginHelp
+(void)autoLogin
{
    NSString *tpye = [[NSUserDefaults standardUserDefaults]objectForKey:LOGINTYPE];
    NSString *username = [[NSUserDefaults standardUserDefaults]objectForKey:@"username"];
    NSString *password = [[NSUserDefaults standardUserDefaults]objectForKey:@"password"];
    
    NSLog(@"user:%@",username);
    NSLog(@"password:%@",password);
    
    if ([tpye isEqualToString:QQLOGIN]&&username.length >0) {
        
        [DataModel shareData].isLogin = YES;
    }
    else if([tpye isEqualToString:WEIBOLOGIN]&&username.length>0)
    {
        [DataModel shareData].isLogin = YES;
    
    }else if ([tpye isEqualToString:MYAPPLOGIN]&&username.length >0 && password.length >0)
    {
        [[[HttpRequest alloc]init]loginUserName:username withSalt:password];
    }
}

+(void)removeUserInfo
{
    NSString *tpye = [[NSUserDefaults standardUserDefaults]objectForKey:LOGINTYPE];

    if ([tpye isEqualToString:QQLOGIN]) {
        
        [[TecentSDK getinstance]tencentLogout];
        [DataModel shareData].isLogin = NO;
    }
    else if([tpye isEqualToString:WEIBOLOGIN])
    {
        [SinaSDK ssoOutButtonPressed];
        [DataModel shareData].isLogin = NO;
        
    }

    [[NSUserDefaults standardUserDefaults]removeObjectForKey:LOGINTYPE];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"username"];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"password"];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"userinfo"];
    
}
@end
