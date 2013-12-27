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
#import "LoginHelp.h"
#import "SinaSDK.h"
#import "TecentSDK.h"
#import <AFNetworkReachabilityManager.h>

@interface AppDelegate()
@end
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{

   
    
//    BOOL isNetWork = [HttpRequest checkNotShowAlertView];
//    if (!isNetWork) {
//        
//
//    }
    static BOOL islogin = NO;
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
       
       if(status == AFNetworkReachabilityStatusNotReachable)
        {
            islogin =NO;
            UIAlertView *alertview = [[UIAlertView alloc]initWithTitle:nil message:@"网络异常" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alertview show];
        }
        else
        {
            if (islogin == NO) {
                [LoginHelp autoLogin];
                islogin =YES;
            }
        }
        
        
    }];
    
    
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



-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    
    NSString *loginType = [[NSUserDefaults standardUserDefaults]objectForKey:LOGINTYPE];
    if ([loginType isEqualToString:QQLOGIN]) {
        [QQApiInterface handleOpenURL:url delegate:(id<QQApiInterfaceDelegate>)[TecentSDK getinstance]];
        
        return [TencentOAuth HandleOpenURL:url];
        
    }
    else if ([loginType isEqualToString:WEIBOLOGIN])
    {
        return [WeiboSDK handleOpenURL:url delegate:[SinaSDK shareSinaSdk]];

    }
    return YES;
}

//-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
//{
//    [QQApiInterface handleOpenURL:url delegate:(id<QQApiInterfaceDelegate>)[DataModel shareData]];
//    return [TencentOAuth HandleOpenURL:url];
//}
@end
