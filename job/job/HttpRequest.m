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
    [manager GET:LOCALURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
    NSLog(@"job: %@", responseObject);
//        DataModel *data = [DataModel shareData];
//        data.shareData = responseObject;
        NSArray *arr = [responseObject objectForKey:@"Data"];
        if ([self.delegate respondsToSelector:@selector(getDataSucess:)])
        {
            [self.delegate getDataSucess:arr];
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
        
        BOOL isSalt = NO;
        [DataModel shareData].isLogin = NO;
        if ([responseObject objectForKey:@"salt"]!= NULL) {
            [DataModel shareData].isLogin = YES;
            isSalt = YES;
        }
        
        if ([self.delegate respondsToSelector:@selector(signSucessOrFail:)]) {
            
            [self.delegate signSucessOrFail:isSalt];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [DataModel shareData].isLogin = NO;
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
        [DataModel shareData].isLogin = NO;
        if ([[responseObject objectForKey:@"result"]isEqualToString:@"yes"]) {
            [self httpRequestForGetResume];

            [DataModel shareData].isLogin = YES;
            NSLog(@"sss");
            isSucess =YES;
        }
        
        if ([self.delegate respondsToSelector:@selector(loginSucessOrFail:)]) {
            
            [self.delegate loginSucessOrFail:isSucess];
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [DataModel shareData].isLogin = NO;
        if ([self.delegate respondsToSelector:@selector(loginSucessOrFail:)]) {
            
            
            [self.delegate loginSucessOrFail:NO];
        }
        NSLog(@"loginError:%@",error);
        
    }];
    
    
}
+(void)httpRequestForSaveResume:(NSDictionary*)dict{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:@"http://192.168.1.114:3000/resume" parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"saveSuccess");
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"saveFail");
    }];
  
}

-(void)httpRequestForGetResume
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSDictionary * user = [NSDictionary dictionaryWithObject:[[NSUserDefaults standardUserDefaults]objectForKey:@"username"] forKey:@"username"];
    NSLog(@"user:%@",user);
    [manager GET:@"http://192.168.1.114:3000/resume" parameters:user success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"resume: %@", responseObject);
        [DataModel shareData].resumeDict = [NSMutableDictionary dictionaryWithDictionary:responseObject];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"resume:ERROR:%@",error);
        
    }];
}
-(void)httpRequestForPostJoinMessgae:(NSDictionary*)dict
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:@"http://192.168.1.114:3000/join" parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"saveSuccess");
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"saveFail");
    }];

}


-(void)httpRequestForGetSearch:(NSString*)string withPage:(NSString*)stringPage
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSDictionary *dictTitle = [NSDictionary dictionaryWithObjectsAndKeys:string,@"title", nil];

    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:dictTitle,@"param",stringPage,@"page", nil];
    
    [manager GET:@"http://192.168.1.114:3000/job" parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"searchResume: %@", responseObject);
        NSArray *arr = [responseObject objectForKey:@"Data"];
        if ([self.delegate respondsToSelector:@selector(getDataSucess:)])
        {
            [self.delegate getDataSucess:arr];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"resume:ERROR:%@",error);
    }];
}

+(void)check
{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    NSLog(@"%i",manager.networkReachabilityStatus);
    
}
@end
