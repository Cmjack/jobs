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

#ifdef RELEASE
#define SERVER_URL @"http://121.199.24.40:3000"
#else
#define SERVER_URL @"http://192.168.1.114:3000"
#endif

@implementation HttpRequest

-(id)init {
    if (self = [super init]) {
        NSLog(@"[HttpRequest init] server url: %@", SERVER_URL);
    }
    return self;
}

-(void)registerUserEmail:(NSString*)email withPassWard:(NSString*)passWord withType:(NSString*)type
{
    NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:email,@"email",passWord,@"password",type,@"type", nil];
     AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
     [manager POST:[NSString stringWithFormat:@"%@/register", SERVER_URL] parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"register:%@",responseObject);
        NSDictionary * dict = [responseObject objectForKey:@"data"];
        BOOL isSalt = NO;
        if ([dict objectForKey:@"salt"]!= NULL) {
            
            [DataModel setMyToken:[dict objectForKey:@"salt"]];
            [DataModel setUserId:[dict objectForKey:@"_id"]];
            [DataModel setUserName:email];
            [DataModel setPassword:passWord];
            [DataModel setLoginType:type];
            if ([[dict objectForKey:@"icon_url"] length]>0) {
                [DataModel setHeadURL:[dict objectForKey:@"icon_url"] ];
            }
            [DataModel shareData].isLogin = YES;
            
            [self httpRequestForGetResume];
            
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
    [manager POST:[NSString stringWithFormat:@"%@/login", SERVER_URL] parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"login:%@ ",responseObject);
        BOOL isSucess =NO;
        
        //NSDictionary *dict = (NSDictionary*)responseObject;
        if ([[[responseObject objectForKey:@"data"] objectForKey:@"salt"] length]>0) {
            //[self httpRequestForGetResume];
            [DataModel setMyToken:[dict objectForKey:@"salt"]];
            [DataModel setUserId:[dict objectForKey:@"_id"]];
            [DataModel setUserName:name];
            [DataModel setPassword:salt];
            [DataModel setLoginType:@"default"];
            if ([[dict objectForKey:@"icon_url"] length]>0) {
                [DataModel setHeadURL:[dict objectForKey:@"icon_url"] ];
            }

            [DataModel shareData].isLogin = YES;
            [self httpRequestForGetResume];
            
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
    
    [manager POST:[NSString stringWithFormat:@"%@/resume", SERVER_URL] parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"save resume:%@",responseObject);
       // [DataModel shareData].resumeDict = [NSMutableDictionary dictionaryWithDictionary:responseObject];

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"saveFail");
        
    }];
  
}

-(void)httpRequestForGetResume
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSDictionary * user = [NSDictionary dictionaryWithObject:[[NSUserDefaults standardUserDefaults]objectForKey:@"username"] forKey:@"username"];
    
   
    [manager GET:[NSString stringWithFormat:@"%@/resume", SERVER_URL] parameters:user success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"resume: %@", responseObject);
        [DataModel shareData].resumeDict = [NSMutableDictionary dictionaryWithDictionary:responseObject];
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
    [manager POST:[NSString stringWithFormat:@"%@/job", SERVER_URL] parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"saveSuccess");
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"saveFail");
    }];

}

-(void)httpRequestForPostJoinList:(NSDictionary*)dict
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:[NSString stringWithFormat:@"%@/myjoinlist", SERVER_URL] parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
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
    
    [manager GET:[NSString stringWithFormat:@"%@/job", SERVER_URL] parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
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
        if ([self.delegate respondsToSelector:@selector(getSinaLoginData:)]) {
            [self.delegate getSinaLoginData:responseObject];
        }

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"userinfo:ERROR:%@",error);
    }];

}

