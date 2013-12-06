//
//  HttpRequest.m
//  job
//
//  Created by impressly on 13-12-3.
//  Copyright (c) 2013年 impressly. All rights reserved.
//

#import "HttpRequest.h"
#import <AFNetworking.h>
#import "DataModel.h"
#define LOCALURL @"http://192.168.1.114:3000/job"
#define NETURL @"http://121.199.24.40:3000/job"

@implementation HttpRequest
-(void)httpRequestForGet{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:NETURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"job: %@", responseObject);
//        DataModel *data = [DataModel shareData];
//        data.shareData = responseObject;
        if ([self.delegate respondsToSelector:@selector(getDataSucess:)])
        {
            [self.delegate getDataSucess:responseObject];
        }
    
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
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if ([self.delegate respondsToSelector:@selector(signSucessOrFail:)]) {
            [self.delegate signSucessOrFail:NO];
        }
        
        
    }];
}

-(void)loginUserName:(NSString*)name withSalt:(NSString*)salt
{
    NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:name,@"username",salt,@"password", nil];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:@"http://192.168.1.114:3000/login" parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"login:%@ ",responseObject);
        BOOL isSucess =NO;
        //NSDictionary *dict = (NSDictionary*)responseObject;
        
        if ([[responseObject objectForKey:@"result"]isEqualToString:@"yes"]) {
            
            
            isSucess =YES;
        }
        
        if ([self.delegate respondsToSelector:@selector(loginSucessOrFail:)]) {
            
           
            [self.delegate loginSucessOrFail:isSucess];
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if ([self.delegate respondsToSelector:@selector(loginSucessOrFail:)]) {
            
            
            [self.delegate loginSucessOrFail:NO];
        }

        NSLog(@"loginError:%@",error);
        
    }];
    
    
}
+(void)check
{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    NSLog(@"%i",manager.networkReachabilityStatus);
    
}
@end
