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
#import "headSetting.h"
#import <TencentOpenAPI/TencentOAuth.h>
#define LOCALURL @"http://192.168.1.114:3000/job"
#define NETURL @"http://121.199.24.40:3000/job"

@implementation HttpRequest




-(void)httpRequestForGet{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:LOCALURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
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
        NSLog(@"register:%@",responseObject);
        BOOL isSalt = NO;
        if ([responseObject objectForKey:@"salt"]!= NULL) {
            isSalt = YES;
        }
        
        if ([self.delegate respondsToSelector:@selector(signSucessOrFail:)]) {
            
            [self.delegate signSucessOrFail:isSalt];
        }
        
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
            //[self httpRequestForGetResume];

            NSLog(@"sss");
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
+(void)httpRequestForSaveResume:(NSDictionary*)dict{
    

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
   
    manager.requestSerializer  = [AFJSONRequestSerializer serializer];
    
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
        //[DataModel shareData].resumeDict = [NSMutableDictionary dictionaryWithDictionary:responseObject];
        if ([self.delegate respondsToSelector:@selector(getUserResumeMessage:)]) {
            
            [self.delegate getUserResumeMessage:responseObject];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if ([self.delegate respondsToSelector:@selector(getUserResumeMessage:)]) {
            
            [self.delegate getUserResumeMessage:NULL];
        }
        
    }];
}
-(void)httpRequestForPostJoinMessgae:(NSDictionary*)dict
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:@"http://192.168.1.114:3000/job" parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"saveSuccess");
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"saveFail");
    }];

}

-(void)httpRequestForPostJoinList:(NSDictionary*)dict
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:@"http://192.168.1.114:3000/myjoinlist" parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"list:%@",responseObject);
        if ([self.delegate respondsToSelector:@selector(getJoinMessage:)])
        {
            [self.delegate getJoinMessage:responseObject];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
       
        NSLog(@"list _error%@",error);
    }];
    
}

-(void)httpRequestForGetSearch:(NSString*)string withPage:(NSString*)stringPage
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSDictionary *dictTitle = [NSDictionary dictionaryWithObjectsAndKeys:string,@"title", nil];

    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:dictTitle,@"param",stringPage,@"page", nil];
    
    [manager GET:@"http://192.168.1.114:3000/job" parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"searchResume: %@", responseObject);
        if ([self.delegate respondsToSelector:@selector(getDataSucess:)])
        {
            [self.delegate getDataSucess:responseObject];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"resume:ERROR:%@",error);
    }];
}

-(void)sinaGetUserInfo:(NSDictionary*)dict
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager GET:@"https://api.weibo.com/2/users/show.json" parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
       // NSLog(@"userinfo: %@", responseObject);
        [[NSNotificationCenter defaultCenter]postNotificationName:@"weibologin" object:nil userInfo:responseObject];

        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"userinfo:ERROR:%@",error);
    }];

}

-(void)getRefreshJobMessage:(NSString*)_idString
{
    NSDictionary *dict =@{@"id": _idString};
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];

    [manager GET:@"http://192.168.1.114:3000/job_timeline" parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"newData:%@",responseObject);
        NSArray *arr = [responseObject objectForKey:@"Data"];
        if ([self.delegate respondsToSelector:@selector(getRefreshJobMessage:)]) {
            
            [self.delegate getRefreshJobMessage:arr];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"newData-error:%@",error);
    }];

}

+(void)check
{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    NSLog(@"%i",manager.networkReachabilityStatus);
    
}


@end