-(void)getRefreshJobMessage:(NSString*)_idString withkey:(NSString*)key
{
    NSDictionary *dict =@{@"id": _idString,@"key":key};
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];

    [manager GET:[NSString stringWithFormat:@"%@/job_timeline", SERVER_URL] parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"newData:%@",responseObject);
        NSArray *arr = [responseObject objectForKey:@"Data"];
        if ([self.delegate respondsToSelector:@selector(getRefreshJobMessage:)]) {
            
            [self.delegate getRefreshJobMessage:arr];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"newData-error:%@",error);
    }];

}
-(void)httpPostApplyJob:(NSDictionary*)dict
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager POST:[NSString stringWithFormat:@"%@/job/apple",SERVER_URL] parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"apply:%@",responseObject);
        NSLog(@"saveSuccess");
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"saveFail");
    }];

}
-(void)httpGetMyApplylist:(NSDictionary*)dict
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager GET:[NSString stringWithFormat:@"%@/myapplylist", SERVER_URL] parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"applylist:%@",responseObject);
        NSArray *arr = [responseObject objectForKey:@"data"];
        if ([self.delegate respondsToSelector:@selector(getApplyJobs:)]) {
            [self.delegate getApplyJobs:arr];
        }
       
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if ([self.delegate respondsToSelector:@selector(getApplyJobs:)]) {
            [self.delegate getApplyJobs:NULL];
        }
        NSLog(@"applylist _error%@",error);
    }];

}
-(void)httpGetApplylist:(NSDictionary*)dict//
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager GET:[NSString stringWithFormat:@"%@/resumelist", SERVER_URL] parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"applylist:%@",responseObject);
        NSArray *arr = [responseObject objectForKey:@"data"];
        if ([self.delegate respondsToSelector:@selector(getResume:)]) {
            [self.delegate getResume:arr];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if ([self.delegate respondsToSelector:@selector(getResume:)]) {
            [self.delegate getResume:NULL];
        }
        NSLog(@"applylist _error%@",error);
    }];
    
}
-(void)httpPostFile:(UIImage*)image
{
   // UIImage *image = [UIImage imageNamed:@"Avatar"];
    
    NSData *data = UIImagePNGRepresentation(image);
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:[NSString stringWithFormat:@"%@/file_updata", SERVER_URL] parameters:NULL constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:data name:@"avatar" fileName:[DataModel getUserName] mimeType:@"image/png"];
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"file :%@",responseObject);
        
        NSString *url = [[responseObject objectForKey:@"result"] objectForKey:@"url"];
        if (url.length >0) {
            [self httpPostUserInfo:url];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"file error:%@",error);
    }];
}

-(void)httpPostUserInfo:(NSString*)strURL
{
    NSString *username = [[NSUserDefaults standardUserDefaults]objectForKey:USERNAME];
    
    
    NSDictionary *dict = @{@"param": @{@"username": username, @"icon_url":strURL}};
    NSLog(@":%@",dict);
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:[NSString stringWithFormat:@"%@/user", SERVER_URL] parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"userinfo:%@",responseObject);
        
        [DataModel setHeadURL:strURL];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

+(BOOL)check
{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    NSLog(@"网络状态:%i",manager.networkReachabilityStatus);
    if (manager.networkReachabilityStatus == AFNetworkReachabilityStatusNotReachable) {
        
        
        UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:nil message:@"当前网络不可用！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
        return YES;
    }
    return NO;
}
+(BOOL)checkNotShowAlertView
{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    NSLog(@"%i",manager.networkReachabilityStatus);
    if (manager.networkReachabilityStatus == AFNetworkReachabilityStatusNotReachable) {
        
        return YES;
    }
    return NO;
}

-(void)amendResumeHeadURL:(NSString*)string
{
    NSString *userName = [DataModel getUserName];
    NSMutableDictionary *personDict = [[DataModel shareData].resumeDict objectForKey:KEY_PERSON];
    
    if (string.length >0) {
        NSString *head_url = [DataModel getHeadURL];
        [personDict setObject:head_url forKey:@"icon_url"];
    }
    NSDictionary *dictresume = [NSDictionary dictionaryWithObjectsAndKeys:personDict,KEY_PERSON,userName,@"username", nil];
    
    [HttpRequest httpRequestForSaveResume:dictresume];
    
    [[DataModel shareData].resumeDict setObject:personDict forKey:KEY_PERSON];
}
@end
