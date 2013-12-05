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
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
   // HttpRequest *hhh = [[HttpRequest alloc]init];
//    [hhh httpRequestForGet];
//    [hhh registerUserEmail:@"nba1000@foo.com" withPassWard:@"123123"];
    
    
    //[hhh loginUserName:@"nba1000@foo.com" withSalt:@"123123"];
    
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

@end
