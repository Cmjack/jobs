//
//  HttpRequest.h
//  job
//
//  Created by impressly on 13-12-3.
//  Copyright (c) 2013年 impressly. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeiboSDK.h"
#import <TencentOpenAPI/TencentOAuth.h>

@protocol HttpRequestDelegate <NSObject>
@optional;
-(void)loginSucessOrFail:(BOOL)isSucess;
-(void)signSucessOrFail:(BOOL)isSucess;
-(void)getDataSucess:(NSDictionary*)dataDict;//获取招聘信息
-(void)getJoinMessage:(NSArray*)array;//获取用户已发招聘信息
-(void)getUserResumeMessage:(NSDictionary*)resumeMessage;
-(void)getRefreshJobMessage:(NSArray*)refreshMessage;
-(void)getResume:(NSArray*)resumeArray;//

-(void)getApplyJobs:(NSArray*)jobArrray;

-(void)getSinaLoginData:(NSDictionary*)dict;
@end

@interface HttpRequest : NSObject
@property(nonatomic, weak)id<HttpRequestDelegate> delegate;
//-(void)httpRequestForGet;
-(void)registerUserEmail:(NSString*)email withPassWard:(NSString*)passWord withType:(NSString*)type;
-(void)loginUserName:(NSString*)name withSalt:(NSString*)salt;
+(void)httpRequestForSaveResume:(NSDictionary*)dict;
-(void)httpRequestForGetResume;
-(void)httpRequestForPostJoinMessgae:(NSDictionary*)dict;
-(void)httpRequestForGetSearch:(NSString*)string withPage:(NSString*)stringPage;
-(void)sinaGetUserInfo:(NSDictionary*)dict;
-(void)httpRequestForPostJoinList:(NSDictionary*)dict;
-(void)getRefreshJobMessage:(NSString*)_idString withkey:(NSString*)key;
-(void)httpPostApplyJob:(NSDictionary*)dict;
-(void)httpGetMyApplylist:(NSDictionary*)dict;
-(void)httpGetApplylist:(NSDictionary*)dict;
-(void)httpPostFile:(UIImage*)image;
+(BOOL)check;
+(BOOL)checkNotShowAlertView;
@end
