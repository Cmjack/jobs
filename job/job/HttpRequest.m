//
//  HttpRequest.m
//  job
//
//  Created by impressly on 13-12-3.
//  Copyright (c) 2013年 impressly. All rights reserved.
//

#import "HttpRequest.h"
#import <AFNetworking.h>
@implementation HttpRequest
-(void)httpRequestForGet{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:@"http://192.168.1.114:3000/job" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"job: %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

-(void)registerUserEmail:(NSString*)email withPassWard:(NSString*)passWord
{
    NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:email,@"email",passWord,@"password", nil];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:@"http://192.168.1.114:3000/register" parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"register:%@ ",responseObject);
        [[NSUserDefaults standardUserDefaults]setObject:responseObject forKey:@"userMesage"];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"error:%@",error);
        
    }];
}

-(void)loginUserName:(NSString*)name withSalt:(NSString*)salt
{
    NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:name,@"username",salt,@"password", nil];
    
    NSLog(@"login::::::%@",dict);
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:@"http://192.168.1.114:3000/login" parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"login:%@ ",responseObject);
        BOOL isSucess =NO;
        //NSDictionary *dict = (NSDictionary*)responseObject;
        
        if ([[responseObject objectForKey:@"result"]isEqualToString:@"yes"]) {
            
            NSLog(@"-");
            isSucess =YES;
        }
        
        if ([self.delegate respondsToSelector:@selector(loginSucessOrFail:)]) {
            
            NSLog(@"------");
            [self.delegate loginSucessOrFail:isSucess];
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"loginError:%@",error);
        
    }];
    
    
}
+(void)check
{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    NSLog(@"%i",manager.networkReachabilityStatus);
    
}
@end
