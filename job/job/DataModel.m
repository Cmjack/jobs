//
//  DataModel.m
//  job
//
//  Created by impressly on 13-12-3.
//  Copyright (c) 2013年 impressly. All rights reserved.
//

#import "DataModel.h"
#import <TencentOpenAPI/TencentOAuth.h>
@implementation DataModel
+(DataModel*)shareData
{
    static DataModel * shareData ;
    if (shareData == nil) {
        shareData = [[DataModel alloc]init];
        shareData.resumeDict = [NSMutableDictionary dictionaryWithCapacity:10];
    }
    return shareData;
}

-(void)tencent
{
    TencentOAuth *tencentOAuth = [[TencentOAuth alloc]initWithAppId:@"100576079" andDelegate:self];
    
    NSArray * permissions = [NSArray arrayWithObjects:@"all", nil];
    [tencentOAuth authorize:permissions inSafari:YES];

}
-(void)tencentDidLogin
{
    NSLog(@"login");
}
- (void)getUserInfoResponse:(APIResponse*) response
{
    NSLog(@"%@",response);
}

-(void)tencentDidLogout
{
    
}
-(void)tencentDidNotNetWork
{
    
}
-(void)tencentDidNotLogin:(BOOL)cancelled
{
    
}
-(BOOL)onTencentReq:(TencentApiReq *)req
{
    return YES;
}
@end
