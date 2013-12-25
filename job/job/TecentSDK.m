//
//  TecentSDK.m
//  job
//
//  Created by caiming on 13-12-13.
//  Copyright (c) 2013年 impressly. All rights reserved.
//

#import "TecentSDK.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/TencentApiInterface.h>
#import <TencentOpenAPI/TencentOAuthObject.h>
#import "HttpRequest.h"
#import "headSetting.h"
#import "DataModel.h"
static TecentSDK *g_instance = nil;
@implementation TecentSDK
@synthesize oauth = _oauth;

+(id)getinstance
{
    @synchronized(self)
    {
        if (nil == g_instance)
        {
            g_instance = [[super allocWithZone:nil] init];
            
        }
    }
    
    return g_instance;
}
+ (id)allocWithZone:(NSZone *)zone
{
    return [self getinstance];
}
- (id)init
{
    
    NSString *appid = @"100576079";
    _oauth = [[TencentOAuth alloc] initWithAppId:appid
                                     andDelegate:self];
    [DataModel setLoginType:QQLOGIN];
    return self;
}

- (void)tencentDidLogin
{
    NSLog(@"-----授权成功！！！");
    
    [_oauth getUserInfo];
    NSLog(@"%@",[_oauth accessToken]);
    
//    NSString * qqUserName = [NSString stringWithFormat:@"%@",[_oauth openId]];
//    [[[HttpRequest alloc]init]registerUserEmail:qqUserName withPassWard:@"1234" withType:@"qq" ];
}

- (void)getUserInfoResponse:(APIResponse*) response
{
    NSDictionary *userInfo = response.jsonResponse;
    [DataModel setNickName:[userInfo objectForKey:@"nickname"]];
    [DataModel setHeadURL:[userInfo objectForKey:@"figureurl_qq_2"]];
    
    HttpRequest * http = [[HttpRequest alloc]init];
    http.delegate = self;
    NSString * qqUserName = [NSString stringWithFormat:@"%@",[_oauth openId]];

    [http registerUserEmail:qqUserName withPassWard:@"1234" withType:QQLOGIN];
    
}
#pragma mark --- httpdelegate
-(void)signSucessOrFail:(BOOL)isSucess
{
    if ([self.delegate respondsToSelector:@selector(tencentLoginIsSuccess: withDict:)]) {
        
        [self.delegate tencentLoginIsSuccess:YES withDict:NULL];
    }
}
#pragma mark ---

- (void)tencentDidNotLogin:(BOOL)cancelled
{
   
}

- (void)tencentDidNotNetWork
{
}
- (NSArray *)getAuthorizedPermissions:(NSArray *)permissions withExtraParams:(NSDictionary *)extraParams
{
    NSLog(@"%@---",permissions);
    NSLog(@"%@---",extraParams);
    return permissions;
}

- (BOOL)tencentNeedPerformIncrAuth:(TencentOAuth *)tencentOAuth withPermissions:(NSArray *)permissions
{
    BOOL incrAuthRes = [tencentOAuth incrAuthWithPermissions:permissions];
    return !incrAuthRes;
}


- (BOOL)tencentNeedPerformReAuth:(TencentOAuth *)tencentOAuth
{
    return YES;
}

- (void)tencentDidUpdate:(TencentOAuth *)tencentOAuth
{
}


- (void)tencentFailedUpdate:(UpdateFailType)reason
{
    
}




-(void)tencentLogout
{
    [_oauth logout:self];
    
}
-(void)tencentDidLogout
{
    NSLog(@"logout");
}
- (void)getVipInfoResponse:(APIResponse*) response
{
    NSLog(@"respone---%@",response.jsonResponse);

}
@end
