//
//  AppDelegate.m
//  job
//
//  Created by impressly on 13-12-3.
//  Copyright (c) 2013年 impressly. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "HttpRequest.h"
#import "WeiboSDK.h"
#import "headSetting.h"
#import  <TencentOpenAPI/TencentOAuth.h>
#import "TencentOpenAPI/QQApiInterface.h"
#import "DataModel.h"
@interface AppDelegate()<WeiboSDKDelegate>
@end
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{

    [WeiboSDK enableDebugMode:YES];
    
    NSLog(@"WeiboSDK:%i",[WeiboSDK registerApp:kAppKey]);
    
    
    NSString *username = [[NSUserDefaults standardUserDefaults]objectForKey:@"username"];
    NSString *password = [[NSUserDefaults standardUserDefaults]objectForKey:@"password"];
    NSLog(@"user:%@",username);
    NSLog(@"password:%@",password);
    [[[HttpRequest alloc]init]loginUserName:username withSalt:password];
    
    
    
    self.window =[[UIWindow alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    ViewController *rootView =[[ViewController alloc]initWithNibName:nil bundle:nil];
    UINavigationController *nac =[[UINavigationController alloc]initWithRootViewController:rootView];
    self.window.rootViewController = nac;
    [self.window makeKeyAndVisible];
    // Override point for customization after application launch.
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)didReceiveWeiboResponse:(WBBaseResponse *)response
{
    if ([response isKindOfClass:WBSendMessageToWeiboResponse.class])
    {
//        NSString *title = @"发送结果";
//        NSString *message = [NSString stringWithFormat:@"响应状态: %d\n响应UserInfo数据: %@\n原请求UserInfo数据: %@",
//                             response.statusCode, response.userInfo, response.requestUserInfo];
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
//                                                        message:message
//                                                       delegate:nil
//                                              cancelButtonTitle:@"确定"
//                                              otherButtonTitles:nil];
//        [alert show];
    }
    else if ([response isKindOfClass:WBAuthorizeResponse.class])
    {
//        NSString *title = @"认证结果";
//        NSString *message = [NSString stringWithFormat:@"响应状态: %d\nresponse.userId: %@\nresponse.accessToken: %@\n响应UserInfo数据: %@\n原请求UserInfo数据: %@",
//                             response.statusCode, [(WBAuthorizeResponse *)response userID], [(WBAuthorizeResponse *)response accessToken], response.userInfo, response.requestUserInfo];
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
//                                                        message:message
//                                                       delegate:nil
//                                              cancelButtonTitle:@"确定"
//                                              otherButtonTitles:nil];
//        [alert show];
        
        [[NSUserDefaults standardUserDefaults]setObject:[(WBAuthorizeResponse *)response accessToken] forKey:WEIBOTOKEN];
        NSLog(@"%@\n",response.userInfo);
        NSLog(@"%@\n",[(WBAuthorizeResponse *)response userID]);
        NSLog(@"%@\n",response.requestUserInfo);
        
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:[(WBAuthorizeResponse *)response accessToken],@"access_token",[(WBAuthorizeResponse *)response userID],@"uid", nil];
        
        
        [[[HttpRequest alloc]init]sinaGetUserInfo:dict];
        
    }
    
   
    
    
}
-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    
    NSString *loginType = [[NSUserDefaults standardUserDefaults]objectForKey:LOGINTYPE];
    if ([loginType isEqualToString:QQLOGIN]) {
        [QQApiInterface handleOpenURL:url delegate:(id<QQApiInterfaceDelegate>)[DataModel shareData]];
        
        return [TencentOAuth HandleOpenURL:url];
        
    }
    else if ([loginType isEqualToString:WEIBOLOGIN])
    {
        return [WeiboSDK handleOpenURL:url delegate:self];

    }
    return YES;
}

//-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
//{
//    [QQApiInterface handleOpenURL:url delegate:(id<QQApiInterfaceDelegate>)[DataModel shareData]];
//    return [TencentOAuth HandleOpenURL:url];
//}
@end
