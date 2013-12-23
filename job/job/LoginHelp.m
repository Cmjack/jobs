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
    NSLog(@"type:%@",tpye);
    if ([tpye isEqualToString:QQLOGIN]&&username.length >0) {
        
        [[[HttpRequest alloc]init]registerUserEmail:username withPassWard:NULL withType:QQLOGIN];
        [DataModel shareData].isLogin = YES;
    }
    else if([tpye isEqualToString:WEIBOLOGIN]&&username.length>0)
    {
        [DataModel shareData].isLogin = YES;
        [[[HttpRequest alloc]init]registerUserEmail:username withPassWard:NULL withType:WEIBOLOGIN];
    
    }else if ([tpye isEqualToString:MYAPPLOGIN]&&username.length >0 && password.length >0)
    {
        [[[HttpRequest alloc]init]loginUserName:username withSalt:password];
    }
    
    
}

+(void)removeUserInfo
{
    NSString *tpye = [[NSUserDefaults standardUserDefaults]objectForKey:LOGINTYPE];
    [DataModel shareData].isLogin = NO;

    if ([tpye isEqualToString:QQLOGIN]) {
        
        [[TecentSDK getinstance]tencentLogout];
    }
    else if([tpye isEqualToString:WEIBOLOGIN])
    {
        [SinaSDK ssoOutButtonPressed];
        
    }
    [[DataModel shareData].resumeDict removeAllObjects];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:LOGINTYPE];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"username"];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"password"];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"userinfo"];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:MYAPPTOKEN];
}
@end
